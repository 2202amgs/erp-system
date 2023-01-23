const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    name: { type: String, required: true},
    password: { type: String, min: 8, required: true },
    isAdmin: { type: Boolean, default: false },
    archive: { type: Boolean, default: false },
    email: { 
        type: String, 
        required: true, 
        unique: true,
        validate: {
            validator: (value) => {
                const rgex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return value.match(rgex);
            },
            message: '...أدخل بريد صحيح',
        },
    },
    account: {type: Number, required: true, default: 0,},
}, {
    timestamps: true,
});

module.exports = mongoose.model('User', userSchema);
