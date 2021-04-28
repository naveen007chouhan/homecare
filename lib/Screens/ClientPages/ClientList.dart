import 'package:flutter/material.dart';
import 'package:homecare/constants.dart';

class ClientScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("On Developing Mode",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color:kSecondaryLightColor ),),
      ),
    );
  }
}
