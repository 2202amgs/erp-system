const EmpMoney = require('../models/EmpMoney');

async function create (req, res){
	try{
		req.body.userId = req.user.id;
		let empMoney = new EmpMoney(req.body);
		empMoney = await empMoney.save();
		// Response
		res.status(200).json({message: 'تم تسجيل الإستحقاق' , empMoney: empMoney._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}


async function update(req, res){
	try {
		const empMoney = await EmpMoney.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true});
		if(!empMoney) return res.status(400).json({message: '...إستحقاق غير مسجل'});
		res.status(200).json({message: '...تم التعديل', empMoney});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}


async function remove (req, res) {
	try {
		const empMoney = await EmpMoney.findByIdAndDelete(req.params.id);
		if(!empMoney) return res.status(400).json({message: '...إسحقاق غير مسجل'});
		res.status(200).json({message: 'تم حذف الإستحقاق'});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

module.exports = {create, update, remove};