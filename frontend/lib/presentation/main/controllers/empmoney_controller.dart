import 'package:flutter/cupertino.dart';
import 'package:frontend/data/datasources/empmoney_data.dart';
import 'package:frontend/data/models/empmoney_model.dart';
import 'package:get/get.dart';

class EmpMoneyController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? empId;

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final EmpMoneyData _empMoneyData = EmpMoneyData();

  /// Section 3
  /// ===> Config Functions
  void clearControllers() {
    // clear controllers of data
    // amountController.clear();
    // descriptionController.clear();
    // empId = null;
  }

  void modelToController(EmpMoneyModel empMoneyModel) {
    amountController.text = empMoneyModel.amount!.toString();
    descriptionController.text = empMoneyModel.description!;
    empId = empMoneyModel.employeeId;
  }

  EmpMoneyModel contollerToModel(EmpMoneyModel empMoneyModel) {
    empMoneyModel.amount = num.parse(amountController.text);
    empMoneyModel.description = descriptionController.text;
    empMoneyModel.employeeId = empId;
    return empMoneyModel;
  }

  void setEmployeeId(String id) {
    empId = id;
    update();
  }

  /// Section 4
  /// ===> Server Functions
  Future<void> createEmpMoney(DateTime date) async {
    Get.back();
    await _empMoneyData
        .create(contollerToModel(EmpMoneyModel(date: date.toString())));
  }

  Future<void> empMoneyUpdate(EmpMoneyModel empMoneyModel) async {
    Get.back();
    await _empMoneyData.update(contollerToModel(empMoneyModel));
  }

  Future<void> deleteEmpMoney(String id) async {
    Get.back();
    await _empMoneyData.delete(id);
  }
}
