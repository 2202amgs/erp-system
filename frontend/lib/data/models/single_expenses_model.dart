import 'package:frontend/data/models/expenses_model.dart';
import 'package:frontend/data/models/transfer_model.dart';

class SingleExpensesModel {
  ExpensesModel? expenses;
  List<TransferModel>? transfers;
  num? total;

  SingleExpensesModel({this.expenses, this.transfers, this.total});

  SingleExpensesModel.fromJson(Map<String, dynamic> json) {
    expenses = json['expenses'] != null
        ? ExpensesModel.fromJson(json['expenses'])
        : null;
    if (json['transfers'] != null) {
      transfers = <TransferModel>[];
      json['transfers'].forEach((v) {
        transfers!.add(TransferModel.fromJson(v));
      });
    }
    total = json['total'];
  }
}
