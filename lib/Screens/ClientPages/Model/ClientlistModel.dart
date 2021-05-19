// To parse this JSON data, do
//
//     final clientListModel = clientListModelFromJson(jsonString);

import 'dart:convert';

ClientListModel clientListModelFromJson(String str) => ClientListModel.fromJson(json.decode(str));

String clientListModelToJson(ClientListModel data) => json.encode(data.toJson());

class ClientListModel {
  ClientListModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory ClientListModel.fromJson(Map<String, dynamic> json) => ClientListModel(
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
    this.clientId,
    this.companyId,
    this.clientFirstname,
    this.clientLastname,
    this.clientEmail,
    this.clientMobile,
    this.companyName,
  });

  String clientId;
  String companyId;
  String clientFirstname;
  String clientLastname;
  String clientEmail;
  String clientMobile;
  String companyName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    clientId: json["client_id"],
    companyId: json["companyID"],
    clientFirstname: json["client_firstname"],
    clientLastname: json["client_lastname"],
    clientEmail: json["client_email"],
    clientMobile: json["client_mobile"],
    companyName: json["CompanyName"],
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "companyID": companyId,
    "client_firstname": clientFirstname,
    "client_lastname": clientLastname,
    "client_email": clientEmail,
    "client_mobile": clientMobile,
    "CompanyName": companyName,
  };
}
