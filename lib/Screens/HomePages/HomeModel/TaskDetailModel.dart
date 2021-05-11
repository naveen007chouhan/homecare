// To parse this JSON data, do
//
//     final taskDetailModel = taskDetailModelFromJson(jsonString);

import 'dart:convert';

TaskDetailModel taskDetailModelFromJson(String str) => TaskDetailModel.fromJson(json.decode(str));

String taskDetailModelToJson(TaskDetailModel data) => json.encode(data.toJson());

class TaskDetailModel {
  TaskDetailModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory TaskDetailModel.fromJson(Map<String, dynamic> json) => TaskDetailModel(
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
    this.attechment,
    this.taskDetail,
  });

  List<Attechment> attechment;
  TaskDetail taskDetail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attechment: List<Attechment>.from(json["Attechment"].map((x) => Attechment.fromJson(x))),
    taskDetail: TaskDetail.fromJson(json["taskDetail"]),
  );

  Map<String, dynamic> toJson() => {
    "Attechment": List<dynamic>.from(attechment.map((x) => x.toJson())),
    "taskDetail": taskDetail.toJson(),
  };
}

class Attechment {
  Attechment({
    this.id,
    this.taskId,
    this.attType,
    this.attachment,
    this.image,
    this.path,
    this.message,
    this.userId,
    this.createdDate,
    this.updatedDate,
    this.empFirstname,
    this.emplastname,
  });

  String id;
  String taskId;
  String attType;
  String attachment;
  String image;
  String path;
  String message;
  String userId;
  DateTime createdDate;
  DateTime updatedDate;
  String empFirstname;
  String emplastname;

  factory Attechment.fromJson(Map<String, dynamic> json) => Attechment(
    id: json["id"],
    taskId: json["task_id"],
    attType: json["att_type"],
    attachment: json["attachment"],
    image: json["image"],
    path: json["path"],
    message: json["message"],
    userId: json["user_id"],
    createdDate: DateTime.parse(json["created_date"]),
    updatedDate: DateTime.parse(json["updated_date"]),
    empFirstname: json["EmpFirstname"],
    emplastname: json["Emplastname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_id": taskId,
    "att_type": attType,
    "attachment": attachment,
    "image": image,
    "path": path,
    "message": message,
    "user_id": userId,
    "created_date": createdDate.toIso8601String(),
    "updated_date": updatedDate.toIso8601String(),
    "EmpFirstname": empFirstname,
    "Emplastname": emplastname,
  };
}

class TaskDetail {
  TaskDetail({
    this.taskId,
    this.taskName,
    this.companyId,
    this.clientId,
    this.categoryId,
    this.employeeId,
    this.addressId,
    this.taskMode,
    this.taskModeName,
    this.countryName,
    this.stateName,
    this.cityName,
    this.address,
    this.message,
    this.assignedDate,
    this.completedDate,
    this.deadlineDate,
    this.taskStatus,
    this.isApproved,
    this.updatedAt,
    this.createdAt,
    this.clientName,
    this.clientEmail,
    this.clientMobile,
    this.taskCategory,
    this.taskpath,
    this.taskImagemode,
    this.taskImage,
    this.taskAttachments,
  });

  String taskId;
  String taskName;
  String companyId;
  String clientId;
  String categoryId;
  String employeeId;
  String addressId;
  String taskMode;
  String taskModeName;
  String countryName;
  String stateName;
  String cityName;
  String address;
  String message;
  DateTime assignedDate;
  String completedDate;
  DateTime deadlineDate;
  String taskStatus;
  String isApproved;
  DateTime updatedAt;
  DateTime createdAt;
  String clientName;
  String clientEmail;
  String clientMobile;
  String taskCategory;
  String taskpath;
  int taskImagemode;
  String taskImage;
  String taskAttachments;

  factory TaskDetail.fromJson(Map<String, dynamic> json) => TaskDetail(
    taskId: json["taskId"],
    taskName: json["task_name"],
    companyId: json["company_id"],
    clientId: json["client_id"],
    categoryId: json["category_id"],
    employeeId: json["employee_id"],
    addressId: json["address_id"],
    taskMode: json["task_mode"],
    taskModeName: json["task_mode_name"],
    countryName: json["CountryName"],
    stateName: json["StateName"],
    cityName: json["CityName"],
    address: json["address"],
    message: json["message"],
    assignedDate: DateTime.parse(json["assigned_date"]),
    completedDate: json["completed_date"],
    deadlineDate: DateTime.parse(json["deadline_date"]),
    taskStatus: json["taskStatus"],
    isApproved: json["is_approved"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    clientName: json["clientName"],
    clientEmail: json["clientEmail"],
    clientMobile: json["clientMobile"],
    taskCategory: json["taskCategory"],
    taskpath: json["Taskpath"],
    taskImagemode: json["taskImagemode"],
    taskImage: json["taskImage"],
    taskAttachments: json["taskAttachments"],
  );

  Map<String, dynamic> toJson() => {
    "taskId": taskId,
    "task_name": taskName,
    "company_id": companyId,
    "client_id": clientId,
    "category_id": categoryId,
    "employee_id": employeeId,
    "address_id": addressId,
    "task_mode": taskMode,
    "task_mode_name": taskModeName,
    "CountryName": countryName,
    "StateName": stateName,
    "CityName": cityName,
    "address": address,
    "message": message,
    "assigned_date": assignedDate.toIso8601String(),
    "completed_date": completedDate,
    "deadline_date": deadlineDate.toIso8601String(),
    "taskStatus": taskStatus,
    "is_approved": isApproved,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "clientName": clientName,
    "clientEmail": clientEmail,
    "clientMobile": clientMobile,
    "taskCategory": taskCategory,
    "Taskpath": taskpath,
    "taskImagemode": taskImagemode,
    "taskImage": taskImage,
    "taskAttachments": taskAttachments,
  };
}
