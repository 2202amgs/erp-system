import 'package:flutter/material.dart';
import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/models/client_model.dart';
import 'package:frontend/data/models/single_client_model.dart';

class ClientData {
  // GET
  Future<List<ClientModel>> get({bool isClient = true}) async {
    List<ClientModel> data = []; // List Of Car
    var res = await DioConsumer.get(EndPoint.clients,
        queryParameters: {"isClient": isClient}); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      for (var item in res.data) {
        data.add(ClientModel.fromJson(item));
      }
    }
    return data;
  }

  // CREATE
  Future<void> create(ClientModel clientModel) async {
    await DioConsumer.post(EndPoint.clients, body: clientModel.toJson());
  }

  // UPDATE
  Future<void> update(ClientModel clientModel) async {
    await DioConsumer.put(
      EndPoint.clients + clientModel.id.toString(),
      body: clientModel.toJson(),
    );
  }

  // DELETE
  Future<void> delete(String id) async {
    await DioConsumer.delete(EndPoint.clients + id);
  }

  // SHOW
  Future<SingleClientModel?> show(String id, DateTimeRange date) async {
    SingleClientModel? data; // List Of Car
    var res = await DioConsumer.get(EndPoint.clients + id, queryParameters: {
      "start": printDate(date.start),
      "end": printDate(date.end),
    }); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      data = SingleClientModel.fromJson(res.data);
    }
    return data;
  }
}
