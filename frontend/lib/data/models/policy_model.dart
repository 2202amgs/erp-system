class PolicyModel {
  PolicyModel({
    this.id,
    this.userId,
    this.description,
    this.amount,
    this.date,
  });
  String? id;
  String? userId;
  String? description;
  num? amount;
  String? date;

  PolicyModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    description = json['description'];
    amount = json['amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['amount'] = amount;
    data['date'] = date;
    return data;
  }
}
