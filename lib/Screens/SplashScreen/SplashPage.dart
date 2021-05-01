import 'package:flutter/material.dart';
import 'package:homecare/Screens/BottomNavigation/bottombar.dart';
import 'package:homecare/Screens/SplashScreen/Components/body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Body()
    );
  }
}
