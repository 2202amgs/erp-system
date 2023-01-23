const ObjectsNames = require("../constant/objects-names");
const Shipment = require("../models/Shipment");
const Transfer = require("../models/Transfer");

async function sailonCarData(car, startDate, endDate) {
    // Get Shipments
    const shipments = await Shipment.find({carId: car._id,  date: { "$gte": startDate, "$lte": endDate}});
    // get transfers
    const transfers = await Transfer.find({
        $and: [
            { $or: [
                {senderId: car._id, senderType: ObjectsNames.car},
                {receiverId: car._id, receiverType: ObjectsNames.car},
                {senderId: car._id, senderType: ObjectsNames.loco},
                {receiverId: car._id, receiverType: ObjectsNames.loco}
            ]},
            {  date: { "$gte": startDate, "$lte": endDate} }
        ]
    });

    // total old
    const old = await getOldTotal(car._id, startDate);
    // total new of shipments
    const totalNewOfShipments = await totalNewFromShipments(shipments);
    // total new of advances
    const totalNewOfAdvances = await newTotalTransfers(transfers);

    return {
        shipments,
        transfers,
        data: {
                ...old,
                ...totalNewOfShipments,
                ...totalNewOfAdvances,
                newTotal: totalNewOfShipments.total - totalNewOfAdvances.totalNewAdvance - totalNewOfShipments.totalCustody - totalNewOfShipments.totalDifferenceNolon,
                newTotalForCar: totalNewOfShipments.totalNewShipmentForCar - totalNewOfShipments.totalCustody - totalNewOfShipments.totalDifferenceNolon - totalNewOfAdvances.totalNewAdvanceForCar,
                newTotalForLoco: totalNewOfShipments.totalNewShipmentForLoco - totalNewOfAdvances.totalNewAdvanceForLoco,
        },
    };
}

// 1-total old shipments | 2-total old shipments for car | 3-total old shipments for loco
// 4-total old custody | 5-total old defernce nolon
async function totalOldFromShipments(carId, startDate) {
    const totalShipment = await Shipment.aggregate([
        {
            $match: {
                carId: carId,
                date: {$lt: startDate}
            },
        },
        { 	
            $group: {
                _id: "$carId",
                total: {$sum: "$total"},
                carTotal: {$sum: "$carTotal"},
                locoTotal: {$sum: "$locoTotal"},
                totalCustody: {$sum: "$custody"},
                totalDifferenceNolon: {$sum: "$differenceNolon"},
            },
        },
    ]);

    let totalOldShipments = 0;
    let totalOldShipmentsForCar = 0;
    let totalOldShipmentsForLoco = 0;
    let totalOldCustody = 0;
    let totalOldDifferenceNolon = 0;
    if ( totalShipment.length > 0) {
        totalOldShipments =  totalShipment[0]['total'];
        totalOldShipmentsForCar =  totalShipment[0]['carTotal'];
        totalOldShipmentsForLoco =  totalShipment[0]['locoTotal'];
        totalOldCustody =  totalShipment[0]['totalCustody'];
        totalOldDifferenceNolon =  totalShipment[0]['totalDifferenceNolon'];
    }

    return {
        totalOldShipments,
        totalOldShipmentsForCar,
        totalOldShipmentsForLoco,
        totalOldCustody,
        totalOldDifferenceNolon,
    }
}

// 6-total old advance | 7-total old advance for car | 8-total old advance for loco
async function totalOldTransferForCar(carId, startDate) {
    const senderTotal = await Transfer.aggregate([
        {
            $match: {
                senderId: carId,
                date: {$lt: startDate},
                senderType: ObjectsNames.car,
            },
        },
        { 	
            $group: { _id: "$senderId", total: {$sum: "$amount"} },
        },
    ]);
    let oldSenderTotal = 0;
    if ( senderTotal.length > 0) {
        oldSenderTotal =  senderTotal[0]['total'];
    }

    const receiverTotal = await Transfer.aggregate([
        {
            $match: {
                receiverId: carId,
                date: {$lt: startDate},
                receiverType: ObjectsNames.car,
            },
        },
        { 	
            $group: { _id: "$senderId", total: {$sum: "$amount"} },
        },
    ]);
    let oldreceiverTotal = 0;
    if ( receiverTotal.length > 0) {
        oldreceiverTotal =  receiverTotal[0]['total'];
    }

    return oldreceiverTotal - oldSenderTotal;
}
// 6-total old advance | 7-total old advance for car | 8-total old advance for loco
async function totalOldTransferForLoco(carId, startDate) {
    const senderTotal = await Transfer.aggregate([
        {
            $match: {
                senderId: carId,
                date: {$lt: startDate},
                senderType: ObjectsNames.loco,
            },
        },
        { 	
            $group: { _id: "$senderId", total: {$sum: "$amount"} },
        },
    ]);
    let oldSenderTotal = 0;
    if ( senderTotal.length > 0) {
        oldSenderTotal =  senderTotal[0]['total'];
    }

    const receiverTotal = await Transfer.aggregate([
        {
            $match: {
                receiverId: carId,
                date: {$lt: startDate},
                receiverType: ObjectsNames.loco,
            },
        },
        { 	
            $group: { _id: "$senderId", total: {$sum: "$amount"} },
        },
    ]);
    let oldreceiverTotal = 0;
    if ( receiverTotal.length > 0) {
        oldreceiverTotal =  receiverTotal[0]['total'];
    }

    return oldreceiverTotal - oldSenderTotal;
}

// 9-total old = 1 - 6 | 10-total old for loco = 3 - 8 | 11-total old for car = 2 - 7 -4 - 5
async function getOldTotal(carId, startDate) {
    const { totalOldShipments, totalOldShipmentsForCar, totalOldShipmentsForLoco, totalOldCustody, totalOldDifferenceNolon} 
    = await totalOldFromShipments(carId, startDate);

    const totalOldAdvancesForCar = await totalOldTransferForCar(carId, startDate);
    const totalOldAdvancesForLoco = await totalOldTransferForLoco(carId, startDate);
    const totalOldAdvances = totalOldAdvancesForCar + totalOldAdvancesForLoco;
    return {
        oldTotal: totalOldShipments - totalOldAdvances  - totalOldCustody - totalOldDifferenceNolon,
        oldTotalForCar:  totalOldShipmentsForCar - totalOldCustody - totalOldDifferenceNolon - totalOldAdvancesForCar,
        oldTotalForLoco:  totalOldShipmentsForLoco - totalOldAdvancesForLoco,
    }
}

// 1-total new shipments | 2-total new shipments for car | 3-total new shipments for loco
// 4-total new custody | 5-total new defernce nolon
async function totalNewFromShipments(shipments) {
    let totalNewShipment = 0;
    let totalNewShipmentForCar = 0;
    let totalNewShipmentForLoco = 0;
    let totalCustody = 0;
    let total = 0;
    let totalDifferenceNolon = 0;
    shipments.forEach(shipment => {
        totalNewShipment += shipment['carPureTotal'] || 0;
        totalNewShipmentForCar += shipment['carTotal'] || 0;
        totalNewShipmentForLoco += shipment['locoTotal'] || 0;
        totalCustody += shipment['custody'] || 0;
        total += shipment['total'] || 0;
        totalDifferenceNolon += shipment['differenceNolon'] || 0;
    });

    return {totalNewShipment, totalNewShipmentForCar, totalNewShipmentForLoco , totalCustody, total, totalDifferenceNolon};
}

// 6-total new advance | 7-total new advance for car | 8-total new advance for loco
async function newTotalTransfers(transfers){
    let totalNewAdvanceForCar = 0;
    let totalNewAdvanceForLoco = 0;

    transfers.forEach(transfer => {
        if(transfer['senderType'] == ObjectsNames.car){
            totalNewAdvanceForCar -= transfer['amount'];
        }else if (transfer['senderType'] == ObjectsNames.loco) {
            totalNewAdvanceForLoco -= transfer['amount'];
        }else if (transfer['receiverType'] == ObjectsNames.car) {
            totalNewAdvanceForCar += transfer['amount'];
        }else {
            totalNewAdvanceForLoco += transfer['amount'];
        }
    });

    let totalNewAdvance = totalNewAdvanceForCar + totalNewAdvanceForLoco;
    return {totalNewAdvance, totalNewAdvanceForCar, totalNewAdvanceForLoco};
}
module.exports = sailonCarData;
