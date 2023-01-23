import 'package:frontend/data/models/car_model.dart';
import 'package:frontend/data/models/shipment_model.dart';
import 'package:frontend/data/models/transfer_model.dart';

class SingleCarModel {
  CarModel? car;
  CarDataModel? data;
  List<ShipmentModel> shipments = [];
  List<TransferModel> transfers = [];

  SingleCarModel(
      {this.car, this.data, required this.shipments, required this.transfers});

  SingleCarModel.fromJson(Map<String, dynamic> json) {
    car = json['car'] != null ? CarModel.fromJson(json['car']) : null;
    data = json['data'] != null ? CarDataModel.fromJson(json['data']) : null;
    if (json['shipments'] != null) {
      shipments = <ShipmentModel>[];
      json['shipments'].forEach((v) {
        shipments.add(ShipmentModel.fromJson(v));
      });
    }
    if (json['transfers'] != null) {
      transfers = <TransferModel>[];
      json['transfers'].forEach((v) {
        transfers.add(TransferModel.fromJson(v));
      });
    }
  }
}

class CarDataModel {
  num? totalNewShipment;
  num? totalNewAdvance;
  num? totalNewShipmentForCar;
  num? totalNewAdvanceForCar;
  num? totalNewShipmentForLoco;
  num? totalNewAdvanceForLoco;
  num? oldTotal;
  num? oldTotalForCar;
  num? oldTotalForLoco;
  num? newTotal;
  num? newTotalForCar;
  num? newTotalForLoco;
  num? totalCustody;
  num? total;
  num? totalDifferenceNolon;

  CarDataModel.fromJson(Map<String, dynamic> json) {
    totalNewShipment = json['totalNewShipment'];
    totalNewAdvance = json['totalNewAdvance'];
    totalNewShipmentForCar = json['totalNewShipmentForCar'];
    totalNewAdvanceForCar = json['totalNewAdvanceForCar'];
    totalNewShipmentForLoco = json['totalNewShipmentForLoco'];
    totalNewAdvanceForLoco = json['totalNewAdvanceForLoco'];
    oldTotal = json['oldTotal'];
    oldTotalForCar = json['oldTotalForCar'];
    oldTotalForLoco = json['oldTotalForLoco'];
    newTotal = json['newTotal'];
    newTotalForCar = json['newTotalForCar'];
    newTotalForLoco = json['newTotalForLoco'];
    totalCustody = json['totalCustody'];
    total = json['total'];
    totalDifferenceNolon = json['totalDifferenceNolon'];
  }
}
