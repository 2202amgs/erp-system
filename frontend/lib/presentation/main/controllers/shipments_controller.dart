import 'package:flutter/cupertino.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/datasources/shipment_data.dart';
import 'package:frontend/data/models/shipment_model.dart';
import 'package:get/get.dart';

class ShipmentsController extends GetxController {
  /// ===> Section 1
  /// ===> Controllers
  String? carId;
  String? clientId;
  String? bankId;
  String? typeGoodsId;
  final TextEditingController factoryController = TextEditingController();
  final TextEditingController permissionNumberController =
      TextEditingController();
  final TextEditingController sideController = TextEditingController();
  final TextEditingController poneNameController = TextEditingController();
  final TextEditingController custodyController = TextEditingController();
  final TextEditingController tipController = TextEditingController();
  final TextEditingController t3tController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController nolonController = TextEditingController();
  final TextEditingController differenceNolonController =
      TextEditingController();
  final TextEditingController profitValueController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController carRatioController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool isFilled = false;
  bool isCommerce = false;

  /// Section 2
  /// ===> Varibles
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ShipmentData _shipmentData = ShipmentData();
  List<ShipmentModel> shipments = [];
  DateTime dateTime = DateTime.now();
  bool isLoad = false;

  /// Section 3
  /// ===> Config Functions
  void setFilled(bool value) {
    isFilled = value;
    update();
  }

  void setCommerce(bool value) {
    isCommerce = value;
    update();
  }

  void setPonName(String value) {
    poneNameController.text = value;
    update();
  }

  void clearControllers() {
    // car data
    carId = null;
    carRatioController.clear();
    isFilled = false;
    clientId = null;
    bankId = null;
    factoryController.clear();
    permissionNumberController.clear();
    sideController.clear();
    poneNameController.clear();
    quantityController.text = "0";
    profitValueController.text = "0";
    notesController.clear();
    isCommerce = false;
    typeGoodsId = null;
    priceController.text = "0";
    clearCarControllers();
  }

  void clearCarControllers() {
    custodyController.text = "0";
    tipController.text = "0";
    t3tController.text = "0";
    nolonController.text = "0";
    differenceNolonController.text = "0";
  }

  void modelToController(ShipmentModel shipmentModel) {
    carId = shipmentModel.carId;
    clientId = shipmentModel.clientId;
    bankId = shipmentModel.bankId;
    factoryController.text = shipmentModel.factory.toString();
    permissionNumberController.text = shipmentModel.permissionNumber.toString();
    sideController.text = shipmentModel.side.toString();
    poneNameController.text = shipmentModel.poneName!;
    custodyController.text = shipmentModel.custody.toString();
    tipController.text = shipmentModel.tip.toString();
    t3tController.text = shipmentModel.t3t.toString();
    quantityController.text = shipmentModel.quantity.toString();
    nolonController.text = shipmentModel.nolon.toString();
    differenceNolonController.text = shipmentModel.differenceNolon.toString();
    profitValueController.text = shipmentModel.profitValue.toString();
    notesController.text = shipmentModel.notes.toString();
    isFilled = shipmentModel.isFilled!;
    if (isFilled) {
      carRatioController.text = shipmentModel.carRatio.toString();
    }
    isCommerce = shipmentModel.typeGoodsId != null;
    if (isCommerce) {
      typeGoodsId = shipmentModel.typeGoodsId;
      priceController.text = shipmentModel.price!.toString();
    }
  }

  ShipmentModel contollerToModel(ShipmentModel shipmentModel) {
    shipmentModel.carId = carId;
    shipmentModel.clientId = clientId;
    shipmentModel.bankId = bankId;
    shipmentModel.factory = factoryController.text;
    shipmentModel.permissionNumber = permissionNumberController.text;
    shipmentModel.side = sideController.text;
    shipmentModel.poneName = poneNameController.text;
    shipmentModel.custody = num.parse(custodyController.text);
    shipmentModel.tip = num.parse(tipController.text);
    shipmentModel.t3t = num.parse(t3tController.text);
    shipmentModel.quantity = num.parse(quantityController.text);
    shipmentModel.nolon = num.parse(nolonController.text);
    shipmentModel.differenceNolon = num.parse(differenceNolonController.text);
    shipmentModel.profitValue = num.parse(profitValueController.text);
    shipmentModel.notes = notesController.text;
    shipmentModel.isFilled = isFilled;
    shipmentModel.carRatio =
        isFilled ? num.parse(carRatioController.text) : null;

    if (isCommerce) {
      shipmentModel.typeGoodsId = typeGoodsId;
      shipmentModel.price = num.parse(priceController.text);
    }
    shipmentModel.date ??= printDate(dateTime);
    return shipmentModel;
  }

  /// Section 4
  /// ===> Server Functions
  Future<void> getShipments() async {
    isLoad = true;
    update();
    shipments = await _shipmentData.get(dateTime);
    isLoad = false;
    update();
  }

  Future<void> createShipment() async {
    Get.back();
    await _shipmentData.create(contollerToModel(ShipmentModel()));
    getShipments();
  }

  Future<void> shipmentUpdate(ShipmentModel shipmentModel) async {
    Get.back();
    await _shipmentData.update(contollerToModel(shipmentModel));
    // getShipments();
  }

  Future<void> deleteShipment(String id) async {
    Get.back();
    await _shipmentData.delete(id);
    // getShipments();
  }

  /// Section 6
  /// ===> Functions
  List<String> column() => [
        'م',
        'الرأس',
        'المقطورة',
        'السائق',
        'المصنع',
        'الجهة',
        'اسم العميل',
        'اسم البون',
        'العهدة',
        'كمية',
        'نولون',
        'تعتيق',
        'إكرامية',
        'المبلغ',
        'صافى النقلة',
        'ملاحظات',
      ];
  List cells(int index) => [
        (index + 1).toString(),
        shipments[index].carNumber.toString(),
        shipments[index].locoNumber.toString(),
        shipments[index].driverName.toString(),
        shipments[index].factory.toString(),
        shipments[index].side.toString(),
        shipments[index].clientName.toString(),
        shipments[index].poneName.toString(),
        shipments[index].custody.toString(),
        shipments[index].quantity.toString(),
        shipments[index].nolon.toString(),
        shipments[index].t3t.toString(),
        shipments[index].tip.toString(),
        shipments[index].total.toString(),
        shipments[index].carPureTotal.toString(),
        shipments[index].notes.toString(),
      ];
}
