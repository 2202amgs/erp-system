import 'package:flutter/cupertino.dart';
import 'package:frontend/data/datasources/expenses_data.dart';
import 'package:frontend/data/models/expenses_model.dart';
import 'package:get/get.dart';

class ExpensesController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  TextEditingController name = TextEditingController();

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ExpensesData _expensesData = ExpensesData();
  List<ExpensesModel> _expenses = [];
  bool archive = false;
  bool clicked = false;
  get expenses {
    List<ExpensesModel> c = [];
    for (ExpensesModel expenses in _expenses) {
      if (expenses.archive! == archive) {
        c.add(expenses);
      }
    }
    return c;
  }

  List<ExpensesModel> allExpenses() {
    return _expenses;
  }

  /// Section 3
  /// ===> Config Functions
  void clearControllers() {
    // clear controllers of data
    name.clear();
  }

  void modelToController(ExpensesModel expensesModel) {
    name.text = expensesModel.name!;
  }

  ExpensesModel contollerToModel(ExpensesModel expensesModel) {
    expensesModel.name = name.text;
    return expensesModel;
  }

  /// Section 4
  /// ===> Server Functions
  void getExpenses() async {
    _expenses = await _expensesData.get();
    update();
  }

  void createExpenses() async {
    Get.back();
    await _expensesData.create(contollerToModel(ExpensesModel()));
    getExpenses();
  }

  void expensesUpdate(ExpensesModel expensesModel) async {
    Get.back();
    await _expensesData.update(contollerToModel(expensesModel));
    getExpenses();
  }

  Future<void> expensesArchive(ExpensesModel expensesModel) async {
    clicked = true;
    expensesModel.archive = !expensesModel.archive!;
    await _expensesData.update(expensesModel);
    getExpenses();
    clicked = false;
  }
}
