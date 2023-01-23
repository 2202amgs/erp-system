const Car = require('../models/Car');
const singleCarData = require('../shared/car_function');
const sailonCarData = require('../shared/sailon_car_functions');

async function create(req, res){
	try{
		req.body.userId = req.user.id;
		let car = new Car(req.body);
		car = await car.save();
		// Response
		res.status(200).json({message: '...تمت إضافة سيارة جديدة', car: car._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function update(req, res) {
	try {
		const car = await Car.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true});
		if(!car) return res.status(400).json({message: '...السيارة غير موجودة'});
		res.status(200).json({message: '...تم التعديل', car});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function remove (req, res)  {
	try {
		console.log(req.params.id);
		const car = await Car.findByIdAndDelete(req.params.id);
		if(!car) return res.status(400).json({message: '...السيارة غير موجودة'});
		res.status(200).json({message: '...تم حذف السيارة'});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

async function getALl(req, res){
	try{
		const cars = await Car.find();
        res.status(200).json(cars);
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

async function show(req, res) {
	try{
		let startDate = new Date(req.query.start);
		let endDate = new Date(req.query.end );
		endDate.setUTCHours(23,59,59,999);

		if (startDate > endDate) return  res.status(400).json({message: '...  خطأ فى الفتره الزمنية'});
		// Get Car
		const car = await Car.findById(req.params.id);
		if(!car) return res.status(400).json({message: '...السيارة غير موجودة'});
		let data;
		if (car.sailon) {
			data = await sailonCarData(car, startDate ,endDate);
		}else {
			data = await singleCarData(car, startDate ,endDate);
		}
		
        res.status(200).json({car, ...data});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}

module.exports = {getALl, create, update, remove, show};