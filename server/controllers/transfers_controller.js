const Transfer = require('../models/Transfer');
const {getTransferName, updateTransferAmount} = require('../shared/transfer_function');

async function create (req, res){
	try{
		if (req.body.receiverId == req.body.senderId  && req.body.senderType == req.body.receiverType){
			return res.status(400).json({message: 'لا يمكن الإرسال و الإستقبال على نفس الحساب'});
		}		
		req.body.senderName =  await getTransferName(req.body.senderId, req.body.senderType, req.body.amount * -1);
		req.body.receiverName =  await getTransferName(req.body.receiverId, req.body.receiverType, req.body.amount);
		
		req.body.userId = req.user.id;
		let transfer =  Transfer.create(req.body);
		if(!transfer) return res.status(400).json({message: '...حوالة غير مسجلة'});
		await updateTransferAmount(req.body.senderId, req.body.senderType, req.body.amount * -1);
		await updateTransferAmount(req.body.receiverId, req.body.receiverType, req.body.amount);
		// Response
		res.status(200).json({message: 'تم تسجيل الحوالة' , transfer: transfer._doc});
	} catch(error){
		res.status(500).json({message: error.message});
	}
}


async function update(req, res){
	try {
        if (req.body.receiverId == req.body.senderId && req.body.senderType == req.body.receiverType) {
			return res.status(400).json({message: 'لا يمكن الإرسال و الإستقبال على نفس الحساب'});
		}
		const oldTransfer = await Transfer.find(req.params.id);
		if(!oldTransfer) return res.status(400).json({message: '...حوالة غير مسجلة'});

		// Get Names
		req.body.senderName =  await getTransferName(req.body.senderId, req.body.senderType, req.body.amount * -1);
		req.body.receiverName =  await getTransferName(req.body.receiverId, req.body.receiverType, req.body.amount);

		const newTransfer = await Transfer.findByIdAndUpdate(oldTransfer._id, {$set:  req.body}, {new: true});
		// Delete
		await updateTransferAmount(oldTransfer.senderId, oldTransfer.senderType, oldTransfer.amount);
		await updateTransferAmount(oldTransfer.receiverId, oldTransfer.receiverType, oldTransfer.amount * -1);
		// Create
		await updateTransferAmount(newTransfer.senderId, newTransfer.senderType, newTransfer.amount * -1);
		await updateTransferAmount(newTransfer.receiverId, newTransfer.receiverType, newTransfer.amount);
		// Response
		res.status(200).json({message: '...تم التعديل', newTransfer});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}


async function remove (req, res) {
	try {
		const transfer = await Transfer.findByIdAndDelete(req.params.id);
		if(!transfer) return res.status(400).json({message: '...حوالة غير مسجلة'});
		await updateTransferAmount(transfer.senderId, transfer.senderType, transfer.amount);
		await updateTransferAmount(transfer.receiverId, transfer.receiverType, transfer.amount * -1);
		res.status(200).json({message: 'تم حذف الحوالة'});
	} catch (error) {
		res.status(500).json({message: error.message});
	}
}

module.exports = {create, update, remove};