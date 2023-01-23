class EmpMoneyModel {
  String? id;
  String? userId;
  String? employeeId;
  num? amount;
  String? description;
  String? date;

  EmpMoneyModel({
    this.id,
    this.userId,
    this.employeeId,
    this.amount,
    this.description,
    this.date,
  });

  EmpMoneyModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    employeeId = json['employeeId'];
    amount = json['amount'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['userId'] = userId;
    data['employeeId'] = employeeId;
    data['amount'] = amount;
    data['description'] = description;
    data['date'] = date;
    return data;
  }
}
