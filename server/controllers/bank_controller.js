const Bank = require('../models/Bank');
const Transfer = require('../models/Transfer');
const ObjectsNames = require("../constant/objects-names");

async function create(req, res){
    try{
		req.body.userId = req.user.id;
		let bank = new Bank(req.body);
		bank = await bank.save();
		// Response
        const message = bank.isBank ? '...تمت إضافة بنك جديد' : '...تمت إضافة خزينة جديدة'
		res.status(200).json({message , bank: bank._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update(req, res) {
    try {
		const bank = await Bank.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true});
		if(!bank) return res.status(400).json({message: '...غير مسجل'});
		res.status(200).json({message: '...تم التعديل', bank});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function remove (req, res)  {
    try {
		const bank = await Bank.findByIdAndDelete(req.params.id);
		if(!bank) return res.status(400).json({message: '...غير مسجل'});
        const message = bank.isBank ? '...تم حذف البنك' : '...تم حذف الخزينة'
		res.status(200).json({message});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function getAll (req, res)  {
    try{
        const banks = await Bank.find({isBank: req.query.isBank});
        res.status(200).json(banks);
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
		const bank = await Bank.findById(req.params.id);
		if(!bank) return res.status(400).json({message: '...البنك غير موجود'});
		
        // Get Transfers
		const transfers = await Transfer.find({
			$and: [
				{ $or: [
					{senderId: bank._id, senderType: ObjectsNames.bank},
					{receiverId: bank._id, receiverType: ObjectsNames.bank}
				]},
				{  date: { "$gte": startDate, "$lte": endDate} }
			]
		});

		// Get Total  Of Receive Transfer
         const receiveTransfers = await Transfer.aggregate([
            {$match: {receiverId: bank._id, receiverType: ObjectsNames.bank}},
            {$group: {_id: "$receiverId", total: {$sum: "$amount"}}}
        ]);
        // Get Total Of Send Transfer
		const sendTransfers = await Transfer.aggregate([
            {$match: {senderId: bank._id, senderType: ObjectsNames.bank}},
            {$group: {_id: "$senderId", total: {$sum: "$amount"}}}
        ]);

        // Calculate Total
        let total = 0;
        if (receiveTransfers.length > 0) {
            total += receiveTransfers[0]['total'];
        }
        if (sendTransfers.length > 0) {
            total -= sendTransfers[0]['total'];
        }
		
        res.status(200).json({bank, transfers, total});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}


module.exports = {create, update, remove, getAll, show};