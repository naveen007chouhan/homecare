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
  final FcmId ="NODN2D0I7W4V8I2K";

  final slider_img_path ="uploads/slider/";
  final employee_expense_img_path ="/uploads/employee_expense/";
  final news_img_path ="/uploads/news/";
  final profile_img_path ="/uploads/employee/";

  String baseurl="https://technolite.in/staging/easyhomecare/api/";
  String baseurl_img="http://adiyogitechnosoft.com/demo_attendance";

  String api_login= "employee/employee_login";
  String api_register= "employee_registration";
  String api_scan_qrcode= "scan_qrcode";


}