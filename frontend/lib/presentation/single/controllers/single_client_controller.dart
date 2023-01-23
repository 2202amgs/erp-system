import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/datasources/client_data.dart';
import 'package:frontend/data/models/buygoods_model.dart';
import 'package:frontend/data/models/shipment_model.dart';
import 'package:frontend/data/models/single_client_model.dart';
import 'package:get/get.dart';

class SingleClientController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers

  /// Section 2
  /// ===> Varibles
  late String clientId;
  final ClientData _singleClientData = ClientData();
  SingleClientModel? singleClientModel;
  bool loading = false;
  DateTimeRange dateTimeRange =
      DateTimeRange(start: firstDayInLastMonth(), end: DateTime.now());

  /// Section 4
  /// ===> Server Functions
  void getSingleClient() async {
    loading = true;
    update();
    singleClientModel = await _singleClientData.show(
      clientId,
      dateTimeRange,
    );
    loading = false;
    update();
  }

  /// Section 5
  /// ===> Life Cycle
  @override
  void onInit() {
    clientId = Get.arguments[AppArguments.clientId];
    getSingleClient();
    super.onInit();
  }

  List<String> get column => [
        'م',
        'التاريخ',
        'اسم السائق',
        'رقم السيارة',
        'رقم المقطورة',
        'المصنع',
        'اسم البون',
        'الجهة',
        'كمية',
        'نولون',
        'اكرامية',
        'تعتيق',
        'الإجمالى',
        'قيمة الربح',
        'اجمالى الربح',
      ];

  List<DataCell> cells(ShipmentModel s, int index) {
    return [
      (index + 1).toString(),
      s.date.toString().substring(0, 10),
      s.driverName.toString(),
      s.carNumber.toString(),
      s.locoNumber.toString(),
      s.factory.toString(),
      s.poneName.toString(),
      s.side.toString(),
      s.quantity.toString(),
      (s.nolon! + s.profitValue!).toString(),
      s.tip.toString(),
      s.t3t.toString(),
      s.clientTotal.toString(),
      s.profitValue.toString(),
      s.profitTotal.toString(),
    ].map((s) => DataCell(Text(s))).toList();
  }

  List<DataColumn> buyGoodsColumn() {
    return [
      'م',
      'التاريخ',
      'اسم السائق',
      'رقم السيارة',
      'نوع البضاعة',
      'اسم البون',
      'كمية',
      'السعر',
      'الإجمالى',
      'الوصف',
    ].map((e) => DataColumn(label: Text(e))).toList();
  }

  List buyGoodsCells(
    BuyGoodsModel bg,
    int index,
  ) =>
      [
        (index + 1).toString(),
        bg.date.toString().substring(0, 10),
        bg.driverName.toString(),
        bg.carNumber.toString(),
        bg.typeGoodsName.toString(),
        bg.poneName.toString(),
        bg.quantity.toString(),
        bg.amount.toString(),
        bg.total.toString(),
        bg.description.toString(),
      ];
}
