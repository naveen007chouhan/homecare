import 'package:flutter/material.dart';
import 'package:homecare/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(29),
      ),
      elevation: 8,
        shadowColor: Colors.white70,
      child:Container(
        // margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          /*color: Color.fromRGBO(58, 66, 86, .9),
          gradient: LinearGradient(
              colors: [kSecondaryLightColor.withOpacity(0.4), kSecondaryColor.withOpacity(0.9)]),*/
          borderRadius: BorderRadius.circular(29),
        ),
        child: child,
      ),

    );
  }
}
