class SafeModel {
  SafeModel({
    this.id,
    this.userId,
    this.name,
    this.account,
    this.archive,
  });
  String? id;
  String? userId;
  String? name;
  num? account;
  bool? archive;

  SafeModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    name = json['name'];
    account = json['account'];
    archive = json['archive'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    // data['_id'] = id;
    // data['userId'] = userId;
    data['name'] = name;
    data['isBank'] = false;
    data['account'] = account;
    data['archive'] = archive ?? false;
    return data;
  }
}
