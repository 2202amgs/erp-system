import 'package:flutter/cupertino.dart';
import 'package:frontend/data/datasources/transfer_data.dart';
import 'package:frontend/data/models/transfer_model.dart';
import 'package:get/get.dart';

class TransferController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? senderId;
  String? receiverId;
  String? senderType;
  String? receiverType;

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TransferData _transferData = TransferData();

  /// Section 3
  /// ===> Config Functions
  void clearControllers() {
    // clear controllers of data
    amountController.clear();
    descriptionController.clear();
    senderId = null;
    receiverId = null;
    senderType = null;
    receiverType = null;
  }

  void modelToController(TransferModel transferModel) {
    amountController.text = transferModel.amount!.toString();
    descriptionController.text = transferModel.description!;
    senderId = transferModel.senderId;
    receiverId = transferModel.receiverId;
    senderType = transferModel.senderType;
    receiverType = transferModel.receiverType;
  }

  TransferModel contollerToModel(TransferModel transferModel) {
    transferModel.amount = num.parse(amountController.text);
    transferModel.description = descriptionController.text;
    transferModel.senderId = senderId;
    transferModel.receiverId = receiverId;
    transferModel.senderType = senderType;
    transferModel.receiverType = receiverType;
    return transferModel;
  }

  void setSenderId(String id) {
    senderId = id;
    update();
  }

  void setReceiverId(String id) {
    receiverId = id;
    update();
  }

  void setSenderType(String type) {
    senderId = null;
    senderType = type;
    update();
  }

  void setReceiverType(String type) {
    receiverId = null;
    receiverType = type;
    update();
  }

  /// Section 4
  /// ===> Server Functions
  Future<void> createTransfer(DateTime date) async {
    Get.back();
    await _transferData
        .create(contollerToModel(TransferModel(date: date.toString())));
  }

  Future<void> transferUpdate(TransferModel transferModel) async {
    Get.back();
    await _transferData.update(contollerToModel(transferModel));
  }

  Future<void> deleteTransfer(String id) async {
    Get.back();
    await _transferData.delete(id);
  }
}
