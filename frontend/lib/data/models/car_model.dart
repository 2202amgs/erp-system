class CarModel {
  String? id;
  String? userId;
  String? ownerName;
  String? driverName;
  String? phone;
  int? carNumber;
  int? locoNumber;
  int? carRatio;
  bool? sailon;
  bool? archive;

  CarModel({
    this.id,
    this.ownerName,
    this.driverName,
    this.carNumber,
    this.locoNumber,
    this.phone,
    this.carRatio,
    this.sailon,
    this.archive,
  });

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    ownerName = json['ownerName'];
    driverName = json['driverName'];
    carNumber = json['carNumber'];
    locoNumber = json['locoNumber'];
    phone = json['phone'];
    carRatio = json['carRatio'];
    sailon = json['sailon'];
    archive = json['archive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    // data['_id'] = id;
    // data['userId'] = userId;
    data['ownerName'] = ownerName;
    data['driverName'] = driverName;
    data['carNumber'] = carNumber;
    data['locoNumber'] = locoNumber;
    data['phone'] = phone;
    data['archive'] = archive ?? false;
    if (sailon!) {
      data['carRatio'] = carRatio;
      data['sailon'] = sailon;
    }
    return data;
  }
}
