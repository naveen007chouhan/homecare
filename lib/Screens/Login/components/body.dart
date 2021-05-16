import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/BottomNavigation/bottombar.dart';
import 'package:homecare/Screens/ForgetPassPage/ForgetScreen.dart';
import 'package:homecare/Screens/Login/components/background.dart';
import 'package:homecare/Screens/SignUp/SignUpScreen.dart';
import 'package:homecare/components/already_have_an_account_acheck.dart';
import 'package:homecare/components/rounded_button.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';
import 'package:homecare/loading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Body> {
  bool hidepassword = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  FocusNode focusNode = new FocusNode();
  bool progress = false;
  String fcmID;
  String userdeviceId;
  static TextEditingController phnControlleruser = TextEditingController();
  static TextEditingController passControlleruser = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDevice();
    getData();
  }

  getDevice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdeviceId = await _getId();
    print("User_Device_Id -->" + userdeviceId);
    setState(() {
      sharedPreferences.setString("userdevice", userdeviceId);
    });
  }

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fcmID = sharedPreferences.getString("fcmID");
      print("User_fcmID -->" + fcmID);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: progress == true
          ? Loading()
          : SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      All_Lan().login,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                      ),
                      ),
                    SizedBox(height: size.height * 0.03),
                    Image.asset(
                      "assets/images/easyyhomecarelogo.png",
                      height: size.height * 0.25,
                    ),

                    SizedBox(height: size.height * 0.03),
                    TextFieldContainer(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phnControlleruser,
                        maxLength: 10,
                        validator: ((value) {
                          if (value.isEmpty) {
                            return "Field Required!!";
                          }
                          return null;
                        }),
                        cursorColor: kSecondaryLightColor,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(
                            height: double.minPositive,
                          ),
                          counterText: "",
                          icon: Icon(
                            Icons.phone,
                            color: kSecondaryLightColor,
                          ),
                          labelText: All_Lan().phoneno,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: passControlleruser,
                        validator: ((value) {
                          if (value.isEmpty) {
                            return "Field Required!!";
                          }

                          return null;
                        }),
                        obscureText: hidepassword,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          labelText: All_Lan().password,
                          icon: Icon(
                            Icons.lock,
                            color: kSecondaryLightColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidepassword = !hidepassword;
                              });
                            },
                            icon: Icon(hidepassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: kSecondaryLightColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    RoundedButton(
                        text: All_Lan().login,
                        press: () async {
                          if (formkey.currentState.validate()) {
                            var phn = phnControlleruser.text;
                            var pass = passControlleruser.text;
                            FocusScope.of(context).requestFocus(focusNode);

                            print("phn --> " + phn);
                            print("pass --> " + pass);
                            print("userdeviceId --> " + userdeviceId);
                            // print("fcm_Id --> " + fcmID);
                            SendLoginData(phn, pass, userdeviceId, fcmID);
                          }
                        }),
                    SizedBox(height: size.height * 0.03),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgetPassword();
                              },
                            ),
                          );
                        },
                        child: Text(All_Lan().forget_password+"?",
                            style: TextStyle(color: kSecondaryLightColor))),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  void SendLoginData(
      String phn, String pass, String Deviceiduser, String fcmemid) async {
    setState(() {
      progress = true;
      // pr.show();
      fcmID="1234";
    });
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("log_basicAuth--> " + basicAuth);

    var logurl = All_API().baseurl + All_API().api_login;
    print("login_url -->" + logurl);
    print("login_Deviceiduser -->" + Deviceiduser);
    print("login_fcmID -->" + fcmemid);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(logurl));
    request.fields.addAll({
      'password': pass,
      'mobile_no': phn,
      'fcm_id': fcmemid,
      'device_id': Deviceiduser,
    });

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("log_body_response -->" + response.body.toString());

    var jasonData = jsonDecode(response.body);

    var msg = jasonData['message'];
    // String msg=jasonData['message'];

    print("log_statuscode_response -->" + msg);

    try {
      if (response.statusCode == 200) {
        var employeeId = jasonData['data']['id'];
        print("MSG=2--> " + employeeId);
        var employeeSlug = jasonData['data']['slug'];
        var companyId = jasonData['data']['company_id'];
        var firstname = jasonData['data']['first_name'];
        var lastname = jasonData['data']['last_name'];
        var employeeEmail = jasonData['data']['email'];
        var employeeMobileNo = jasonData['data']['mobile_no'];
        var employeepassword = jasonData['data']['password'];
        var employeeprofileImg = jasonData['data']['profile_img'];
        var employeeprofilepath = jasonData['data']['path'];
        var verifyToken = jasonData['data']['verifi_token'];
        var tokenExpire = jasonData['data']['token_expire'];
        var verificationRetries = jasonData['data']['verification_retries'];
        var address = jasonData['data']['address'];
        var country = jasonData['data']['country'];
        var state = jasonData['data']['state'];
        var city = jasonData['data']['city'];
        var zip = jasonData['data']['zip'];
        var createdAt = jasonData['data']['created_at'];
        var employeeStatus = jasonData['data']['status'];
        var deleted = jasonData['data']['deleted'];
        var deletedAt = jasonData['data']['deleted_at'];
        var updatedAt = jasonData['data']['updated_at'];

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("employeeId", employeeId);
        sharedPreferences.setString("employeeSlug", employeeSlug);
        sharedPreferences.setString("companyId", companyId);
        sharedPreferences.setString("firstname", firstname);
        sharedPreferences.setString("lastname", lastname);
        sharedPreferences.setString("employeeEmail", employeeEmail);
        sharedPreferences.setString("employeeMobileNo", employeeMobileNo);
        sharedPreferences.setString("employeepassword", employeepassword);
        sharedPreferences.setString("employeeprofileImg", employeeprofileImg);
        sharedPreferences.setString("employeeprofilepath", employeeprofilepath);
        sharedPreferences.setString("verifyToken", verifyToken);
        sharedPreferences.setString("tokenExpire", tokenExpire);
        sharedPreferences.setString("verificationRetries", verificationRetries);
        sharedPreferences.setString("address", address);
        sharedPreferences.setString("country", country);
        sharedPreferences.setString("state", state);
        sharedPreferences.setString("city", city);
        sharedPreferences.setString("zip", zip);
        sharedPreferences.setString("createdAt", createdAt);
        sharedPreferences.setString("employeeStatus", employeeStatus);
        sharedPreferences.setString("deleted", deleted);
        sharedPreferences.setString("deletedAt", deletedAt);
        sharedPreferences.setString("updatedAt", updatedAt);
        if (employeeId.toString().isNotEmpty) {
          sharedPreferences.setBool("loggedIn", true);
          progress = false;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => BottomBar()),
            ModalRoute.withName('/'),
          );
        }

        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(
          content: Text(
            All_Lan().You_are_Successfully_Login,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      } else {
        setState(() {
          progress = false;

          FocusScope.of(context).requestFocus(focusNode);
          final snackBar = SnackBar(
            content: Text(
              All_Lan().invalid_mobile_number_and_password,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } catch (e) {
      return e;
    }
  }
}
