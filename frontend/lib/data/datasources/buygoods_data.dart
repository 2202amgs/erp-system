import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/data/models/buygoods_model.dart';

class BuyGoodsData {
  // CREATE
  Future<void> create(BuyGoodsModel buyGoodsModel) async {
    await DioConsumer.post(
      EndPoint.buyGoods,
      body: buyGoodsModel.toJson(),
    );
  }

  // UPDATE
  Future<void> update(BuyGoodsModel buyGoodsModel) async {
    await DioConsumer.put(
      EndPoint.buyGoods + buyGoodsModel.id.toString(),
      body: buyGoodsModel.toJson(),
    );
  }

  // DELETE
  Future<void> delete(String id) async {
    await DioConsumer.delete(EndPoint.buyGoods + id);
  }
}
