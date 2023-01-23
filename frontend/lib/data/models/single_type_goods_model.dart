import 'package:frontend/data/models/buygoods_model.dart';
import 'package:frontend/data/models/shipment_model.dart';
import 'package:frontend/data/models/typegoods_model.dart';

class SingleTypeGoodsModel {
  TypeGoodsModel? typeGoods;
  List<ShipmentModel>? shipments;
  List<BuyGoodsModel>? buyGoods;
  num? quantity;

  SingleTypeGoodsModel({
    this.typeGoods,
    this.shipments,
    this.buyGoods,
    this.quantity,
  });

  SingleTypeGoodsModel.fromJson(Map<String, dynamic> json) {
    typeGoods = json['typeGoods'] != null
        ? TypeGoodsModel.fromJson(json['typeGoods'])
        : null;
    if (json['shipments'] != null) {
      shipments = <ShipmentModel>[];
      json['shipments'].forEach((v) {
        shipments!.add(ShipmentModel.fromJson(v));
      });
    }
    if (json['buyGoods'] != null) {
      buyGoods = <BuyGoodsModel>[];
      json['buyGoods'].forEach((v) {
        buyGoods!.add(BuyGoodsModel.fromJson(v));
      });
    }
    quantity = json['quantity'];
  }
}
