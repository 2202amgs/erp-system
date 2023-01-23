import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/datasources/expenses_data.dart';
import 'package:frontend/data/models/single_expenses_model.dart';
import 'package:get/get.dart';

class SingleExpensesController extends GetxController {
  /// Section 1
  /// ===> Varibles
  late String expensesId;
  final ExpensesData _expensesData = ExpensesData();
  SingleExpensesModel? singleExpensesModel;
  bool loading = false;
  DateTimeRange dateTimeRange = DateTimeRange(
    start: firstDayInLastMonth(),
    end: DateTime.now(),
  );

  /// Section 2
  /// ===> Server Functions
  Future<void> getSingleExpenses() async {
    loading = true;
    update();
    singleExpensesModel = await _expensesData.show(
      expensesId,
      dateTimeRange,
    );
    loading = false;
    update();
  }

  /// Section 3
  /// ===> Life Cycle
  @override
  void onInit() {
    expensesId = Get.arguments[AppArguments.expensesId];
    getSingleExpenses();
    super.onInit();
  }
}
