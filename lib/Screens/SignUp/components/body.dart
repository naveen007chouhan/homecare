import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:homecare/loading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/Login/Login.dart';
import 'package:homecare/Screens/SignUp/components/background.dart';
import 'package:homecare/components/already_have_an_account_acheck.dart';
import 'package:homecare/components/rounded_button.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool hidepassword = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  FocusNode focusNode = new FocusNode();
  bool progress = false;
  String userdeviceId;
  static TextEditingController compCodeController = TextEditingController();
  static TextEditingController fnameController = TextEditingController();
  static TextEditingController lnameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController phnController = TextEditingController();
  static TextEditingController passController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    getDevice();
    super.initState();
  }

  getDevice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userdeviceId = await _getId();
    setState(() {
      sharedPreferences.setString("userdevice", userdeviceId);
    });
  }
  /*String dayLeave=null;
  var dayLeaveID;
  List DayTypeList=[{'id':'0','name':'select type'},{'id':'1','name':'Employee'},{'id':'2','name':'User'}];*/

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
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.20,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    All_Lan().register,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  /*TextFieldContainer(
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Select Leave day",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                value: dayLeave,
                items: DayTypeList.map((explist) {
                  return DropdownMenuItem(
                    value: explist['name'],
                    child: Text(explist['name']),
                    onTap: (){
                      dayLeaveID = explist['id'];
                      print("leavess-->"+explist['id']);
                    },
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    dayLeave = value;
                    if(dayLeaveID==0){
                      dayLeave = null;
                    }
                  });
                },
              ),
            ),*/
                  TextFieldContainer(
                    child: TextFormField(
                      maxLength: 12,
                      // autovalidate: true,
                      textCapitalization: TextCapitalization.characters,
                      controller: compCodeController,
                      // keyboardType:TextInputType.number ,
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
                          Icons.code,
                          color: kSecondaryLightColor,
                        ),
                        labelText: All_Lan().companycode,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFieldContainer(
                          child: TextFormField(
                            controller: fnameController,
                            validator: ((value) {
                              if (value.isEmpty) {
                                return "Field Required!!";
                              }
                              return null;
                            }),
                            cursorColor: kSecondaryLightColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: kSecondaryLightColor,
                              ),
                              // hintText: "First Name",
                              border: InputBorder.none,
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(0),
                              // ),
                              labelText: "First Name",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFieldContainer(
                          child: TextFormField(
                            controller: lnameController,
                            validator: ((value) {
                              if (value.isEmpty) {
                                return "Field Required!!";
                              }
                              return null;
                            }),
                            cursorColor: kSecondaryLightColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: kSecondaryLightColor,
                              ),
                              labelText: "Last Name",
                              // labelText: "First Name",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFieldContainer(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: validateEmail,
                      cursorColor: kSecondaryLightColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email_rounded,
                          color: kSecondaryLightColor,
                        ),
                        labelText: "Email Id",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phnController,
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
                        labelText: "Phone No",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextFormField(
                      controller: passController,
                      validator: ((value) {
                        if (value.isEmpty) {
                          return "Field Required!!";
                        }
                        return null;
                      }),
                      obscureText: hidepassword,
                      cursorColor: kSecondaryLightColor,
                      decoration: InputDecoration(
                        labelText: "Password",
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
                    text: "SIGNUP",
                    press: () {
                      if (formkey.currentState.validate()) {
                        var compcode = compCodeController.text;
                        var fname = fnameController.text;
                        var lname = lnameController.text;
                        var email = emailController.text;
                        var phn = phnController.text;
                        var pass = passController.text;
                        print("compcode --> " + compcode);
                        print("First Name --> " + fname);
                        print("Last Name --> " + lname);
                        print("Email --> " + email);
                        print("phn --> " + phn);
                        print("pass --> " + pass);
                        SendRegisterData(
                            compcode, fname, lname, email, phn, pass);
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  /*OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )*/
                ],
              ),
            )),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address ';
    else
      return null;
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

  void SendRegisterData(String compcode, String fname, String lname,
      String email, String phn, String pass) async {
    setState(() {
      progress = true;
      // pr.show();
    });
    String keyusername = All_API().keyuser;
    String keypassword = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$keyusername:$keypassword'));
    print("reg_basicAuth--> " + basicAuth);

    var regurl = All_API().baseurl + All_API().api_register;
    print("reg_url -->" + regurl);

    /*var body=jsonEncode({"firstname":fname,"lastname":lname,"email_id":email,"password":pass,"mobile_no":phn,"company_code":compcode});*/

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(regurl));
    request.fields.addAll({
      'firstname': fname,
      'lastname': lname,
      'email_id': email,
      'password': pass,
      'mobile_no': phn,
      'company_code': compcode
    });

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("reg_body_response -->" + response.body);
    Map<String, dynamic> map = json.decode(response.body);
    var msg = map["message"];
    print("REG_MSG--> "+msg);
    /*Map jasonData = jsonDecode(response.body);
            String msg = jasonData['message'];
            print("MSG--> " + msg);*/
    // final Map<String, String> jasonData = jsonDecode(response.body);
    // String msg=jasonData['error'];
    // print("MSG--> "+ msg );
    try {
      if (response.statusCode == 200) {
        setState(() {
          // pr.hide();
          progress = false;
        });
        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(
          content: Text(
            msg
           /* 'Your Are Successfuly Register ,Now You Can Login'*/,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      } else {
        setState(() {
          // pr.hide();
          progress = false;
          if(msg=="Invalid Compnay Code Please try another code"){
            FocusScope.of(context).requestFocus(focusNode);
            final snackBar = SnackBar(
              content: Text(
                msg/*"Your Are Not Register ,Plzz "*/,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }else if( msg["mobile"] == "Mobile No is Alerday Exits"){
            FocusScope.of(context).requestFocus(focusNode);
            final snackBar = SnackBar(
              content: Text(
                msg["mobile"]/*"Your Are Not Register ,Plzz "*/,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }else if( msg["email"] == "Email id is Alerday Exits"){
            FocusScope.of(context).requestFocus(focusNode);
            final snackBar = SnackBar(
              content: Text(
                msg["email"]/*"Your Are Not Register ,Plzz "*/,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }



        });
      }
    } catch (e) {
      return e;
    }
  }
}
