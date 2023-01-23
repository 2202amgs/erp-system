const TypeGoods = require("../models/TypeGoods");
const BuyGoods = require("../models/BuyGoods");
const Shipment = require("../models/Shipment");

async function create(req, res){
    try{
		req.body.userId = req.user.id;
		let typeGoods = new TypeGoods(req.body);
		typeGoods = await typeGoods.save();
		// Response
		res.status(200).json({message: '...تمت إضافة صنف جديد', typeGoods: typeGoods._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update(req, res) {
    try {
		const typeGoods = await TypeGoods.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true});
		if(!typeGoods) return res.status(400).json({message: '...الصنف غير موجود'});
		res.status(200).json({message: '...تم التعديل', typeGoods});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function remove (req, res)  {
    try {
		const typeGoods = await TypeGoods.findByIdAndDelete(req.params.id);
		if(!typeGoods) return res.status(400).json({message: '...الصنف غير موجود'});
		res.status(200).json({message: '...تم حذف الصنف'});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function getAll (req, res)  {
    try{
		const typeGoods = await TypeGoods.find();
        res.status(200).json(typeGoods);
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function show (req, res)  {
    try{
		let startDate = new Date(req.query.start);
		let endDate = new Date(req.query.end );
		endDate.setUTCHours(23,59,59,999);
		// Get Type Goods
		const typeGoods = await TypeGoods.findById(req.params.id);
		if(!typeGoods) return res.status(400).json({message: '...الصنف غير موجود'});
		
		// Get Shipments List In Range
		const shipments = await Shipment.find({typeGoodsId: typeGoods._id,  date: { "$gte": startDate, "$lte": endDate}});
		// Get Buy Goods Range
		const buyGoods = await BuyGoods.find({typeGoodsId: typeGoods._id,  date: { "$gte": startDate, "$lte": endDate}});
		
		// Calculate Total
		const totalShipments = await Shipment.aggregate([
			{$match: {typeGoodsId: typeGoods._id}},
			{$group: {_id: "$typeGoodsId", total: {$sum: "$quantity"}}}
		]);
		const totalBuyGoods = await BuyGoods.aggregate([
			{$match: {typeGoodsId: typeGoods._id}},
			{$group: {_id: "$typeGoodsId", total: {$sum: "$quantity"}}}
		])

		let quantity = 0;
		if (totalBuyGoods.length > 0) {
			quantity += totalBuyGoods[0].total;
		}
		if (totalShipments.length > 0) {
			quantity -= totalShipments[0].total;
		}

        res.status(200).json({typeGoods, shipments, buyGoods, quantity});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}



module.exports = {create, update, remove, getAll, show};