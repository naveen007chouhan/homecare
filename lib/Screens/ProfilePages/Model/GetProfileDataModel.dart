// To parse this JSON data, do
//
//     final getProfileDataModel = getProfileDataModelFromJson(jsonString);

import 'dart:convert';

GetProfileDataModel getProfileDataModelFromJson(String str) => GetProfileDataModel.fromJson(json.decode(str));

String getProfileDataModelToJson(GetProfileDataModel data) => json.encode(data.toJson());

class GetProfileDataModel {
  GetProfileDataModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory GetProfileDataModel.fromJson(Map<String, dynamic> json) => GetProfileDataModel(
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
    this.id,
    this.slug,
    this.companyId,
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
    this.countryName,
    this.stateName,
    this.cityName,
    this.companyName,
    this.createdAt,
    this.status,
    this.deleted,
    this.deletedAt,
    this.updatedAt,
  });

  String id;
  String slug;
  String companyId;
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
  String countryName;
  String stateName;
  String cityName;
  String companyName;
  DateTime createdAt;
  String status;
  String deleted;
  String deletedAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    slug: json["slug"],
    companyId: json["company_id"],
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
    countryName: json["countryName"],
    stateName: json["stateName"],
    cityName: json["cityName"],
    companyName: json["CompanyName"],
    createdAt: DateTime.parse(json["created_at"]),
    status: json["status"],
    deleted: json["deleted"],
    deletedAt: json["deleted_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "company_id": companyId,
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
    "countryName": countryName,
    "stateName": stateName,
    "cityName": cityName,
    "CompanyName": companyName,
    "created_at": createdAt.toIso8601String(),
    "status": status,
    "deleted": deleted,
    "deleted_at": deletedAt,
    "updated_at": updatedAt.toIso8601String(),
  };
}
