import 'package:flutter/material.dart';
import 'package:frontend/app/core/api/dio_consumer.dart';
import 'package:frontend/app/core/api/end_points.dart';
import 'package:frontend/app/core/api/status_code.dart';
import 'package:frontend/app/core/shared/functions.dart';
import 'package:frontend/data/models/expenses_model.dart';
import 'package:frontend/data/models/single_expenses_model.dart';

class ExpensesData {
  // GET
  Future<List<ExpensesModel>> get() async {
    List<ExpensesModel> data = []; // List Of Expenses
    var res = await DioConsumer.get(EndPoint.expenses); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      for (var item in res.data) {
        data.add(ExpensesModel.fromJson(item));
      }
    }
    return data;
  }

  // CREATE
  Future<void> create(ExpensesModel expensesModel) async {
    await DioConsumer.post(EndPoint.expenses, body: expensesModel.toJson());
  }

  // UPDATE
  Future<void> update(ExpensesModel expensesModel) async {
    await DioConsumer.put(
      EndPoint.expenses + expensesModel.id.toString(),
      body: expensesModel.toJson(),
    );
  }

  // DELETE
  // Future<void> delete(String id) async {
  //   await DioConsumer.delete(EndPoint.expenses + id);
  // }

  //SHOW
  Future<SingleExpensesModel?> show(String id, DateTimeRange date) async {
    SingleExpensesModel? data;
    var res = await DioConsumer.get(EndPoint.expenses + id, queryParameters: {
      "start": printDate(date.start),
      "end": printDate(date.end),
    }); // Conected To Server
    // Check Response Status Is Ok
    if (res != null && res.statusCode == StatusCode.ok) {
      data = SingleExpensesModel.fromJson(res.data);
    }
    return data;
  }
}
