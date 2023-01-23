const Bank = require("../models/Bank");
const Car = require("../models/Car");
const Client = require("../models/Client");
const TypeGoods = require("../models/TypeGoods");

async function incrementAccount(shipment){
    await Client.findByIdAndUpdate(shipment.clientId, {$inc: {account: shipment.clientTotal}}, {new: true});
    if(shipment.carId) await Car.findByIdAndUpdate(shipment.carId, {$inc: {account: shipment.carPureTotal}});
    if (shipment.bankId) await Bank.findByIdAndUpdate(shipment.bankId, {$inc: {account: (shipment.custody + shipment.differenceNolon) * -1}});
}

async function decrementAccount(shipment){
    await Client.findByIdAndUpdate(shipment.clientId, {$inc: {account: shipment.clientTotal * -1}}, {new: true});
    if(shipment.carId) await Car.findByIdAndUpdate(shipment.carId, {$inc: {account: shipment.carPureTotal * -1}});
    if (shipment.bankId) await Bank.findByIdAndUpdate(shipment.bankId, {$inc: {account: (shipment.custody + shipment.differenceNolon)}});
}

function totalCalc(body, data){    
    // Calc
    data.total = body.quantity * (body.nolon + body.tip + body.t3t);
    data.profitTotal = body.quantity * body.profitValue;
    data.clientTotal = data.total + data.profitTotal;
    data.carPureTotal = data.total - body.custody - body.differenceNolon;

    if(body.price > 0){
        data.clientTotal += body.price * body.quantity;
        data.price = body.price;
    }

    // Create Data Object
    return data
}

async function setCarData(body, data) {
    // Get Car
    if(body.carId){
        const car = await Car.findById(body.carId);
        if(!car) throw Error('...السيارة غير موجودة');
        data = {
            ...data,
            carNumber: car.carNumber,
            locoNumber: car.locoNumber,
            driverName: car.driverName,
            carId: car._id
        }
        
        // When IS Failled
        if (body.isFilled) {
            if(!car.sailon) throw Error('...هذه السيارة عادية');
            const carRatio = body.carRatio;
            const locoRatio = 100 - carRatio;
            data = {
                ...data,
                carRatio,
                locoRatio,
                carTotal: data.total * carRatio /100,
                locoTotal: data.total * locoRatio /100,
            }
        } else {
            if(car.sailon) throw Error('...هذه السيارة سايلون');
        }
        
    }
    return data;
}

async function setBankData(body, data) {
    if (body.bankId) {
        const bank = await Bank.findById(body.bankId);
        if(!bank) throw Error('...البنك غير موجود');
        data.bankId =  bank._id;
    }
    return data;
}

async function setTypeGoodskData(body, data) {
    if (body.typeGoodsId) {
        const typeGoods = await TypeGoods.findById(body.typeGoodsId);
        if(!typeGoods) throw Error('...الصنف غير موجود');
        data.typeGoodsId =  typeGoods._id;
    }
    return data;
}

async function setClientData(body, data) {
    const client = await Client.findById(body.clientId);
		if(!client) return res.status(400).json({message: '...العميل غير موجود'});
        data.clientId = client._id;
        data.clientName = client.clientName;
    return data;
}

module.exports = {incrementAccount, decrementAccount, totalCalc,  setCarData, setBankData, setTypeGoodskData, setClientData};