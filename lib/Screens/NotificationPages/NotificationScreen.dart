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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // brightness: Brightness.dark,
        backgroundColor: kSecondaryLightColor,
        elevation: 8,
        /*leading: IconButton(
        icon: Icon(Icons.menu),
        color: Colors.white,
        onPressed: () {},
      ),*/
        title: Text(
          'Notification',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notification_important_outlined),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
      ),
      body: ListView(
        children: [

          Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                // color: Color.fromRGBO(64, 75, 96, .9),
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
              child:Column(
                children: [
                  ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(width: 1.0, color: Colors.white24))),
                        child: Image.network("https://images.pexels.com/photos/2167673/pexels-photo-2167673.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"),
                      ),
                      title: Text(
                        "Plumbing Task",
                        style: TextStyle(color: kSecondaryLightColor, fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                      subtitle: Row(
                        children: <Widget>[
                          Text(" You Successfully completed your task", style: TextStyle(color: Colors.grey[400]),maxLines: 2,)
                        ],
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Date: 2021-05-5',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Time : 12:15 PM',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
