import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:homecare/constants.dart';
import 'package:flutter/cupertino.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingFour(
            color: Colors.orange,
            size: 70.0,
          ),
          SizedBox(height: 10,),
          Center(
            child: Text(All_Lan().pleasewait,style: TextStyle(fontSize: 20.0,
              fontWeight: FontWeight.w700,),),
          )
        ],

      ),
    );
  }
}