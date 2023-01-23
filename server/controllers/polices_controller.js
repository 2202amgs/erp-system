const Policy = require("../models/Policy");

// Creat and update one shipment
async function create(req, res){
	try{
        req.body.userId = req.user.id;
		let policy = new Policy(req.body);
		policy = await policy.save();
		res.status(200).json({message: '...تمت إضافة العملية', policy: policy._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update (req, res){
	try{
        const policy = await Policy.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true});
		if(!policy) return res.status(400).json({message: '...غير مسجل'});

		res.status(200).json({message: '...تم التعديل', policy});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

// Remove one policy
async function remove(req, res) {
    try {
        const policy = await Policy.findByIdAndDelete(req.params.id);
        if(!policy) return res.status(400).json({message: '...البوليصة غير موجودة'});
        res.status(200).json({message: '...تم الحذف '});
    } catch (error) {
        res.status(500).json({message: error.message});
    }
}

// Get colletion of polices by date
async function getByDate(req, res) {
    try{
        const dt = new Date(req.query.date);
        const start = new Date(dt.getFullYear(), dt.getMonth(), 2);
        const end = new Date(dt.getFullYear(), dt.getMonth() + 1, 1);
        
        const policy = await Policy.find({date: {"$gte": start, "$lte": end}});
        res.status(200).json(policy);
    } catch(error){
        res.status(500).json({message: error.message});
    }
}

module.exports = {create, update, remove, getByDate};