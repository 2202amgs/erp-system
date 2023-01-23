const mongoose = require('mongoose');

const transferSchema = new mongoose.Schema({
	userId: {type: mongoose.Types.ObjectId, ref: 'User',  required: true},
	senderId: {type: mongoose.Types.ObjectId, required: true},
	receiverId: {type: mongoose.Types.ObjectId, required: true},
	senderName: {type: String, required: true},
	receiverName: {type: String, required: true},
	senderType: {type: String, enum: ['car', 'client', 'bank', 'emp', 'expenses', 'loco', 'creditor'], required: true},
	receiverType: {type: String, enum: ['car', 'client', 'bank', 'emp', 'expenses', 'loco', 'creditor'], required: true},
	amount: {type: Number, required: true, min: 1},
	description: {type: String, required: true},
	date: {type: Date, required: true, default: Date.now()}
}); 

module.exports = mongoose.model('Transfer', transferSchema);