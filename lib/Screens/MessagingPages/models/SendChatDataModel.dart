// To parse this JSON data, do
//
//     final sendChatDataModel = sendChatDataModelFromJson(jsonString);

import 'dart:convert';

SendChatDataModel sendChatDataModelFromJson(String str) => SendChatDataModel.fromJson(json.decode(str));

String sendChatDataModelToJson(SendChatDataModel data) => json.encode(data.toJson());

class SendChatDataModel {
  SendChatDataModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory SendChatDataModel.fromJson(Map<String, dynamic> json) => SendChatDataModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.fromId,
    this.toId,
    this.message,
    this.attachment,
    this.path,
    this.date,
  });

  String fromId;
  String toId;
  String message;
  String attachment;
  String path;
  String date;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fromId: json["fromId"],
    toId: json["toId"],
    message: json["message"],
    attachment: json["attachment"],
    path: json["path"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "fromId": fromId,
    "toId": toId,
    "message": message,
    "attachment": attachment,
    "path": path,
    "date": date,
  };
}
