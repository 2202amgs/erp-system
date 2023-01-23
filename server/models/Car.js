const mongoose = require('mongoose');

const carSchema = new mongoose.Schema({
	userId: {type: mongoose.Types.ObjectId, required: true},
	ownerName: {type: String, required: true},
	driverName: {type: String, required: true},
	carNumber: {type: Number, required: true, unique: true},
	locoNumber: {type: Number, required: true, unique: true},
	phone: {type: String},
	sailon: {type: Boolean, required: true, default: false},
	carRatio: {type: Number, max: 100},
	archive: {type:Boolean, required: true, default: false},
	account: {type: Number, required: true, default: 0,},
},{
    timestamps: true,
});

module.exports = mongoose.model('Car', carSchema);