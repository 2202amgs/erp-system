class TransferModel {
  String? userId;
  String? senderId;
  String? senderName;
  String? receiverId;
  String? receiverName;
  String? senderType;
  String? receiverType;
  num? amount;
  String? description;
  String? date;
  String? id;

  TransferModel({
    this.userId,
    this.senderId,
    this.senderName,
    this.receiverName,
    this.amount,
    this.description,
    this.date,
    this.id,
  });

  TransferModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    amount = json['amount'];
    description = json['description'];
    date = json['date'];
    senderType = json['senderType'];
    receiverType = json['receiverType'];
    senderName = json['senderName'];
    receiverName = json['receiverName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['amount'] = amount;
    data['description'] = description;
    data['date'] = date;
    data['senderType'] = senderType;
    data['receiverType'] = receiverType;
    data['senderName'] = senderName;
    data['receiverName'] = receiverName;
    return data;
  }
}
