import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:homecare/Screens/SplashScreen/SplashPage.dart';
import 'package:homecare/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
  }

  void getMessage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken().then((token) => print(token));
    _firebaseMessaging.getToken().then((token) {
      String fcmID = token.toString();
      sharedPreferences.setString('fcmID', fcmID);
      print("getMessage_fcmID--> " + fcmID);
      // do whatever you want with the token here
    });
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      if(Platform.isIOS){
        message = message;
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              backgroundColor: Colors.white,
              title: Container(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Text(
                        message["notification"]["title"],
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                            color: kPrimaryColor,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Close",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )),
                      ),
                    ],
                  ),
                ),
              ));
        },
      );
      setState(() => _message = message["notification"]["title"]);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      if(Platform.isIOS){
        message = message;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              backgroundColor: Colors.white,
              title: Container(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Text(
                        message["notification"]["title"],
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                            color: kPrimaryColor,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Close",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )),
                      ),
                    ],
                  ),
                ),
              ));
        },
      );
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      if(Platform.isIOS){
        message = message;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
              backgroundColor: Colors.white,
              title: Container(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Text(
                        message["notification"]["title"],
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                            color: kPrimaryColor,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Close",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )),
                      ),
                    ],
                  ),
                ),
              ));
        },
      );
      setState(() => _message = message["notification"]["title"]);
    });
  }

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
      home: Splash(),
    );
  }
}
