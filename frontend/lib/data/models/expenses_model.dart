class ExpensesModel {
  String? id;
  String? name;
  bool? archive;

  ExpensesModel({this.id, this.name, this.archive});

  ExpensesModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    archive = json['archive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['archive'] = archive ?? false;
    return data;
  }
}
