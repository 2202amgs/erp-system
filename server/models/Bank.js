const mongoose = require('mongoose');

const bankSchema = new mongoose.Schema({
	userId: {type: mongoose.Types.ObjectId, required: true},
	name: {type: String, required: true},
	isBank: {type: Boolean, required: true},
	account: {type: Number, required: true, default: 0,},
	archive: {type:Boolean, required: true, default: false},
	accountNumber: {type: String},
},{
    timestamps: true,
});

module.exports = mongoose.model('Bank', bankSchema);