// ignore: camel_case_types
import 'dart:io';

class All_API {
  @override
  noSuchMethod(Invocation invocation) async{
    // TODO: implement noSuchMethod
    return super.noSuchMethod(invocation);
  }

  final no_task_found="No Task Found..!!";
  final no_result_found="No Result Found..!!";
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
  String baseurl_img="https://technolite.in/staging/easyhomecare/";
  String baseurl_img_error="https://technolite.in/staging/easyhomecare//0";
  String baseurl_img_default="https://images.pexels.com/photos/2167673/pexels-photo-2167673.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260";

  String api_login= "login_employee";
  String api_register= "employee_registration";
  String api_password_forgot= "password_forgot";
  String api_scan_qrcode= "scan_qrcode";
  String api_get_profile= "employee";
  String api_employee_update= "employee_update";
  String api_employee_get= "employee_get";
  String api_dashboard= "dashboad";
  String api_taskdetail= "taskDetails";
  String api_savedoc= "Savedoc";
  String api_emp_Lastfivetask = "emp_Lastfivetask";
  String api_all_task_list= "all_task_list";
  String api_completed_task= "completed_task";
  String api_Employee_clients= "Employee_clients";
  String api_get_Notification= "getNotification";
  String api_reset_password= "reset_password";
  String api_verify_reset_mail= "verify_reset_mail";
  String api_employeeBycompany= "employeeBycompany";
  String api_FetchChatData= "Chetdata";
  String api_SendChatData= "saveMessgae";


}