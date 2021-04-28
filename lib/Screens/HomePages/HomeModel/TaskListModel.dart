// To parse this JSON data, do
//
//     final todayTaskListModel = todayTaskListModelFromJson(jsonString);

import 'dart:convert';

TodayTaskListModel todayTaskListModelFromJson(String str) => TodayTaskListModel.fromJson(json.decode(str));

String todayTaskListModelToJson(TodayTaskListModel data) => json.encode(data.toJson());

class TodayTaskListModel {
  TodayTaskListModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory TodayTaskListModel.fromJson(Map<String, dynamic> json) => TodayTaskListModel(
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
    this.taskId,
    this.companyId,
    this.clientId,
    this.employeeId,
    this.categoryId,
    this.addressId,
    this.address,
    this.country,
    this.state,
    this.city,
    this.zipCode,
    this.compMessege,
    this.deadlineDate,
    this.status,
    this.taskMode,
    this.assignedDate,
    this.completedDate,
    this.isQrVerify,
    this.qrVerifyTime,
    this.latitude,
    this.longitude,
    this.isApproved,
    this.updatedAt,
    this.createdAt,
  });

  String id;
  String taskId;
  String companyId;
  String clientId;
  String employeeId;
  String categoryId;
  String addressId;
  String address;
  String country;
  String state;
  String city;
  String zipCode;
  String compMessege;
  DateTime deadlineDate;
  String status;
  String taskMode;
  DateTime assignedDate;
  dynamic completedDate;
  String isQrVerify;
  dynamic qrVerifyTime;
  String latitude;
  String longitude;
  String isApproved;
  dynamic updatedAt;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    taskId: json["task_id"],
    companyId: json["company_id"],
    clientId: json["client_id"],
    employeeId: json["employee_id"],
    categoryId: json["category_id"],
    addressId: json["address_id"],
    address: json["address"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    zipCode: json["zip_code"],
    compMessege: json["comp_messege"],
    deadlineDate: DateTime.parse(json["deadline_date"]),
    status: json["status"],
    taskMode: json["task_mode"],
    assignedDate: DateTime.parse(json["assigned_date"]),
    completedDate: json["completed_date"],
    isQrVerify: json["is_qr_verify"],
    qrVerifyTime: json["qr_verify_time"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isApproved: json["is_approved"],
    updatedAt: json["updated_at"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_id": taskId,
    "company_id": companyId,
    "client_id": clientId,
    "employee_id": employeeId,
    "category_id": categoryId,
    "address_id": addressId,
    "address": address,
    "country": country,
    "state": state,
    "city": city,
    "zip_code": zipCode,
    "comp_messege": compMessege,
    "deadline_date": deadlineDate.toIso8601String(),
    "status": status,
    "task_mode": taskMode,
    "assigned_date": assignedDate.toIso8601String(),
    "completed_date": completedDate,
    "is_qr_verify": isQrVerify,
    "qr_verify_time": qrVerifyTime,
    "latitude": latitude,
    "longitude": longitude,
    "is_approved": isApproved,
    "updated_at": updatedAt,
    "created_at": createdAt.toIso8601String(),
  };
}
