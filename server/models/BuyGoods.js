const mongoose = require('mongoose');

const buyGoodsSchema = new mongoose.Schema({
    // ref
	userId: {type: mongoose.Types.ObjectId, ref: 'User', required: true},
	supplierId: {type: mongoose.Types.ObjectId, ref: 'Client', required: true},
	typeGoodsId: {type: mongoose.Types.ObjectId, ref: 'TypeGoods', required: true},
    // Data
	carNumber: {type: Number},
	driverName: {type: String},
	typeGoodsName: {type: String, required: true},
	description: {type: String},
	poneName: {type: String, required: true},
	amount: {type: Number, required: true, min: 1},
	quantity: {type: Number, required: true, min: 1},
	total: {type: Number, required: true, default: function () {
        return this.amount * this.quantity;
    }},
	date: {type: Date, required: true, default: Date.now()}
});

module.exports = mongoose.model('BuyGoods', buyGoodsSchema);