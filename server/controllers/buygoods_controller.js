const BuyGoods = require('../models/BuyGoods');
const Car = require('../models/Car');
const Client = require('../models/Client');
const TypeGoods = require('../models/TypeGoods');

async function create(req, res){
    try{
        const supplier = await Client.findById(req.body.supplierId);
		if(!supplier) return res.status(400).json({message: '...المورد غير موجود'});

        const typeGoods = await TypeGoods.findById(req.body.typeGoodsId);
		if(!typeGoods) return res.status(400).json({message: '...الصنف غير موجود'});

        let body = {
            userId: req.user.id,
            supplierId: req.body.supplierId,
            typeGoodsId: req.body.typeGoodsId,
            // Data
	        typeGoodsName: typeGoods.name,
	        description: req.body.description,
            poneName: req.body.poneName,
            amount: req.body.amount,
            quantity: req.body.quantity,
        };
        if(req.body.carId){
            const car = await Car.findById(req.body.carId);
            if(!car) return res.status(400).json({message: '...السيارة غير موجودة'});
            body['carNumber'] = car.carNumber;
            body['driverName'] = car.driverName;
        };

		let buyGoods = new BuyGoods(body);
		buyGoods = await buyGoods.save();
		// Response
		res.status(200).json({message: 'تم تسجيل الكمية' , buyGoods: buyGoods._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update(req, res) {
    try {
        const supplier = await Client.findById(req.body.supplierId);
		if(!supplier) return res.status(400).json({message: '...المورد غير موجود'});

        const typeGoods = await TypeGoods.findById(req.body.typeGoodsId);
		if(!typeGoods) return res.status(400).json({message: '...الصنف غير موجود'});

        let body = {
            userId: req.user.id,
            supplierId: req.body.supplierId,
            typeGoodsId: req.body.typeGoodsId,
            // Data
	        typeGoodsName: typeGoods.name,
	        description: req.body.description,
            poneName: req.body.poneName,
            amount: req.body.amount,
            quantity: req.body.quantity,
        };

        if(req.body.carId){
            const car = await Car.findById(req.body.carId);
            if(!car) return res.status(400).json({message: '...السيارة غير موجودة'});
            body['carNumber'] = car.carNumber;
            body['driverName'] = car.driverName;
        };

		const buyGoods = await BuyGoods.findByIdAndUpdate(req.params.id, {$set: body}, {new: true});
		if(!buyGoods) return res.status(400).json({message: '...كمية غير مسجلة'});
		res.status(200).json({message: '...تم التعديل', buyGoods});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function remove (req, res)  {
    try {
		const buyGoods = await BuyGoods.findByIdAndDelete(req.params.id);
		if(!buyGoods) return res.status(400).json({message: '...كمية غير مسجلة'});
		res.status(200).json({message: '...تم حذف الدفعة'});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

module.exports = {create, update, remove};