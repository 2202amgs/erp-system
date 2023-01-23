import 'package:flutter/cupertino.dart';
import 'package:frontend/data/datasources/typegoods_data.dart';
import 'package:frontend/data/models/typegoods_model.dart';
import 'package:get/get.dart';

class TypeGoodsController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController nameController = TextEditingController();

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TypeGoodsData _bankData = TypeGoodsData();
  List<TypeGoodsModel> _typeGoods = [];
  bool archive = false;

  get typeGoods {
    List<TypeGoodsModel> tg = [];
    for (TypeGoodsModel typeGooda in _typeGoods) {
      if (typeGooda.archive! == archive) {
        tg.add(typeGooda);
      }
    }
    return tg;
  }

  List<TypeGoodsModel> alltypeGoods() {
    return _typeGoods;
  }

  List<TypeGoodsModel> activeTypeGoods() {
    List<TypeGoodsModel> tg = [];
    for (TypeGoodsModel typeGooda in _typeGoods) {
      if (typeGooda.archive! == false) {
        tg.add(typeGooda);
      }
    }
    return tg;
  }

  /// Section 3
  /// ===> Config Functions

  void clearControllers() {
    // clear controllers of data
    nameController.clear();
  }

  void modelToController(TypeGoodsModel typeGoodsModel) {
    nameController.text = typeGoodsModel.name!;
  }

  TypeGoodsModel contollerToModel(TypeGoodsModel typeGoodsModel) {
    typeGoodsModel.name = nameController.text;

    return typeGoodsModel;
  }

  /// Section 4
  /// ===> Server Functions
  void gettypeGoods() async {
    _typeGoods = await _bankData.get();
    update();
  }

  void createTypeGoods() async {
    await _bankData.create(contollerToModel(TypeGoodsModel()));
    gettypeGoods();
    Get.back();
  }

  void typeGoodsUpdate(TypeGoodsModel typeGoodsModel) async {
    await _bankData.update(contollerToModel(typeGoodsModel));
    gettypeGoods();
    Get.back();
  }

  void typeGoodsArchive(TypeGoodsModel typeGoodsModel) async {
    typeGoodsModel.archive = !typeGoodsModel.archive!;
    await _bankData.update(typeGoodsModel);
    gettypeGoods();
    Get.back();
  }
}
