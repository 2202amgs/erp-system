import 'package:frontend/data/models/buygoods_model.dart';
import 'package:frontend/data/models/client_model.dart';
import 'package:frontend/data/models/shipment_model.dart';
import 'package:frontend/data/models/transfer_model.dart';

class SingleClientModel {
  ClientModel? client;
  List<ShipmentModel>? shipments;
  List<TransferModel>? transfers;
  List<BuyGoodsModel>? buyGoods;
  Data? data;

  SingleClientModel(
      {this.client, this.shipments, this.transfers, this.buyGoods, this.data});

  SingleClientModel.fromJson(Map<String, dynamic> json) {
    client =
        json['client'] != null ? ClientModel.fromJson(json['client']) : null;
    if (json['shipments'] != null) {
      shipments = <ShipmentModel>[];
      json['shipments'].forEach((v) {
        shipments!.add(ShipmentModel.fromJson(v));
      });
    }
    if (json['transfers'] != null) {
      transfers = <TransferModel>[];
      json['transfers'].forEach((v) {
        transfers!.add(TransferModel.fromJson(v));
      });
    }
    if (json['buyGoods'] != null) {
      buyGoods = <BuyGoodsModel>[];
      json['buyGoods'].forEach((v) {
        buyGoods!.add(BuyGoodsModel.fromJson(v));
      });
    }
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  num? newTransfers;
  num? newShipment;
  num? newBuyGoods;
  num? oldTotal;
  num? newTotal;

  Data(
      {this.newTransfers,
      this.newShipment,
      this.newBuyGoods,
      this.newTotal,
      this.oldTotal});

  Data.fromJson(Map<String, dynamic> json) {
    newTransfers = json['newTransfers'];
    newShipment = json['newShipment'];
    newBuyGoods = json['newBuyGoods'];
    oldTotal = json['oldTotal'];
    newTotal = json['newTotal'];
  }
}
