import 'package:flutter/material.dart';
import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/models/empmoney_model.dart';
import 'package:frontend/data/models/single_emp_model.dart';

class EmpMoneyData {
  // CREATE
  Future<void> create(EmpMoneyModel empMoneyModel) async {
    await DioConsumer.post(EndPoint.empMoney, body: empMoneyModel.toJson());
  }

  // UPDATE
  Future<void> update(EmpMoneyModel empMoneyModel) async {
    await DioConsumer.put(
      EndPoint.empMoney + empMoneyModel.id.toString(),
      body: empMoneyModel.toJson(),
    );
  }

  // DELETE
  Future<void> delete(String id) async {
    await DioConsumer.delete(EndPoint.empMoney + id);
  }

  // SHOW
  Future<SingleEmpModel?> get(String id, DateTimeRange date) async {
    SingleEmpModel? data;
    var res = await DioConsumer.get(EndPoint.employee + id, queryParameters: {
      "start": printDate(date.start),
      "end": printDate(date.end),
    }); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      data = SingleEmpModel.fromJson(res.data);
    }
    return data;
  }
}
