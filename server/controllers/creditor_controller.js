const Transfer = require('../models/Transfer');
const ObjectsNames = require("../constant/objects-names");
const Creditor = require('../models/Creditor');

async function create(req, res){
    try{
		req.body.userId = req.user.id;
		let creditor = new Creditor(req.body);
		creditor = await creditor.save();
		// Response
		res.status(200).json({message: '...تمت إضافة دائن جديد' , creditor: creditor._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update(req, res) {
    try {
		const creditor = await Creditor.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true});
		if(!creditor) return res.status(400).json({message: '...غير مسجل'});
		res.status(200).json({message: '...تم التعديل', creditor});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function remove (req, res)  {
    try {
		const creditor = await Creditor.findByIdAndDelete(req.params.id);
		if(!creditor) return res.status(400).json({message: '...غير مسجل'});
		res.status(200).json({message: '...تم حذف الدائن'});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function getAll (req, res)  {
    try{
        const creditors = await Creditor.find();
        res.status(200).json(creditors);
	} catch(error){
		res.status(500).json({message: error.message});
	}
}



async function show (req, res)  {
    try{
		let startDate = new Date(req.query.start);
		let endDate = new Date(req.query.end );
		endDate.setUTCHours(23,59,59,999);

		// Get Creditors
		const creditor = await Creditor.findById(req.params.id);
		if(!creditor) return res.status(400).json({message: '...الدائن غير موجود'});
		
        // Get Transfers
		const transfers = await Transfer.find({
			$and: [
				{ $or: [
					{senderId: creditor._id, senderType: ObjectsNames.creditor},
					{receiverId: creditor._id, receiverType: ObjectsNames.creditor}
				]},
				{  date: { "$gte": startDate, "$lte": endDate} }
			]
		});
		// Get Total  Of Receive Transfer
         const receiveTransfers = await Transfer.aggregate([
            {$match: {receiverId: creditor._id, receiverType: ObjectsNames.creditor}},
            {$group: {_id: "$receiverId", total: {$sum: "$amount"}}}
        ]);
        // Get Total Of Send Transfer
		const sendTransfers = await Transfer.aggregate([
            {$match: {senderId: creditor._id, senderType: ObjectsNames.creditor}},
            {$group: {_id: "$senderId", total: {$sum: "$amount"}}}
        ]);

        // Calculate Total
        let total = 0;
        if (receiveTransfers.length > 0) {stat
            total += receiveTransfers[0]['total'];
        }
        if (sendTransfers.length > 0) {
            total -= sendTransfers[0]['total'];
        }
		
        res.status(200).json({creditor, transfers, total});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}


module.exports = {create, update, remove, getAll, show};