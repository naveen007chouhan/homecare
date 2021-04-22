import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/BottomNavigation/bottombar.dart';
import 'package:homecare/Screens/Login/components/background.dart';
import 'package:homecare/Screens/SignUp/SignUpScreen.dart';
import 'package:homecare/components/already_have_an_account_acheck.dart';
import 'package:homecare/components/rounded_button.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';
import 'package:homecare/loading.dart';
import 'package:http/http.dart' as http;
class Body extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Body> {
  bool hidepassword = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  FocusNode focusNode = new FocusNode();
  bool progress =false;
  static TextEditingController phnControlleruser = TextEditingController();
  static TextEditingController passControlleruser = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: progress == true
          ? Loading()
          :SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
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
                    counterStyle: TextStyle(height: double.minPositive,),
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
                    labelText: "Password",
                    icon: Icon(
                      Icons.lock,
                      color: kSecondaryLightColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          hidepassword=!hidepassword;
                        });
                      },
                      icon:Icon(hidepassword?Icons.visibility_off:Icons.visibility),
                      color: kSecondaryLightColor,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              RoundedButton(
                  text: "LOGIN",
                  press: () {
                    if (formkey.currentState.validate()) {
                      var phn = phnControlleruser.text;
                      var pass = passControlleruser.text;
                      FocusScope.of(context).requestFocus(focusNode);
                      /*final snackbar =SnackBar(content: Text('Success',
                        style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);*/

                      /*FocusScope.of(context).requestFocus(focusNode);
                      final snackBar = SnackBar(content: Text('Success Full Login',
                        style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.orange,);


                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
                      print("phn --> " + phn);
                      print("pass --> " + pass);
                      SendLoginData(phn, pass);
                    }
                  }),
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

  void SendLoginData(String phn, String pass)async {
    setState(() {
      progress=true;
      // pr.show();

    });
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("log_basicAuth--> "+basicAuth);

    var logurl= All_API().baseurl+All_API().api_login;
    print("login_url -->" +logurl);

    /*var body=jsonEncode({"firstname":fname,"lastname":lname,"email_id":email,"password":pass,"mobile_no":phn,"company_code":compcode});*/

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(logurl));
    request.fields.addAll({
      'password': pass,
      'mobile_no': phn,
    });

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("log_body_response -->" +response.body);

    var  jasonData = jsonDecode(response.body);
    // print("log_statuscode_response -->" +jasonData.statusCode);


    // final Map<String, String> jasonData = jsonDecode(response.body);
    // String msg=jasonData['error'];
    // print("MSG--> "+ msg );
    try{

      if(response.statusCode==200){
        var  jasonData = jsonDecode(response.body);

        setState(() {
          // pr.hide();
          progress=false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BottomBar();
              },
            ),
          );
        });
        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(content: Text('Your Are Successfuly Login ',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      }else{
        setState(() {
          // pr.hide();
          progress=false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BottomBar();
              },
            ),
          );
          FocusScope.of(context).requestFocus(focusNode);
          final snackBar = SnackBar(content: Text(/*msg*/"Invalid mobile no or password ",style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }

    }catch(e){
      return e;
    }

  }
}
