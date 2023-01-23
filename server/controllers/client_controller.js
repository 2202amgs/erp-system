const Client = require('../models/Client');
const singleClientData = require('../shared/client_function');
const Transfer = require('../models/Transfer');
const Shipment = require('../models/Shipment');
const BuyGoods = require('../models/BuyGoods');
const ObjectsNames = require('../constant/objects-names');

async function create(req, res){
	try{
		req.body.userId = req.user.id;
		let client = new Client(req.body);
		client = await client.save();
		// Response
		res.status(200).json({message: '...تمت الإضافة', client: client._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update(req, res) {
	try {
		const client = await Client.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true});
		if(!client) return res.status(400).json({message: '...غير موجود'});
		res.status(200).json({message: '...تم التعديل', client});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function remove (req, res)  {
	try {
		const client = await Client.findByIdAndDelete(req.params.id);
		if(!client) return res.status(400).json({message: '...غير مسجل'});
		res.status(200).json({message: '...تم الحذف'});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function getALl(req, res){
	try{
		const clients = await Client.find({isClient: req.query.isClient});
        res.status(200).json(clients);
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function show(req, res) {
	try{
		let startDate = new Date(req.query.start);
		let endDate = new Date(req.query.end );
		endDate.setUTCHours(23,59,59,999);
		
		// Ge Client
		const client = await Client.findById(req.params.id);
		if(!client) return res.status(400).json({message: '...غير موجود'});

		// Get Shipments
		const shipments = await Shipment.find({clientId: client._id,  date: { "$gte": startDate, "$lte": endDate}});
		const buyGoods = await BuyGoods.find({supplierId: client._id,  date: { "$gte": startDate, "$lte": endDate}});

		// Get Transfers
		const transfers = await Transfer.find({
			$and: [
				{ $or: [
					{senderId: client._id, senderType: ObjectsNames.client},
					{receiverId: client._id, receiverType: ObjectsNames.client}
				]},
				{  date: { "$gte": startDate, "$lte": endDate} }
			]
		});


		const data = await singleClientData(client, transfers, shipments, buyGoods, startDate);

		res.status(200).json({client, data, shipments, transfers, buyGoods});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

module.exports = {getALl, create, update, remove, show};