import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homecare/Screens/BottomNavigation/bottombar.dart';
import 'package:homecare/Screens/Login/Login.dart';
import 'package:homecare/Screens/SignUp/SignUpScreen.dart';
import 'package:homecare/Screens/WelcomePages/Components/background.dart';
import 'package:homecare/Screens/WelcomePages/WelcomeScreen.dart';
import 'package:homecare/components/rounded_button.dart';
import 'package:homecare/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool logIN;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefance();
  }
  getPrefance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      logIN = sharedPreferences.getBool('loggedIn');
      Timer(Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
              logIN==true?BottomBar() :LoginScreen()
              )
          )
      );
    });
  }
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

          ],
        ),
      ),
    );
  }
}
