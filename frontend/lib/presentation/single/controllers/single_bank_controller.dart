import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/datasources/bank_data.dart';
import 'package:frontend/data/models/single_bank_model.dart';
import 'package:get/get.dart';

class SingleBankController extends GetxController {
  /// Section 1
  /// ===> Varibles
  late String bankId;
  final BankData _bankData = BankData();
  SingleBankModel? singleBankModel;
  bool loading = false;
  DateTimeRange dateTimeRange = DateTimeRange(
    start: firstDayInLastMonth(),
    end: DateTime.now(),
  );

  /// Section 2
  /// ===> Server Functions
  Future<void> getSingleBank() async {
    loading = true;
    update();
    singleBankModel = await _bankData.show(
      bankId,
      dateTimeRange,
    );
    loading = false;
    update();
  }

  /// Section 3
  /// ===> Life Cycle
  @override
  void onInit() {
    bankId = Get.arguments[AppArguments.bankId];
    getSingleBank();
    super.onInit();
  }
}
