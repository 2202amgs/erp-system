const Advance = require('../models/Advance');

async function create(req, res){
    try{
		req.body.userId = req.user.id;
		let advance = new Advance(req.body);
		advance = await advance.save();
		// Response
		res.status(200).json({message: 'تم تسجيل السلفة' , advance: advance._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update(req, res) {
    try {
		const advance = await Advance.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true});
		if(!advance) return res.status(400).json({message: '...سلفة غير مسجلة'});
		res.status(200).json({message: '...تم التعديل', advance});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function remove (req, res)  {
    try {
		const advance = await Advance.findByIdAndDelete(req.params.id);
		if(!advance) return res.status(400).json({message: '...سلفة غير مسجلة'});
		res.status(200).json({message: 'تم حذف السلفة'});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}


module.exports = {create, update, remove};