class ClientModel {
  String? id;
  String? userId;
  String? clientName;
  String? ponName;
  String? phone;
  bool? archive;
  bool? isClient;

  ClientModel({
    this.id,
    this.userId,
    this.clientName,
    this.ponName,
    this.phone,
    this.archive,
    this.isClient,
  });

  ClientModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'] ?? '';
    clientName = json['clientName'] ?? '';
    ponName = json['ponName'] ?? '';
    phone = json['phone'] ?? '';
    archive = json['archive'] ?? false;
    isClient = json['isClient'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    // data['_id'] = id;
    // data['userId'] = userId;
    data['clientName'] = clientName;
    data['ponName'] = ponName;
    data['phone'] = phone;
    data['archive'] = archive ?? false;
    data['isClient'] = isClient ?? true;
    return data;
  }
}
