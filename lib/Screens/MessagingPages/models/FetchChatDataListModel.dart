// To parse this JSON data, do
//
//     final fetchChatDataListModel = fetchChatDataListModelFromJson(jsonString);

import 'dart:convert';

FetchChatDataListModel fetchChatDataListModelFromJson(String str) => FetchChatDataListModel.fromJson(json.decode(str));

String fetchChatDataListModelToJson(FetchChatDataListModel data) => json.encode(data.toJson());

class FetchChatDataListModel {
  FetchChatDataListModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory FetchChatDataListModel.fromJson(Map<String, dynamic> json) => FetchChatDataListModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.slug,
    this.fromId,
    this.toId,
    this.message,
    this.attachment,
    this.date,
    this.path,
    this.deleted,
    this.deletedAt,
  });

  String id;
  String slug;
  String fromId;
  String toId;
  String message;
  String attachment;
  DateTime date;
  String path;
  String deleted;
  String deletedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    slug: json["slug"],
    fromId: json["fromId"],
    toId: json["toId"],
    message: json["message"],
    attachment: json["attachment"],
    date: DateTime.parse(json["date"]),
    path: json["path"],
    deleted: json["deleted"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "fromId": fromId,
    "toId": toId,
    "message": message,
    "attachment": attachment,
    "date": date.toIso8601String(),
    "path": path,
    "deleted": deleted,
    "deleted_at": deletedAt,
  };
}
