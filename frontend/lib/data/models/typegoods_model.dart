class TypeGoodsModel {
  TypeGoodsModel({
    this.id,
    this.userId,
    this.name,
    this.archive,
  });

  String? id;
  String? userId;
  String? name;
  bool? archive;

  TypeGoodsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    userId = json['userId'];
    archive = json['archive'] ?? false;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    // data['_id'] = id;
    // data['userId'] = userId;
    data['name'] = name;
    data['archive'] = archive ?? false;
    return data;
  }
}
