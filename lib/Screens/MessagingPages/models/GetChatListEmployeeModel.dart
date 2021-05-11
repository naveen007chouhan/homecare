// To parse this JSON data, do
//
//     final getChatListEmployeeModel = getChatListEmployeeModelFromJson(jsonString);

import 'dart:convert';

GetChatListEmployeeModel getChatListEmployeeModelFromJson(String str) => GetChatListEmployeeModel.fromJson(json.decode(str));

String getChatListEmployeeModelToJson(GetChatListEmployeeModel data) => json.encode(data.toJson());

class GetChatListEmployeeModel {
  GetChatListEmployeeModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory GetChatListEmployeeModel.fromJson(Map<String, dynamic> json) => GetChatListEmployeeModel(
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
    this.empId,
    this.companyId,
    this.employeeFirstname,
    this.employeeLastname,
    this.employeeEmail,
    this.employeeMobile,
    this.employeeProfile,
    this.employeePath,
    this.employeeAddress,
    this.countryName,
    this.stateName,
    this.cityName,
    this.companyName,
  });

  String empId;
  String companyId;
  String employeeFirstname;
  String employeeLastname;
  String employeeEmail;
  String employeeMobile;
  String employeeProfile;
  String employeePath;
  String employeeAddress;
  String countryName;
  String stateName;
  String cityName;
  String companyName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    empId: json["EmpId"],
    companyId: json["companyID"],
    employeeFirstname: json["employee_firstname"],
    employeeLastname: json["employee_lastname"],
    employeeEmail: json["employee_email"],
    employeeMobile: json["employee_mobile"],
    employeeProfile: json["employee_profile"],
    employeePath: json["employee_path"],
    employeeAddress: json["employee_Address"],
    countryName: json["countryName"],
    stateName: json["stateName"],
    cityName: json["cityName"],
    companyName: json["CompanyName"],
  );

  Map<String, dynamic> toJson() => {
    "EmpId": empId,
    "companyID": companyId,
    "employee_firstname": employeeFirstname,
    "employee_lastname": employeeLastname,
    "employee_email": employeeEmail,
    "employee_mobile": employeeMobile,
    "employee_profile": employeeProfile,
    "employee_path": employeePath,
    "employee_Address": employeeAddress,
    "countryName": countryName,
    "stateName": stateName,
    "cityName": cityName,
    "CompanyName": companyName,
  };
}
