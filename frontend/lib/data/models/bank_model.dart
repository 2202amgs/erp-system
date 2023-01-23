class BankModel {
  BankModel({
    this.id,
    this.userId,
    this.name,
    this.accountNumber,
    this.account,
    this.archive,
  });
  String? id;
  String? userId;
  String? name;
  String? accountNumber;
  num? account;
  bool? archive;

  BankModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    name = json['name'];
    accountNumber = json['accountNumber'];
    account = json['account'];
    archive = json['archive'] ?? false;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['accountNumber'] = accountNumber;
    data['isBank'] = true;
    data['account'] = account;
    data['archive'] = archive ?? false;
    return data;
  }
}
