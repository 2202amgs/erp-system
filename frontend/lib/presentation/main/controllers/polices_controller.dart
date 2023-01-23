import 'package:flutter/cupertino.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/datasources/policy_data.dart';
import 'package:frontend/data/models/policy_model.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class PolicyController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController accountController = TextEditingController();

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PolicyData _policyData = PolicyData();
  List<PolicyModel> polices = [];
  DateTime dateTime = DateTime.now();
  bool isLoad = false;

  /// Section 3
  /// ===> Config Functions

  void clearControllers() {
    // car data
    descriptionController.clear();
    accountController.clear();
  }

  void modelToController(PolicyModel policyModel) {
    accountController.text = policyModel.amount.toString();
    descriptionController.text = policyModel.description ?? '';
  }

  PolicyModel contollerToModel(PolicyModel policyModel) {
    policyModel.amount = num.parse(accountController.text);
    policyModel.description = descriptionController.text;
    policyModel.date ??= printDate(dateTime);
    return policyModel;
  }

  /// Section 4
  /// ===> Server Functions
  Future<void> getPolices() async {
    isLoad = true;
    update();
    polices = await _policyData.get(dateTime);
    isLoad = false;
    update();
  }

  Future<void> createPolicy() async {
    Get.back();
    await _policyData.create(contollerToModel(PolicyModel()));
    getPolices();
  }

  Future<void> policyUpdate(PolicyModel policyModel) async {
    Get.back();
    await _policyData.update(contollerToModel(policyModel));
    // getPolices();
  }

  Future<void> deletePolicy(String id) async {
    Get.back();
    await _policyData.delete(id);
    // getPolices();
  }

  /// Section 6
  /// ===> Functions
  List<String> column() => [
        'م',
        'التاريخ',
        'المبلغ',
        'الوصف',
      ];
  List cells(int index) => [
        (index + 1).toString(),
        Jiffy(polices[index].date).yMMMMEEEEd,
        polices[index].amount.toString(),
        polices[index].description,
      ];
}
