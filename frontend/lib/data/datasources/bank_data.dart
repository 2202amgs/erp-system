import 'package:flutter/material.dart';
import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/models/bank_model.dart';
import 'package:frontend/data/models/single_bank_model.dart';

class BankData {
  // GET
  Future<List<BankModel>> get() async {
    List<BankModel> data = []; // List Of Car
    var res = await DioConsumer.get(EndPoint.banks,
        queryParameters: {"isBank": true}); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      for (var item in res.data) {
        data.add(BankModel.fromJson(item));
      }
    }
    return data;
  }

  // CREATE
  Future<void> create(BankModel bankModel) async {
    await DioConsumer.post(EndPoint.banks, body: bankModel.toJson());
  }

  // UPDATE
  Future<void> update(BankModel bankModel) async {
    await DioConsumer.put(
      EndPoint.banks + bankModel.id.toString(),
      body: bankModel.toJson(),
    );
  }

  // DELETE
  Future<void> delete(String id) async {
    await DioConsumer.delete(EndPoint.banks + id);
  }

  // SHOW
  Future<SingleBankModel?> show(String id, DateTimeRange date) async {
    SingleBankModel? data;
    var res = await DioConsumer.get(EndPoint.banks + id, queryParameters: {
      "start": printDate(date.start),
      "end": printDate(date.end),
    }); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      data = SingleBankModel.fromJson(res.data);
    }
    return data;
  }
}
