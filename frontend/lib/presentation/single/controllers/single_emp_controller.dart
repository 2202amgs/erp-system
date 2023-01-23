import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/datasources/single_emp_data.dart';
import 'package:frontend/data/models/single_emp_model.dart';
import 'package:get/get.dart';

class SingleEmpController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers

  /// Section 2
  /// ===> Varibles
  late String empId;
  final SingleEmpData _singleEmpData = SingleEmpData();
  SingleEmpModel? singleEmpModel;
  bool loading = false;
  DateTimeRange dateTimeRange =
      DateTimeRange(start: firstDayInLastMonth(), end: DateTime.now());

  /// Section 4
  /// ===> Server Functions
  Future<void> getSingleEmp() async {
    loading = true;
    update();
    singleEmpModel = await _singleEmpData.get(
      empId,
      dateTimeRange,
    );
    loading = false;
    update();
  }

  /// Section 5
  /// ===> Life Cycle
  @override
  void onInit() {
    empId = Get.arguments[AppArguments.empId];
    getSingleEmp();
    super.onInit();
  }

  List<String> get columns => ['م', 'التاريخ', 'الوصف', 'المبلغ'];

  List cells(int index) {
    return [
      (index + 1),
      singleEmpModel!.empMoney![index].date.toString().substring(0, 10),
      singleEmpModel!.empMoney![index].description,
      singleEmpModel!.empMoney![index].amount,
    ];
  }

  List<String> get comlumnOfTransfer => ['م', 'التاريخ', 'الوصف', 'المبلغ'];

  List cellsOfTransfer(int index) {
    return [
      (index + 1),
      singleEmpModel!.transfers![index].date.toString().substring(0, 10),
      singleEmpModel!.transfers![index].description,
      singleEmpModel!.transfers![index].amount,
    ];
  }
}
