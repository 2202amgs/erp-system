import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_arguments.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/datasources/typegoods_data.dart';
import 'package:frontend/data/models/buygoods_model.dart';
import 'package:frontend/data/models/shipment_model.dart';
import 'package:frontend/data/models/single_type_goods_model.dart';
import 'package:get/get.dart';

class SingleTypeGoodsController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers

  /// Section 2
  /// ===> Varibles
  late String typeGoodsId;
  final TypeGoodsData _typeGoodsData = TypeGoodsData();
  SingleTypeGoodsModel? singleTypeGoodsModel;
  bool loading = false;
  DateTimeRange dateTimeRange = DateTimeRange(
    start: firstDayInLastMonth(),
    end: DateTime.now(),
  );

  /// Section 4
  /// ===> Server Functions
  Future<void> getSingleTypeGoods() async {
    loading = true;
    update();
    singleTypeGoodsModel = await _typeGoodsData.show(
      typeGoodsId,
      dateTimeRange,
    );
    loading = false;
    update();
  }

  /// Section 5
  /// ===> Life Cycle
  @override
  void onInit() {
    typeGoodsId = Get.arguments[AppArguments.typeGoodsId];
    getSingleTypeGoods();
    super.onInit();
  }

  List<String> get columns => [
        'م',
        'التاريخ',
        'اسم السائق',
        'اسم البون',
        'المبلغ',
        'كمية',
        'الإجمالى',
        'الوصف',
      ];
  List<String> get columnsOfShipments => [
        'م',
        'التاريخ',
        'المصنع',
        'الجهة',
        'اسم العميل',
        'اسم البون',
        'كمية',
        'نولون',
        'المبلغ',
      ];

  List cells(int index) {
    BuyGoodsModel s = singleTypeGoodsModel!.buyGoods![index];
    return [
      (index + 1),
      s.date.toString().substring(0, 10),
      s.driverName,
      s.poneName,
      s.amount,
      s.quantity,
      s.total,
      s.description,
    ];
  }

  List cellsOfShipment(int index) {
    ShipmentModel s = singleTypeGoodsModel!.shipments![index];
    return [
      (index + 1),
      s.date.toString().substring(0, 10),
      s.factory,
      s.side,
      s.clientName,
      s.poneName,
      s.quantity,
      s.nolon,
      s.total,
    ];
  }
}
