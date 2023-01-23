class UserModel {
  String? id;
  String? name;
  bool? isAdmin;
  String? email;
  String? password;
  bool? archive;

  UserModel({
    this.id,
    this.name,
    this.isAdmin,
    this.email,
    this.password,
    this.archive,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    isAdmin = json['isAdmin'];
    email = json['email'];
    archive = json['archive'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['password'] = password;
    data['email'] = email;
    data['isAdmin'] = isAdmin ?? false;
    data['archive'] = archive;
    return data;
  }
}
