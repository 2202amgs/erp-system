import 'package:flutter/material.dart';
import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/models/car_model.dart';
import 'package:frontend/data/models/single_car_model.dart';

class CarData {
  // GET
  Future<List<CarModel>> get() async {
    List<CarModel> data = []; // List Of Car
    var res = await DioConsumer.get(EndPoint.cars); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      for (var item in res.data) {
        data.add(CarModel.fromJson(item));
      }
    }
    return data;
  }

  // CREATE
  Future<void> create(CarModel carModel) async {
    await DioConsumer.post(EndPoint.cars, body: carModel.toJson());
  }

  // UPDATE
  Future<void> update(CarModel carModel) async {
    await DioConsumer.put(
      EndPoint.cars + carModel.id.toString(),
      body: carModel.toJson(),
    );
  }

  // DELETE
  // Future<void> delete(String id) async {
  //   await DioConsumer.delete(EndPoint.cars + id);
  // }

  // SHOW
  Future<SingleCarModel?> show(String id, DateTimeRange date) async {
    SingleCarModel? data;
    var res = await DioConsumer.get(EndPoint.cars + id, queryParameters: {
      "start": printDate(date.start),
      "end": printDate(date.end),
    }); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      data = SingleCarModel.fromJson(res.data);
    }
    return data;
  }
}
