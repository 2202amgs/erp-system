const Transfer = require("../models/Transfer");
const Expenses = require("../models/Expenses");
const ObjectsNames = require("../constant/objects-names");

async function create(req, res){
    try{
		req.body.userId = req.user.id;
		let expenses = new Expenses(req.body);
		expenses = await expenses.save();
		// Response
		res.status(200).json({message: '...تمت إضافة قسم جديد', expenses: expenses._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update(req, res) {
    try {
		const expenses = await Expenses.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true});
		if(!expenses) return res.status(400).json({message: '...القسم غير موجود'});
		res.status(200).json({message: '...تم التعديل', expenses});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function remove (req, res)  {
    try {
		const expenses = await Expenses.findByIdAndDelete(req.params.id);
		if(!expenses) return res.status(400).json({message: '...الصنف غير موجود'});
		res.status(200).json({message: '...تم حذف الصنف'});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function getAll (req, res)  {
    try{
		const expenses = await Expenses.find();
        res.status(200).json(expenses);
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
		const expenses = await Expenses.findById(req.params.id);
		if(!expenses) return res.status(400).json({message: '...القسم غير موجود'});
		
        // Get Transfers
		const transfers = await Transfer.find({
			$and: [
				{ $or: [
					{senderId: expenses._id, senderType: ObjectsNames.expenses},
					{receiverId: expenses._id, receiverType: ObjectsNames.expenses}
				]},
				{  date: { "$gte": startDate, "$lte": endDate} }
			]
		});

		// Get Total  Of Receive Transfer
         const receiveTransfers = await Transfer.aggregate([
            {$match: {receiverId: expenses._id, receiverType: ObjectsNames.expenses}},
            {$group: {_id: "$receiverId", total: {$sum: "$amount"}}}
        ]);
        // Get Total Of Send Transfer
		const sendTransfers = await Transfer.aggregate([
            {$match: {senderId: expenses._id, senderType: ObjectsNames.expenses}},
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
		
        res.status(200).json({expenses, transfers, total});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}



module.exports = {create, update, remove, getAll, show};