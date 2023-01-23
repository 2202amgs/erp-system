const mongoose = require('mongoose');

const shipmentSchema = new mongoose.Schema({
	// البيانات النصية
	carNumber: {type: Number},
	locoNumber: {type: Number},
	driverName: {type: String},
	factory: {type: String, required: true},
	side: {type: String, required: true},
	clientName: {type: String, required: true},
	poneName: {type: String, required: true},
	notes: {type: String},
	permissionNumber: {type: String, required: true},
	// الحساب
	custody: {type: Number, default: 0},
	tip: {type: Number, default: 0},
	t3t: {type: Number, default: 0},
	quantity: {type: Number, required: true},
	nolon: {type: Number, default: 0},
	differenceNolon: {type: Number, default: 0},
	profitValue: {type: Number, required: true},
	total: {type: Number, required: true},
	clientTotal: {type: Number, required: true},
	carPureTotal: {type: Number, required: true},
	profitTotal: {type: Number, required: true},
	// العلاقات
	userId: {type: mongoose.Types.ObjectId, ref: "User", required: true},
	clientId: {type: mongoose.Types.ObjectId, ref: "Client", required: true},
	carId: {type: mongoose.Types.ObjectId, ref: "Car"},
	bankId: {type: mongoose.Types.ObjectId, ref: "Bank"},
	typeGoodsId: {type: mongoose.Types.ObjectId, ref: "TypeGoods"},
	// سايلون
	isFilled: {type: Boolean, required:true},
	carRatio: {type: Number, max: 100},
	carTotal: {type: Number},
	locoRatio: {type: Number, max: 100},
	locoTotal: {type: Number},
	// التاريخ
	date: {type: Date, required: true},
	// تجارة
	price: {type: Number},
});

module.exports = mongoose.model('Shipment', shipmentSchema);