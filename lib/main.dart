import 'package:flutter/material.dart';
import 'package:homecare/Screens/WelcomePages/WelcomeScreen.dart';
import 'package:homecare/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HomeCare",
      theme: ThemeData(
        fontFamily: 'Raleway',
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,

      ),
      /*textTheme: TextTheme(
        headline1: TextStyle(fontSize: 22.0, color: Colors.redAccent),
        headline2: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: Colors.redAccent,
        ),
        bodyText1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Colors.blueAccent,
        ),
      ),*/
      home: WelcomeScreen(),
    );
  }
}
