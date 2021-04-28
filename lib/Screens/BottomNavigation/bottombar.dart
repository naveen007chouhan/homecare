import 'package:flutter/material.dart';
import 'package:homecare/Screens/ClientPages/ClientList.dart';
import 'package:homecare/Screens/HistoryTask/HistoryTaskList.dart';
import 'package:homecare/Screens/HomePages/home.dart';
import 'package:homecare/Screens/NotificationPages/NotificationScreen.dart';
import 'package:homecare/Screens/ProfilePages/ProfileScreen.dart';
import 'package:homecare/constants.dart';

class BottomBar extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<BottomBar> {
  int _selectedItemIndex = 0;
  final List pages = [
    HomePage(),
    TaskListHistory(),
    ClientScreen(),
    NotificationScreens(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [

          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.history_edu_outlined, 1),
          buildNavBarItem(Icons.camera, 2),
          buildNavBarItem(Icons.notification_important, 3),
          buildNavBarItem(Icons.person, 4),
        ],
      ),
      body: pages[_selectedItemIndex],
    );
  }

  GestureDetector buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 60,
// color: Colors.red,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(

            border:
            Border(bottom: BorderSide(width: 4, color: kSecondaryLightColor)),
            // color: kPrimaryColor,
            gradient: LinearGradient(colors: [
              kSecondaryLightColor.withOpacity(0.3),
              kSecondaryLightColor.withOpacity(0.016),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : BoxDecoration(
            // color: kPrimaryColor
        ),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? kSecondaryLightColor : Colors.grey,
        ),
      ),
    );
  }




}
