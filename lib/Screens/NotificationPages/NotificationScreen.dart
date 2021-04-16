import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/NotificationPages/Model/NotificationModel.dart';
import 'package:homecare/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationScreens extends StatefulWidget {
  @override
  _NotificationScreensState createState() => _NotificationScreensState();
}

class _NotificationScreensState extends State<NotificationScreens> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  border: Border.all(
                    color: kSecondaryLightColor, // red as border color
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)
                      // topRight: Radius.circular(10.0),
                      // bottomRight: Radius.circular(10.0),
                      // topLeft: Radius.circular(10.0),
                      // bottomLeft: Radius.circular(10.0),
                      ),
                ),

                // margin:const EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 5),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),

                  title: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "title",
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                  subtitle: Column(
                    children: <Widget>[
                      Text(
                        "message",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: Colors.black45),
                        softWrap: true,
                      ),
                      SizedBox(
                        height: 20,
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date : ",
                            textDirection: TextDirection.ltr,
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                            softWrap: true,
                          ),
                          Text(
                            "Time : ",
                            textDirection: TextDirection.ltr,
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // trailing:
                  //  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white, size: 30.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
