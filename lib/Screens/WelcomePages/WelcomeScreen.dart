import 'package:flutter/material.dart';
import 'package:homecare/Screens/BottomNavigation/bottombar.dart';
import 'package:homecare/Screens/WelcomePages/Components/body.dart';
import 'package:shared_preferences/shared_preferences.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool logIN;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefance();
  }
  getPrefance()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      logIN=sharedPreferences.getBool('loggedIn');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: logIN==true?BottomBar():Body(),
    );
  }
}
