class BuyGoodsModel {
  String? id;
  String? carId;
  String? userId;
  String? supplierID;
  String? typeGoodsID;
  num? carNumber;
  String? driverName;
  String? typeGoodsName;
  String? description;
  String? poneName;
  num? amount;
  num? quantity;
  String? date;
  num? total;

  BuyGoodsModel({
    this.userId,
    this.supplierID,
    this.typeGoodsID,
    this.carNumber,
    this.driverName,
    this.typeGoodsName,
    this.description,
    this.poneName,
    this.amount,
    this.quantity,
    this.date,
    this.id,
    this.total,
  });

  BuyGoodsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    supplierID = json['supplierId'];
    typeGoodsID = json['typeGoodsId'];
    carNumber = json['carNumber'];
    driverName = json['driverName'];
    typeGoodsName = json['typeGoodsName'];
    description = json['description'];
    poneName = json['poneName'];
    amount = json['amount'];
    quantity = json['quantity'];
    date = json['date'];
    id = json['_id'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supplierId'] = supplierID;
    data['typeGoodsId'] = typeGoodsID;
    if (carId != null) {
      data['carId'] = carId;
    }
    data['description'] = description;
    data['poneName'] = poneName;
    data['amount'] = amount;
    data['quantity'] = quantity;
    data['date'] = date;
    // data['carNumber'] = carNumber;
    // data['driverName'] = driverName;
    // data['typeGoodsName'] = typeGoodsName;
    // data['total'] = total;
    return data;
  }
}
