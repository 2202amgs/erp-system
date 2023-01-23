import 'package:frontend/data/models/empmoney_model.dart';
import 'package:frontend/data/models/transfer_model.dart';
import 'package:frontend/data/models/user_model.dart';

class SingleEmpModel {
  UserModel? user;
  List<EmpMoneyModel>? empMoney;
  List<TransferModel>? transfers;
  num? account;

  SingleEmpModel({this.user, this.empMoney, this.transfers, this.account});

  SingleEmpModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['empMoney'] != null) {
      empMoney = <EmpMoneyModel>[];
      json['empMoney'].forEach((v) {
        empMoney!.add(EmpMoneyModel.fromJson(v));
      });
    }
    if (json['transfers'] != null) {
      transfers = <TransferModel>[];
      json['transfers'].forEach((v) {
        transfers!.add(TransferModel.fromJson(v));
      });
    }
    account = json['account'];
  }
}
