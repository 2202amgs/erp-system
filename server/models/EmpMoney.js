const mongoose = require('mongoose');

const empSchema = new mongoose.Schema({
	userId: {type: mongoose.Types.ObjectId, required: true, ref: "User"},
	employeeId: {type: mongoose.Types.ObjectId, required: true, ref: "User"},
	amount: {type: Number, required: true, min: 1},
	description: {type: String, required: true},
	date: {type: Date, required: true, default: Date.now()}
});

module.exports = mongoose.model('EmpMoney', empSchema);