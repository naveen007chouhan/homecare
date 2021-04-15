import 'package:flutter/material.dart';
import 'package:homecare/Screens/HomePages/home.dart';
import 'package:homecare/constants.dart';

class BottomBar extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<BottomBar> {
  int _selectedItemIndex = 0;
  final List pages = [
    HomePage(),
    null,
    null,
    null,
    null,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [

          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.card_giftcard, 1),
          buildNavBarItem(Icons.camera, 2),
          buildNavBarItem(Icons.pie_chart, 3),
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

        decoration: index == _selectedItemIndex
            ? BoxDecoration(

            border:
            Border(bottom: BorderSide(width: 4, color: kSecondaryLightColor)),
            gradient: LinearGradient(colors: [
              kSecondaryLightColor.withOpacity(0.3),
              kSecondaryLightColor.withOpacity(0.016),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? kSecondaryLightColor : Colors.grey,
        ),
      ),
    );
  }




}
