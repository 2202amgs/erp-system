const mongoose = require('mongoose');

const typeGoodsSchema = new mongoose.Schema({
	userId: {type: mongoose.Types.ObjectId, required: true},
	name: {type: String, required: true},
	archive: {type:Boolean, required: true, default: false},
	// quantity: {type: Number, required: true},
},{
    timestamps: true,
});

module.exports = mongoose.model('TypeGoods', typeGoodsSchema);