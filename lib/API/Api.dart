// ignore: camel_case_types
import 'dart:io';

class All_API {
  @override
  noSuchMethod(Invocation invocation) async{
    // TODO: implement noSuchMethod
    return super.noSuchMethod(invocation);
  }

  final no_data_found="No Data Found! ";
  final key = 'x-api-key';
  final keyvalue = 'AYT@123';
  final keyuser = 'admin';
  final keypassvalue = '1234';

  final FcmId ="NODN2D0I7W4V8I2K";

  final slider_img_path ="uploads/slider/";
  final employee_expense_img_path ="/uploads/employee_expense/";
  final news_img_path ="/uploads/news/";
  final profile_img_path ="/uploads/employee/";

  String baseurl="https://technolite.in/staging/easyhomecare/api/";
  String baseurl_img="http://adiyogitechnosoft.com/demo_attendance/";

  String api_login= "login_employee";
  String api_register= "employee_registration";
  String api_password_forgot= "password_forgot";
  String api_scan_qrcode= "scan_qrcode";
  String api_employee_update= "employee_update";
  String api_employee_get= "employee_get";
  String api_all_task_list= "all_task_list";
  String api_completed_task= "completed_task";
  String api_Employee_clients= "Employee_clients";
  String api_reset_password= "reset_password";
  String api_verify_reset_mail= "verify_reset_mail";


}