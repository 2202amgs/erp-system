const Car = require('../models/Car');
const Client = require('../models/Client');
const Bank = require('../models/Bank');
const Expenses = require('../models/Expenses');
const User = require('../models/User');
const ObjectsNames = require('../constant/objects-names');
const Creditor = require('../models/Creditor');


async function getTransferName(id, type) {
    switch (type) {
        case ObjectsNames.car:
            const car =  await Car.findById(id);
            return `${car.ownerName}-${car.carNumber}`;
        case ObjectsNames.loco:
            const loco =  await Car.findById(id);
            return `${loco.ownerName}-${loco.locoNumber}`;
        case ObjectsNames.expenses:
            const expenses =  await Expenses.findById(id);
            return expenses.name;
        case ObjectsNames.client:
            const client = await Client.findById(id);
            return client.clientName;
        case ObjectsNames.emp:
            const emp =  await User.findById(id);
            return emp.name;
        case ObjectsNames.creditor:
            const creditor =  await Creditor.findById(id);
            return creditor.name;
        default:
            const bank = await Bank.findById(id);
            return bank.name
    }
}

async function updateTransferAmount(id, type, amount) {
    switch (type) {
        case ObjectsNames.car:
            await Car.findByIdAndUpdate(id, {$inc: {account: amount}}, {new: true});
            break;
        case ObjectsNames.loco:
            await Car.findByIdAndUpdate(id, {$inc: {account: amount}}, {new: true});
            break;
        case ObjectsNames.expenses:
            await Expenses.findByIdAndUpdate(id, {$inc: {account: amount}}, {new: true});
            break;
        case ObjectsNames.client:
            await Client.findByIdAndUpdate(id, {$inc: {account: amount}}, {new: true});
            break;
        case ObjectsNames.emp:
            await User.findByIdAndUpdate(id, {$inc: {account: amount}}, {new: true});
            break;
        case ObjectsNames.creditor:
            await Creditor.findByIdAndUpdate(id, {$inc: {account: amount}}, {new: true});
            break;
        default:
            await Bank.findByIdAndUpdate(id, {$inc: {account: amount}}, {new: true});
    }
}

module.exports = {getTransferName, updateTransferAmount};