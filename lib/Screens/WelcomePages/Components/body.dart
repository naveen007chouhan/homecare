import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homecare/Screens/Login/Login.dart';
import 'package:homecare/Screens/SignUp/SignUpScreen.dart';
import 'package:homecare/Screens/WelcomePages/Components/background.dart';
import 'package:homecare/components/rounded_button.dart';
import 'package:homecare/constants.dart';

import 'package:flutter/cupertino.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/easyyhomecarelogo.png",height: 200,width: 200,),
            Text(
              "WELCOME TO HOME CARE",
              style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 25),
            ),
            SizedBox(height: size.height * 0.05),
            /*SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),*/
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
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
            RoundedButton(
              text: "SIGN UP",
              color: kSecondaryLightColor,
              textColor: Colors.white,
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
    );
  }
}
