import 'package:flutter/cupertino.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/datasources/buygoods_data.dart';
import 'package:frontend/data/models/buygoods_model.dart';
import 'package:get/get.dart';

class BuyGoodsController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController amountController = TextEditingController();
  TextEditingController poneNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String? carId;
  String? supplierId;
  String? typeGoodsId;

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BuyGoodsData _buyGoodsData = BuyGoodsData();

  void setSupplierId(String? id) {
    supplierId = id;
    update();
  }

  void setCarId(String? id) {
    carId = id;
    update();
  }

  void setTypeGoodId(String? id) {
    typeGoodsId = id;
    update();
  }

  /// Section 3
  /// ===> Config Functions

  void clearControllers() {
    // clear controllers of data
    amountController.clear();
    poneNameController.clear();
    descriptionController.clear();
    quantityController.clear();
    carId = null;
    supplierId = null;
    typeGoodsId = null;
  }

  void modelToController(BuyGoodsModel buyGoodsModel) {
    amountController.text = buyGoodsModel.amount!.toString();
    descriptionController.text = buyGoodsModel.description!;
    quantityController.text = buyGoodsModel.quantity!.toString();
    poneNameController.text = buyGoodsModel.poneName!;
    carId = buyGoodsModel.carId;
    supplierId = buyGoodsModel.supplierID;
    typeGoodsId = buyGoodsModel.typeGoodsID;
  }

  BuyGoodsModel contollerToModel(BuyGoodsModel buyGoodsModel) {
    buyGoodsModel.amount = num.parse(amountController.text);
    buyGoodsModel.quantity = num.parse(quantityController.text);
    buyGoodsModel.description = descriptionController.text;
    buyGoodsModel.poneName = poneNameController.text;
    buyGoodsModel.carId = carId;
    buyGoodsModel.supplierID = supplierId;
    buyGoodsModel.typeGoodsID = typeGoodsId;
    return buyGoodsModel;
  }

  /// Section 4
  /// ===> Server Functions
  Future<void> createBuyGoods(DateTime date) async {
    Get.back();
    await _buyGoodsData
        .create(contollerToModel(BuyGoodsModel(date: printDate(date))));
  }

  Future<void> buyGoodsUpdate(BuyGoodsModel buyGoodsModel) async {
    Get.back();
    await _buyGoodsData.update(contollerToModel(buyGoodsModel));
  }

  Future<void> deleteBuyGoods(String id) async {
    Get.back();
    await _buyGoodsData.delete(id);
  }
}
