const mongoose = require('mongoose');

const clientSchema = new mongoose.Schema({
	userId: {type: mongoose.Types.ObjectId, required: true},
	clientName: {type: String, required: true, unique: true},
	ponName: {type: String, required: true},
	phone: {type: String},
	archive: {type:Boolean, required: true, default: false},
	isClient: {type: Boolean, required: true, defualt: true},
	account: {type: Number, required: true, default: 0,},
},{
    timestamps: true,
});

module.exports = mongoose.model('Client', clientSchema);