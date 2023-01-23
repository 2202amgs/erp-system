const ObjectsNames = require("../constant/objects-names");
const Shipment = require("../models/Shipment");
const Transfer = require("../models/Transfer");

async function singleCarData(car, startDate, endDate) {
    // get shipments
	const shipments = await Shipment.find({carId: car._id,  date: { "$gte": startDate, "$lte": endDate}});
	// get transfers
    const transfers = await Transfer.find({
        $and: [
            { $or: [
                {senderId: car._id, senderType: ObjectsNames.car},
                {receiverId: car._id, receiverType: ObjectsNames.car}
            ]},
            {  date: { "$gte": startDate, "$lte": endDate} }
        ]
    });
    // get old total of shipments
    const oldTotalForShipments = await totalOldOfShipments(car._id, startDate);
    // get old total of transfers
    const oldTotalForTransfers = await oldTotalTransfers(car._id, startDate);
    // get new total of shipments
    const newTotalForShipments = await totalNewOfShipments(shipments);
    // get new total of transfers
    const newTotalForTransfers = await newTotalTransfers(transfers);

    return {
        shipments,
        transfers,
        "data":{
            oldTotal: oldTotalForShipments - oldTotalForTransfers,
            ...newTotalForShipments,
            totalNewAdvance: newTotalForTransfers,
            newTotal: newTotalForShipments.totalNewShipment - newTotalForTransfers,
        }
    };

}

// old total of shipments
async function totalOldOfShipments(carId, startDate) {
    const totalShipment = await Shipment.aggregate([
        { $match: { carId: carId, date:  {$lt: startDate} } },
        { $group: { _id: "$carId", total:	{$sum: "$carPureTotal"} } },
    ]);

    let oldTotalForShipments = 0;
    if (totalShipment.length > 0) {
        oldTotalForShipments = totalShipment[0]['total'];
    }

    return oldTotalForShipments;
}


// old total transfer
async function oldTotalTransfers(carId, startDate){
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

// new total of shipments
async function totalNewOfShipments(shipments) {
    let totalNewShipment = 0;
    let totalCustody = 0;
    let total = 0;
    let totalDifferenceNolon = 0;
    shipments.forEach(shipment => {
        totalNewShipment += shipment['carPureTotal'];
        totalCustody += shipment['custody'];
        total += shipment['total'];
        totalDifferenceNolon += shipment['differenceNolon'];
    });

    return {totalNewShipment, totalCustody, total, totalDifferenceNolon};
}

// new total buy goods
async function newTotalTransfers(transfers){
    let totalNewtransfer = 0;
    transfers.forEach(transfer => {
        if(transfer['senderType'] == ObjectsNames.car){
            totalNewtransfer -= transfer['amount'];
        }else {
            totalNewtransfer += transfer['amount'];
        }
    });

    return totalNewtransfer;
}

module.exports = singleCarData;