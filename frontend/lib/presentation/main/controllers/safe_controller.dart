import 'package:flutter/cupertino.dart';
import 'package:frontend/data/datasources/safe_data.dart';
import 'package:frontend/data/models/safe_model.dart';
import 'package:get/get.dart';

class SafeController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController accountController = TextEditingController();

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SafeData _safeData = SafeData();
  List<SafeModel> _safes = [];
  bool archive = false;

  get safes {
    List<SafeModel> b = [];
    for (SafeModel safe in _safes) {
      if (safe.archive! == archive) {
        b.add(safe);
      }
    }
    return b;
  }

  List<SafeModel> allSafes() {
    return _safes;
  }

  /// Section 3
  /// ===> Config Functions

  void clearControllers() {
    // clear controllers of data
    nameController.clear();
    accountController.clear();
  }

  void modelToController(SafeModel safeModel) {
    nameController.text = safeModel.name!;
    accountController.text = safeModel.account.toString();
  }

  SafeModel contollerToModel(SafeModel safeModel) {
    safeModel.name = nameController.text;
    safeModel.account = num.parse(accountController.text);

    return safeModel;
  }

  /// Section 4
  /// ===> Server Functions
  void getSafes() async {
    _safes = await _safeData.get();
    update();
  }

  void createSafe() async {
    await _safeData.create(contollerToModel(SafeModel()));
    getSafes();
    Get.back();
  }

  void safeUpdate(SafeModel safeModel) async {
    await _safeData.update(contollerToModel(safeModel));
    getSafes();
    Get.back();
  }

  void safeArchive(SafeModel safeModel) async {
    safeModel.archive = !safeModel.archive!;
    await _safeData.update(safeModel);
    getSafes();
    Get.back();
  }
}
