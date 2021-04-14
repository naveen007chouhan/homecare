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
        fontFamily: 'RockfordSans-Light.otf',
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}








