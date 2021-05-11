// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
    this.taskId,
    this.companyId,
    this.employeeId,
    this.message,
    this.createdAt,
    this.deleted,
    this.deletedAt,
    this.employeefirstName,
    this.employeelastName,
  });

  String id;
  String slug;
  String taskId;
  String companyId;
  String employeeId;
  String message;
  String createdAt;
  String deleted;
  dynamic deletedAt;
  String employeefirstName;
  String employeelastName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    slug: json["slug"],
    taskId: json["task_id"],
    companyId: json["company_id"],
    employeeId: json["employee_id"],
    message: json["message"],
    createdAt: json["created_at"],
    deleted: json["deleted"],
    deletedAt: json["deleted_at"],
    employeefirstName: json["EmployeefirstName"],
    employeelastName: json["EmployeelastName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "task_id": taskId,
    "company_id": companyId,
    "employee_id": employeeId,
    "message": message,
    "created_at": createdAt,
    "deleted": deleted,
    "deleted_at": deletedAt,
    "EmployeefirstName": employeefirstName,
    "EmployeelastName": employeelastName,
  };
}
