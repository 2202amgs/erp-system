import 'package:flutter/material.dart';
import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/models/single_type_goods_model.dart';
import 'package:frontend/data/models/typegoods_model.dart';

class TypeGoodsData {
  // GET
  Future<List<TypeGoodsModel>> get() async {
    List<TypeGoodsModel> data = []; // List Of Car
    var res = await DioConsumer.get(EndPoint.typeGoods); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      for (var item in res.data) {
        data.add(TypeGoodsModel.fromJson(item));
      }
    }
    return data;
  }

  // CREATE
  Future<void> create(TypeGoodsModel typeGoodsModel) async {
    await DioConsumer.post(EndPoint.typeGoods, body: typeGoodsModel.toJson());
  }

  // UPDATE
  Future<void> update(TypeGoodsModel typeGoodsModel) async {
    await DioConsumer.put(
      EndPoint.typeGoods + typeGoodsModel.id.toString(),
      body: typeGoodsModel.toJson(),
    );
  }

  // GET
  Future<SingleTypeGoodsModel?> show(String id, DateTimeRange date) async {
    SingleTypeGoodsModel? data;
    var res = await DioConsumer.get(EndPoint.typeGoods + id, queryParameters: {
      "start": printDate(date.start),
      "end": printDate(date.end),
    }); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      data = SingleTypeGoodsModel.fromJson(res.data);
    }
    return data;
  }

  // DELETE
  // Future<void> delete(String id) async {
  //   await DioConsumer.delete(EndPoint.typeGoods + id);
  // }

  // SHOW
}
