import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/Login/Login.dart';
import 'package:homecare/Screens/Login/components/background.dart';
import 'package:homecare/components/rounded_button.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';
import 'package:homecare/loading.dart';
import 'package:http/http.dart' as http;
class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  FocusNode focusNode = new FocusNode();
  bool progress =false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static TextEditingController EmailidControlleruser = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: progress == true
            ? Loading()
            :SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Forget Password",
                  // style: TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
                  style: TextStyle(fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,),
                  // style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.25,
                ),
                SizedBox(height: size.height * 0.03),
                TextFieldContainer(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: EmailidControlleruser,
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
                RoundedButton(
                    text: "Reset Password",
                    press: () {
                      if (formkey.currentState.validate()) {
                        var emailforget = EmailidControlleruser.text;
                        /*final snackbar =SnackBar(content: Text('Success',
                        style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);*/

                        /*FocusScope.of(context).requestFocus(focusNode);
                      final snackBar = SnackBar(content: Text('Success Full Login',
                        style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.orange,);


                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
                        print("emailforget --> " + emailforget);
                        SendResetEmail(emailforget);
                      }
                    }),
                SizedBox(height: size.height * 0.03),


              ],
            ),
          ),
        ),
      ),
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

  void SendResetEmail(String emailforget) async {
    setState(() {
      progress = true;
      // pr.show();
    });
    String keyusername = All_API().keyuser;
    String keypassword = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$keyusername:$keypassword'));
    print("reg_basicAuth--> " + basicAuth);

    var forgetPassurl = All_API().baseurl + All_API().api_password_forgot;
    print("forgetPass_url -->" + forgetPassurl);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(forgetPassurl));
    request.fields.addAll({
      'email': emailforget,

    });

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("forgetPass_response -->" + response.body);
    /*Map<String, dynamic> map = json.decode(response.body);
    var msg = map["message"];
    print("REG_MSG--> "+msg);*/
    try {
      if (response.statusCode == 200) {
        setState(() {
          // pr.hide();
          progress = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ),
          );
        });
        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(
          content: Text(
            "Now You Can Login"
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

        });
        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(
          content: Text(
           "Email not register..",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      return e;
    }
  }
}
