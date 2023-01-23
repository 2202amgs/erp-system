class ShipmentModel {
  String? id;
  num? carNumber;
  num? locoNumber;
  String? driverName;
  String? factory;
  String? side;
  String? clientName;
  String? poneName;
  String? notes;
  num? custody;
  num? tip;
  num? t3t;
  num? quantity;
  num? nolon;
  num? differenceNolon;
  num? profitValue;
  num? total;
  num? carPureTotal;
  num? clientTotal;
  num? profitTotal;
  bool? isFilled = false;
  num? carRatio;
  num? carTotal;
  num? locoRatio;
  num? locoTotal;
  String? date;
  String? permissionNumber;
  String? userId;
  String? carId;
  String? clientId;
  String? bankId;
  String? typeGoodsId;
  num? price;

  ShipmentModel({
    this.id,
    this.carNumber,
    this.locoNumber,
    this.driverName,
    this.factory,
    this.side,
    this.clientName,
    this.poneName,
    this.notes,
    this.custody,
    this.tip,
    this.t3t,
    this.quantity,
    this.nolon,
    this.differenceNolon,
    this.profitValue,
    this.total,
    this.carPureTotal,
    this.clientTotal,
    this.profitTotal,
    this.userId,
    this.carId,
    this.clientId,
    this.bankId,
    this.isFilled,
    this.carRatio,
    this.carTotal,
    this.locoRatio,
    this.locoTotal,
    this.date,
    this.permissionNumber,
    this.typeGoodsId,
    this.price,
  });

  ShipmentModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    carNumber = json['carNumber'];
    locoNumber = json['locoNumber'];
    driverName = json['driverName'];
    factory = json['factory'];
    permissionNumber = json['permissionNumber'];
    side = json['side'];
    clientName = json['clientName'];
    poneName = json['poneName'];
    notes = json['notes'];
    custody = json['custody'];
    tip = json['tip'];
    t3t = json['t3t'];
    quantity = json['quantity'];
    nolon = json['nolon'];
    differenceNolon = json['differenceNolon'];
    profitValue = json['profitValue'];
    total = json['total'];
    carPureTotal = json['carPureTotal'];
    clientTotal = json['clientTotal'];
    profitTotal = json['profitTotal'];
    isFilled = json['isFilled'];
    if (isFilled!) {
      carRatio = json['carRatio'];
    }
    carTotal = json['carTotal'];
    locoRatio = json['locoRatio'];
    locoTotal = json['locoTotal'];
    date = json['date'];
    userId = json['userId'];
    carId = json['carId'];
    clientId = json['clientId'];
    bankId = json['bankId'];
    typeGoodsId = json['typeGoodsId'];
    price = json['price'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['custody'] = custody ?? 0;
    data['tip'] = tip ?? 0;
    data['t3t'] = t3t ?? 0;
    data['nolon'] = nolon ?? 0;
    data['clientId'] = clientId;
    data['factory'] = factory;
    data['permissionNumber'] = permissionNumber;
    data['side'] = side;
    data['poneName'] = poneName;
    data['quantity'] = quantity;
    data['differenceNolon'] = differenceNolon ?? 0;
    data['profitValue'] = profitValue ?? 0;
    data['isFilled'] = isFilled;
    data['date'] = date;
    if (isFilled!) {
      data['carRatio'] = carRatio;
    }
    if (notes != null) {
      data['notes'] = notes;
    }
    if (custody! > 0) {
      data['bankId'] = bankId;
    }
    data['typeGoodsId'] = typeGoodsId;
    data['price'] = price;
    data['carId'] = carId;
    return data;
  }
}
