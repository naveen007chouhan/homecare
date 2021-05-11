// To parse this JSON data, do
//
//     final dashboardDetailModel = dashboardDetailModelFromJson(jsonString);

import 'dart:convert';

DashboardDetailModel dashboardDetailModelFromJson(String str) => DashboardDetailModel.fromJson(json.decode(str));

String dashboardDetailModelToJson(DashboardDetailModel data) => json.encode(data.toJson());

class DashboardDetailModel {
  DashboardDetailModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory DashboardDetailModel.fromJson(Map<String, dynamic> json) => DashboardDetailModel(
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
    this.employeeDetail,
    this.totalTask,
    this.pendingTask,
    this.processingTask,
    this.completeTask,
    this.approvedTask,
    this.rejectedTask,
    this.totalClient,
  });

  EmployeeDetail employeeDetail;
  int totalTask;
  int pendingTask;
  int processingTask;
  int completeTask;
  int approvedTask;
  int rejectedTask;
  int totalClient;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    employeeDetail: EmployeeDetail.fromJson(json["Employee_detail"]),
    totalTask: json["totalTask"],
    pendingTask: json["pendingTask"],
    processingTask: json["processingTask"],
    completeTask: json["CompleteTask"],
    approvedTask: json["Approved_Task"],
    rejectedTask: json["Rejected_task"],
    totalClient: json["total_client"],
  );

  Map<String, dynamic> toJson() => {
    "Employee_detail": employeeDetail.toJson(),
    "totalTask": totalTask,
    "pendingTask": pendingTask,
    "processingTask": processingTask,
    "CompleteTask": completeTask,
    "Approved_Task": approvedTask,
    "Rejected_task": rejectedTask,
    "total_client": totalClient,
  };
}

class EmployeeDetail {
  EmployeeDetail({
    this.id,
    this.slug,
    this.employeeDetailCompanyId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNo,
    this.profileImg,
    this.path,
    this.deviceId,
    this.fcmId,
    this.address,
    this.country,
    this.state,
    this.city,
    this.zip,
    this.createdAt,
    this.status,
    this.deleted,
    this.deletedAt,
    this.updatedAt,
    this.countryName,
    this.stateName,
    this.cityName,
    this.companyId,
    this.companyName,
    this.contPername,
    this.compEmail,
    this.companyLogo,
    this.companyMobile,
    this.companyPath,
    this.companyCode,
  });

  String id;
  String slug;
  String employeeDetailCompanyId;
  String firstName;
  String lastName;
  String email;
  String mobileNo;
  String profileImg;
  String path;
  String deviceId;
  String fcmId;
  String address;
  String country;
  String state;
  String city;
  String zip;
  DateTime createdAt;
  String status;
  String deleted;
  String deletedAt;
  DateTime updatedAt;
  String countryName;
  String stateName;
  String cityName;
  String companyId;
  String companyName;
  String contPername;
  String compEmail;
  String companyLogo;
  String companyMobile;
  String companyPath;
  String companyCode;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
    id: json["id"],
    slug: json["slug"],
    employeeDetailCompanyId: json["company_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    profileImg: json["profile_img"],
    path: json["path"],
    deviceId: json["device_id"],
    fcmId: json["fcm_id"],
    address: json["address"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    zip: json["zip"],
    createdAt: DateTime.parse(json["created_at"]),
    status: json["status"],
    deleted: json["deleted"],
    deletedAt: json["deleted_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    countryName: json["countryName"],
    stateName: json["stateName"],
    cityName: json["cityName"],
    companyId: json["companyId"],
    companyName: json["companyName"],
    contPername: json["contPername"],
    compEmail: json["compEmail"],
    companyLogo: json["companyLogo"],
    companyMobile: json["companyMobile"],
    companyPath: json["companyPath"],
    companyCode: json["CompanyCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "company_id": employeeDetailCompanyId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile_no": mobileNo,
    "profile_img": profileImg,
    "path": path,
    "device_id": deviceId,
    "fcm_id": fcmId,
    "address": address,
    "country": country,
    "state": state,
    "city": city,
    "zip": zip,
    "created_at": createdAt.toIso8601String(),
    "status": status,
    "deleted": deleted,
    "deleted_at": deletedAt,
    "updated_at": updatedAt.toIso8601String(),
    "countryName": countryName,
    "stateName": stateName,
    "cityName": cityName,
    "companyId": companyId,
    "companyName": companyName,
    "contPername": contPername,
    "compEmail": compEmail,
    "companyLogo": companyLogo,
    "companyMobile": companyMobile,
    "companyPath": companyPath,
    "CompanyCode": companyCode,
  };
}
