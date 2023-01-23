const Transfer = require('../models/Transfer');
const ObjectsNames = require("../constant/objects-names");
const Debit = require('../models/Debit');

async function create(req, res){
    try{
		req.body.userId = req.user.id;
		let debit = new Debit(req.body);
		debit = await debit.save();
		// Response
		res.status(200).json({message: '...تمت إضافة مدين جديد' , debit: debit._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update(req, res) {
    try {
		const debit = await Debit.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true});
		if(!debit) return res.status(400).json({message: '...غير مسجل'});
		res.status(200).json({message: '...تم التعديل', debit});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function remove (req, res)  {
    try {
		const debit = await Debit.findByIdAndDelete(req.params.id);
		if(!debit) return res.status(400).json({message: '...غير مسجل'});
		res.status(200).json({message: '...تم حذف المدين'});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function getAll (req, res)  {
    try{
        const debits = await Debit.find();
        res.status(200).json(debits);
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
		const debit = await Debit.findById(req.params.id);
		if(!debit) return res.status(400).json({message: '...الدائن غير موجود'});
		
        // Get Transfers
		const transfers = await Transfer.find({
			$and: [
				{ $or: [
					{senderId: debit._id, senderType: ObjectsNames.debit},
					{receiverId: debit._id, receiverType: ObjectsNames.debit}
				]},
				{  date: { "$gte": startDate, "$lte": endDate} }
			]
		});

		// Get Total  Of Receive Transfer
         const receiveTransfers = await Transfer.aggregate([
            {$match: {receiverId: debit._id, receiverType: ObjectsNames.debit}},
            {$group: {_id: "$receiverId", total: {$sum: "$amount"}}}
        ]);
        // Get Total Of Send Transfer
		const sendTransfers = await Transfer.aggregate([
            {$match: {senderId: debit._id, senderType: ObjectsNames.debit}},
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
		
        res.status(200).json({debit, transfers, total});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}


module.exports = {create, update, remove, getAll, show};