const Shipment = require("../models/Shipment");
const {totalCalc, setCarData, setBankData, setTypeGoodskData, setClientData, decrementAccount, incrementAccount } = require("../shared/shipment_functions");

// Creat and update one shipment
async function create(req, res){
	try{
		if(!req.body.carId && !req.body.typeGoodsId) return res.status(400).json({message: '... هذه ليست عملية تجارية اختر السيارة'});
		let date = new Date(req.body.date);

		let data = {
			...req.body,
			userId: req.user.id,
			date
		};
		
		// Get Bank
		const bankData = await setBankData(req.body, data);
		data = {...bankData};
		
		// Get TypeGoods
		const typeGoodsData = await setTypeGoodskData(req.body, data);
		data = {...typeGoodsData};

		// Get Client
		const clientData = await setClientData(req.body, data);
		data = {
			...clientData,
            ...totalCalc(req.body, data),
		};

		// Get Car
		const carData = await setCarData(req.body, data);
		data = {...carData}
        // Response
		const shipment = await Shipment.create(data);
		if(!shipment) return res.status(400).json({message: '...العملية غير موجودة'});
		await incrementAccount(shipment);
		res.status(200).json({message: '...تمت إضافة العملية', shipment: shipment._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update (req, res){
	try{
		if(!req.body.carId && !req.body.typeGoodsId) return res.status(400).json({message: '... هذه ليست عملية تجارية اختر السيارة'});
		let date = new Date(req.body.date);

		let data = {
			...req.body,
			date
		};
		
		// Get Bank
		const bankData = await setBankData(req.body, data);
		data = {...bankData};
		
		// Get TypeGoods
		const typeGoodsData = await setTypeGoodskData(req.body, data);
		data = {...typeGoodsData};

		// Get Client
		const clientData = await setClientData(req.body, data);
		data = {
			...clientData,
            ...totalCalc(req.body, data),
		};

		// Get Car
		const carData = await setCarData(req.body, data);
		data = {...carData}

        // Get Old Data
		const oldShipment = await Shipment.findById(req.params.id);
		if(!oldShipment) return res.status(400).json({message: '...العملية غير موجودة'});
		data.userId = oldShipment.userId;
		// Set New Data
		const shipment = await Shipment.findOneAndReplace({_id: req.params.id}, data, {new: true});
		if(!shipment) return res.status(400).json({message: '...العملية غير موجودة'});
		// Update Account
		await decrementAccount(shipment);
		await incrementAccount(shipment);

		res.status(200).json({message: '...تم التعديل', shipment});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

// Remove one shipment
async function remove(req, res) {
    try {
        const shipment = await Shipment.findByIdAndDelete(req.params.id);
        if(!shipment) return res.status(400).json({message: '...النقلة غير موجودة'});
		await decrementAccount(shipment);

        res.status(200).json({message: '...تم الحذف '});
    } catch (error) {
        res.status(500).json({message: error.message});
    }
}

// Get colletion of shipments by date
async function getByDate(req, res) {
    try{
        const day = new Date(req.query.date);
        const shipments = await Shipment.find({date: {$eq: day}});
        res.status(200).json(shipments);
    } catch(error){
        res.status(500).json({message: error.message});
    }
}

module.exports = {create, update, remove, getByDate};