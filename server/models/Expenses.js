const mongoose = require('mongoose');

const expensesSchema = new mongoose.Schema({
	userId: {type: mongoose.Types.ObjectId, required: true},
	name: {type: String, required: true},
	archive: {type:Boolean, required: true, default: false},
	account: {type: Number, required: true, default: 0,},
},{
    timestamps: true,
});

module.exports = mongoose.model('Expenses', expensesSchema);