import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/constants/object_types.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/app/core/types/car_table_type.dart';
import 'package:frontend/data/datasources/car_data.dart';
import 'package:frontend/data/models/single_car_model.dart';
import 'package:frontend/data/models/transfer_model.dart';
import 'package:get/get.dart';

class SingleCarController extends GetxController {
  /// Section 1
  /// ===> Varibles
  late CarTableType tableType;
  num totalAdvance = 0;
  late String carId;
  final CarData _carData = CarData();
  SingleCarModel? singleCarModel;
  bool loading = false;
  DateTimeRange dateTimeRange = DateTimeRange(
    start: firstDayInLastMonth(),
    end: DateTime.now(),
  );

  /// Section 2
  /// ===> Local Functions
  void setType(CarTableType type) {
    tableType = type;
  }

  List<TransferModel> getTransfers() {
    late List<TransferModel> transfers;
    switch (tableType) {
      case CarTableType.forCar:
        transfers = singleCarModel!.transfers
            .where((transfer) =>
                transfer.senderType == ObjectTypes.car ||
                transfer.receiverType == ObjectTypes.car)
            .toList();
        totalAdvance = singleCarModel!.data!.totalNewAdvanceForCar!;
        break;
      case CarTableType.forLoco:
        transfers = singleCarModel!.transfers
            .where((transfer) =>
                transfer.senderType == ObjectTypes.loco ||
                transfer.receiverType == ObjectTypes.loco)
            .toList();
        totalAdvance = singleCarModel!.data!.totalNewAdvanceForLoco!;
        break;
      default:
        transfers = singleCarModel!.transfers;
        totalAdvance = singleCarModel!.data!.totalNewAdvance!;
    }
    return transfers;
  }

  List getTotalList() {
    var data = singleCarModel!.data!;
    List list;
    switch (tableType) {
      case CarTableType.forCar:
        num total = data.oldTotalForCar! + data.newTotalForCar!;
        num totalMoneyProfit =
            data.totalNewAdvanceForCar! + data.totalDifferenceNolon!;
        list = [
          {
            "title": 'إجمــــالى تشغيل السيارة',
            "value": data.totalNewShipmentForCar
          },
          {"title": 'إجمالى مسحوبات السيارة', "value": totalMoneyProfit},
          {"title": 'صــــــافى تشغيل السيارة', "value": total},
        ];
        break;
      case CarTableType.forLoco:
        num total = data.oldTotalForLoco! + data.newTotalForLoco!;
        num totalMoneyProfit = data.totalNewAdvanceForLoco!;
        list = [
          {
            "title": 'إجمــــالى تشغيل المقطورة',
            "value": data.totalNewShipmentForLoco
          },
          {"title": 'إجمالى مسحوبات المقطورة', "value": totalMoneyProfit},
          {"title": 'صــــــافى تشغيل المقطورة', "value": total},
        ];
        break;
      default:
        num total = data.oldTotal! + data.newTotal!;
        num totalMoneyProfit =
            data.totalNewAdvance! + data.totalDifferenceNolon!;
        list = [
          {'title': 'إجمــــالى تشغيل السيارة', 'value': data.total!},
          {'title': 'إجمــــالى عهدة التشغيل', 'value': data.totalCustody!},
          {'title': 'إجمالى المبالغ المسحوبة', 'value': totalMoneyProfit},
          {'title': 'صــــــافى تشغيل السيارة', 'value': total},
        ];
    }
    return list;
  }

  /// Section 3
  /// ===> Server Functions
  Future<void> getSingleCar() async {
    loading = true;
    update();
    singleCarModel = await _carData.show(
      carId,
      dateTimeRange,
    );
    loading = false;
    if (singleCarModel!.car!.sailon!) {
      tableType = CarTableType.sailon;
    } else {
      tableType = CarTableType.noramal;
    }
    update();
  }

  /// Section 5
  /// ===> Life Cycle
  @override
  void onInit() {
    carId = Get.arguments[AppArguments.carId];
    getSingleCar();
    super.onInit();
  }

  List<String> get columns => [
        'م',
        'التاريخ',
        'اسم العميل',
        'اسم السائق',
        'المصنع',
        'الجهة',
        'اسم البون',
        'كمية',
        'نولون',
        'إكرامية',
        'تعتيق',
        'المبلغ',
        if (tableType != CarTableType.forLoco) 'العهدة',
        if (tableType == CarTableType.noramal) 'باقى النولون',
        'الصافى',
        if (tableType == CarTableType.forCar ||
            tableType == CarTableType.sailon)
          'صافى النقلة السيارة',
        if (tableType == CarTableType.forLoco ||
            tableType == CarTableType.sailon)
          'صافى النقلة المقطورة'
      ];
  List<String> get columnsOfAdvance => [
        'التاريخ',
        'الوصف',
        'المبلغ',
      ];
}
