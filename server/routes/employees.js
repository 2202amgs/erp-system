const router = require('express').Router();
const bcryptjs = require('bcryptjs');
const User = require('../models/User');
const {verifyAdmin} = require('../middleware/verify-token');
const Transfer = require('../models/Transfer');
const EmpMoney = require('../models/EmpMoney');
const ObjectsNames = require('../constant/objects-names');

// Sign Up Routeer
router.post('/', verifyAdmin, async (req, res) => {
    try {
        const {name, email, password, isAdmin} = req.body;

        // User existing
        const existingUser = await User.findOne({email});
        if (existingUser) {
            return res.status(400).json({message: '...هذا البريد مسجل'});
        }
        
        // Create a new user
        let user = new User({
            email,
            name,
            isAdmin,
            password: await bcryptjs.hash(password, 8)
        });
        user = await user.save();
        delete user._doc.password

        res.status(200).json({message: 'تم تسجيل الحساب بنجاح...', user: user._doc});
    } catch (error) {
        res.status(500).json({message: error.message});
    }
});

// Update Up Routeer
router.put('/:id', verifyAdmin, async (req, res) => {
    try {
        let admin = await User.find();
        if(admin[0]._id.toString() == req.params.id){
            req.body.isAdmin = true; 
            req.body.archive = false; 
        }

        if (req.body.password) {
            req.body.password = await bcryptjs.hash(req.body.password, 8);
        }
        
        const user = await User.findByIdAndUpdate({_id: req.params.id}, req.body, {new: true});
        if(!user) return res.status(400).json({message: '...الحساب غير موجود'});

        delete user._doc.password
        res.status(200).json({message: '...تم التعديل', user});
    } catch (error) {
        res.status(500).json({message: error.message});
    }
});


// Get All User Data
router.get('/', verifyAdmin, async (req, res) => {
    try {
        // Get user from db
        const users = await User.find();
        if (!users) return req.status(400).json({message: "...لا يوجد حسابات"});
        // Send user data
        users.forEach(user => {
            delete user._doc.password
        });
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({message: error.message});
    }
});

// Get One User Data
router.get('/:id', verifyAdmin, async (req, res) => {
    try {
        // Date
        let startDate = new Date(req.query.start);
		let endDate = new Date(req.query.end );
		endDate.setUTCHours(23,59,59,999);

        // Get user from db
        const user = await User.findById(req.params.id);
        if (!user) return req.status(400).json({message: "... موظف غير مسجل"});
        // Send user data
        delete user._doc.password

        // Get Employee Money
		const empMoney = await EmpMoney.find({employeeId: user._id,  date: { "$gte": startDate, "$lte": endDate}});

        // Get Transfers
		const transfers = await Transfer.find({
			$and: [
				{ $or: [
					{senderId: user._id, senderType: ObjectsNames.emp},
					{receiverId: user._id, receiverType: ObjectsNames.emp}
				]},
				{  date: { "$gte": startDate, "$lte": endDate} }
			]
		});

        // Get Total  Of Employee Money
        const totalEmpMoney = await EmpMoney.aggregate([
            {$match: {employeeId: user._id}},
            {$group: {_id: "$employeeId", total: {$sum: "$amount"}}}
        ]);
        // Get Total  Of Receive Transfer
		const receiveTransfers = await Transfer.aggregate([
            {$match: {receiverId: user._id, receiverType: ObjectsNames.emp}},
            {$group: {_id: "$receiverId", total: {$sum: "$amount"}}}
        ]);
        // Get Total Of Send Transfer
		const sendTransfers = await Transfer.aggregate([
            {$match: {senderId: user._id, senderType: ObjectsNames.emp}},
            {$group: {_id: "$senderId", total: {$sum: "$amount"}}}
        ]);
        // Calculate Total
        let total = 0;
        if (totalEmpMoney.length > 0) {
            total += totalEmpMoney[0]['total'];
        }
        if (receiveTransfers.length > 0) {
            total -= receiveTransfers[0]['total'];
        }
        if (sendTransfers.length > 0) {
            total += sendTransfers[0]['total'];
        }

        res.status(200).json({user, empMoney, transfers, account: total});
    } catch (error) {
        res.status(500).json({message: error.message});
    }
});

module.exports = router;
