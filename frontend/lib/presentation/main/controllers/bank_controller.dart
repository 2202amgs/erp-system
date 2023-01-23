import 'package:flutter/cupertino.dart';
import 'package:frontend/data/datasources/bank_data.dart';
import 'package:frontend/data/models/bank_model.dart';
import 'package:get/get.dart';

class BankController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountController = TextEditingController();

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BankData _bankData = BankData();
  List<BankModel> _banks = [];
  bool archive = false;

  get banks {
    List<BankModel> b = [];
    for (BankModel bank in _banks) {
      if (bank.archive! == archive) {
        b.add(bank);
      }
    }
    return b;
  }

  List<BankModel> allBanks() {
    return _banks;
  }

  /// Section 3
  /// ===> Config Functions

  void clearControllers() {
    // clear controllers of data
    nameController.clear();
    accountNumberController.clear();
    accountController.clear();
  }

  void modelToController(BankModel bankModel) {
    nameController.text = bankModel.name!;
    accountNumberController.text = bankModel.accountNumber ?? '';
    accountController.text = bankModel.account.toString();
  }

  BankModel contollerToModel(BankModel bankModel) {
    bankModel.name = nameController.text;
    bankModel.accountNumber = accountNumberController.text;
    bankModel.account = num.parse(accountController.text);

    return bankModel;
  }

  /// Section 4
  /// ===> Server Functions
  void getBanks() async {
    _banks = await _bankData.get();
    update();
  }

  void createBank() async {
    Get.back();
    await _bankData.create(contollerToModel(BankModel()));
    getBanks();
  }

  void bankUpdate(BankModel bankModel) async {
    Get.back();
    await _bankData.update(contollerToModel(bankModel));
    getBanks();
  }

  void bankArchive(BankModel bankModel) async {
    Get.back();
    bankModel.archive = !bankModel.archive!;
    await _bankData.update(bankModel);
    getBanks();
  }
}
