import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homecare/Screens/Login/Login.dart';
import 'package:homecare/Screens/SignUp/components/background.dart';
import 'package:homecare/components/already_have_an_account_acheck.dart';
import 'package:homecare/components/rounded_button.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static final formkey = GlobalKey<FormState>();
  static TextEditingController compCodeController = TextEditingController();
  static TextEditingController fnameController = TextEditingController();
  static TextEditingController lnameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController phnController = TextEditingController();
  static TextEditingController passController = TextEditingController();

  String dayLeave=null;
  var dayLeaveID;
  List DayTypeList=[{'id':'0','name':'select type'},{'id':'1','name':'Employee'},{'id':'2','name':'User'}];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
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
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            TextFieldContainer(
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
            ),
            TextFieldContainer(
              child: TextFormField(
                maxLength: 6,
                textCapitalization: TextCapitalization.characters,
                controller: compCodeController,
                // keyboardType:TextInputType.number ,
                validator: ((value) {
                  if (value.isEmpty) {
                    return "Field Required!!";
                  }
                  return null;
                }),
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.code,
                    color: kPrimaryColor,
                  ),
                  hintText: "Company Code",
                  border: InputBorder.none,
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                controller: fnameController,
                validator: ((value) {
                  if (value.isEmpty) {
                    return "Field Required!!";
                  }
                  return null;
                }),
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  hintText: "First Name",
                  border: InputBorder.none,
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                controller: lnameController,
                validator: ((value) {
                  if (value.isEmpty) {
                    return "Field Required!!";
                  }
                  return null;
                }),
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  hintText: "Last Name",
                  border: InputBorder.none,
                ),
              ),
            ),
            TextFieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: validateEmail,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email_rounded,
                    color: kPrimaryColor,
                  ),
                  hintText: "Email Id",
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
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: kPrimaryColor,
                  ),
                  hintText: "Phone No",
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
                obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
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
                  SendRegisterData(compcode,fname,lname,email,phn,pass);
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

  void SendRegisterData(String compcode, String fname, String lname, String email, String phn, String pass) {

  }
}
