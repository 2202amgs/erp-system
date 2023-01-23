const mongoose = require('mongoose');

const debitSchema = new mongoose.Schema({
	userId: {type: mongoose.Types.ObjectId, required: true, ref: "User"},
    name: {type: String, required: true},
    account: {type: Number, required: true, default: 0},
},{
    timestamps: true,
});

module.exports = mongoose.model('Debit', debitSchema);