// To parse this JSON data, do
//
//     final allTaskListModel = allTaskListModelFromJson(jsonString);

import 'dart:convert';

AllTaskListModel allTaskListModelFromJson(String str) => AllTaskListModel.fromJson(json.decode(str));

String allTaskListModelToJson(AllTaskListModel data) => json.encode(data.toJson());

class AllTaskListModel {
  AllTaskListModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory AllTaskListModel.fromJson(Map<String, dynamic> json) => AllTaskListModel(
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
    this.logId,
    this.logSlug,
    this.taskName,
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
    this.assignedDate,
    this.completedDate,
    this.isQrVerify,
    this.qrVerifyTime,
    this.latitude,
    this.taskMode,
    this.taskModeName,
    this.longitude,
    this.isApproved,
    this.updatedAt,
    this.createdAt,
    this.empFirstname,
    this.emplastname,
    this.companyName,
    this.clientfirstName,
    this.clientlastName,
    this.countryname,
    this.stateName,
    this.cityName,
    this.categoryName,
    this.taskAttachments,
    this.taskpath,
    this.taskImagemode,
    this.taskImage,
  });

  String logId;
  String logSlug;
  String taskName;
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
  DateTime assignedDate;
  String completedDate;
  String isQrVerify;
  String qrVerifyTime;
  String latitude;
  String taskMode;
  String taskModeName;
  String longitude;
  String isApproved;
  String updatedAt;
  DateTime createdAt;
  String empFirstname;
  String emplastname;
  String companyName;
  String clientfirstName;
  String clientlastName;
  String countryname;
  String stateName;
  String cityName;
  String categoryName;
  String taskAttachments;
  String taskpath;
  int taskImagemode;
  String taskImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    logId: json["log_id"],
    logSlug: json["log_slug"],
    taskName: json["task_name"],
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
    assignedDate: DateTime.parse(json["assigned_date"]),
    completedDate: json["completed_date"],
    isQrVerify: json["is_qr_verify"],
    qrVerifyTime: json["qr_verify_time"],
    latitude: json["latitude"],
    taskMode: json["task_mode"],
    taskModeName: json["task_mode_name"],
    longitude: json["longitude"],
    isApproved: json["is_approved"],
    updatedAt: json["updated_at"],
    createdAt: DateTime.parse(json["created_at"]),
    empFirstname: json["EmpFirstname"],
    emplastname: json["Emplastname"],
    companyName: json["CompanyName"],
    clientfirstName: json["ClientfirstName"],
    clientlastName: json["ClientlastName"],
    countryname: json["Countryname"],
    stateName: json["StateName"],
    cityName: json["CityName"],
    categoryName: json["CategoryName"],
    taskAttachments: json["taskAttachments"],
    taskpath: json["Taskpath"],
    taskImagemode: json["taskImagemode"],
    taskImage: json["taskImage"],
  );

  Map<String, dynamic> toJson() => {
    "log_id": logId,
    "log_slug": logSlug,
    "task_name": taskName,
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
    "assigned_date": assignedDate.toIso8601String(),
    "completed_date": completedDate,
    "is_qr_verify": isQrVerify,
    "qr_verify_time": qrVerifyTime,
    "latitude": latitude,
    "task_mode": taskMode,
    "task_mode_name": taskModeName,
    "longitude": longitude,
    "is_approved": isApproved,
    "updated_at": updatedAt,
    "created_at": createdAt.toIso8601String(),
    "EmpFirstname": empFirstname,
    "Emplastname": emplastname,
    "CompanyName": companyName,
    "ClientfirstName": clientfirstName,
    "ClientlastName": clientlastName,
    "Countryname": countryname,
    "StateName": stateName,
    "CityName": cityName,
    "CategoryName": categoryName,
    "taskAttachments": taskAttachments,
    "Taskpath": taskpath,
    "taskImagemode": taskImagemode,
    "taskImage": taskImage,
  };
}
