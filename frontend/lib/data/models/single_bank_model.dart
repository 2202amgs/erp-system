import 'package:frontend/data/models/bank_model.dart';
import 'package:frontend/data/models/transfer_model.dart';

class SingleBankModel {
  BankModel? bank;
  List<TransferModel>? transfers;
  int? total;

  SingleBankModel({this.bank, this.transfers, this.total});

  SingleBankModel.fromJson(Map<String, dynamic> json) {
    bank = json['bank'] != null ? BankModel.fromJson(json['bank']) : null;
    if (json['transfers'] != null) {
      transfers = <TransferModel>[];
      json['transfers'].forEach((v) {
        transfers!.add(TransferModel.fromJson(v));
      });
    }
    total = json['total'];
  }
}
