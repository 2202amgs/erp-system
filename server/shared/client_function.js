const BuyGoods = require("../models/BuyGoods");
const Shipment = require("../models/Shipment");
const Transfer = require("../models/Transfer");

async function singleClientData(client, transfers, shipments, buyGoods, startDate) {
    // Get Old Shipment Total
    let oldShipments = await oldTotalShipments(client._id, startDate);

    // Get Old Buy Goods Total
    let oldBuyGoods = await oldTotalBuyGoods(client._id, startDate);
    
    // Get Old Buy Goods Total
    let oldTransfer = await oldTotalTransfers(client._id, startDate);

    // Get New Shipment Total
    let newShipment = await newTotalShipments(shipments);

    // Get New Buy Goods Total
    let newBuyGoods = await newTotalBuyGoods(buyGoods);
    // Get New Buy Goods Total
    let newTransfers = await newTotalTransfers(transfers);

    return {
        newTransfers,
        newShipment,
        newBuyGoods,
        oldTotal: oldShipments - oldBuyGoods - oldTransfer,
        newTotal: newShipment - newBuyGoods - newTransfers,
    };

}

// old total shipments
async function oldTotalShipments(clientId, startDate){
    const totalShipment = await Shipment.aggregate([
        {
            $match: {
                clientId: clientId,
                date: {$lt: startDate}
            },
        },
        { 	
            $group: { _id: "$clientId", total: {$sum: "$clientTotal"} },
        },
    ]);
    let totalShipments = 0;
    if ( totalShipment.length > 0) {
        totalShipments =  totalShipment[0]['total'];
    }

    return totalShipments;
}

// old total buy goods
async function oldTotalBuyGoods(clientId, startDate){
    const totalBuyGood = await BuyGoods.aggregate([
        {
            $match: {
                clientId: clientId,
                date: {$lt: startDate}
            },
        },
        { 	
            $group: { _id: "$supplierId", total: {$sum: "$total"} },
        },
    ]);
    let totalBuyGoods = 0;
    if ( totalBuyGood.length > 0) {
        totalBuyGoods =  totalBuyGood[0]['total'];
    }

    return totalBuyGoods;
}


// old total transfer
async function oldTotalTransfers(clientId, startDate){
    const senderTotal = await Transfer.aggregate([
        {
            $match: {
                senderId: clientId,
                date: {$lt: startDate},
                senderType: 'client',
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
                receiverId: clientId,
                date: {$lt: startDate},
                receiverType: 'client',
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

    return oldSenderTotal - oldreceiverTotal;
}

// new total shipments
async function newTotalShipments(shipments){
    let totalNewShipment = 0;
    shipments.forEach(shipment => {
        totalNewShipment += shipment['clientTotal'];
    });

    return totalNewShipment;
}

// new total buy goods
async function newTotalBuyGoods(buyGoods){
    let totalNewBuyGoods = 0;
    buyGoods.forEach(buyGoods => {
        totalNewBuyGoods += buyGoods['total'];
    });

    return totalNewBuyGoods;
}

// new total buy goods
async function newTotalTransfers(transfers){
    let totalNewtransfer = 0;
    transfers.forEach(transfer => {
        if(transfer['senderType'] == 'client'){
            totalNewtransfer += transfer['amount'];
        }else {
            totalNewtransfer -= transfer['amount'];
        }
    });

    return totalNewtransfer;
}

module.exports = singleClientData;