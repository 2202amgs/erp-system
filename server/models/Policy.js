const mongoose = require('mongoose');

const policySchema = new mongoose.Schema({
	userId: {type: mongoose.Types.ObjectId, ref: 'User', required: true},
	description: {type: String},
	amount: {type: Number, required: true, min: 1},
	date: {type: Date, required: true, default: Date.now()}
});

module.exports = mongoose.model('Policy', policySchema);