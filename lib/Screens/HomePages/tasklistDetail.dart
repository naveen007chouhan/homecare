import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homecare/constants.dart';

class TaskDetail extends StatefulWidget {
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  bool _status = false;
  String result = "Hey there !";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //------------------------
          // topContent
          //------------------------
          Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 10.0),
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new NetworkImage(
                          "https://images.pexels.com/photos/2167673/pexels-photo-2167673.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"),
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.all(40.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(58, 66, 86, .9),
                  gradient: LinearGradient(
                      colors: [kSecondaryLightColor, kSecondaryColor]),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 90.0),
                      Icon(
                        Icons.home_repair_service_sharp,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      Container(
                        width: 90.0,
                        child: new Divider(color: kPrimaryColor),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        /*lesson.*/ "Type",
                        style: TextStyle(color: Colors.white, fontSize: 45.0),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  /*lesson.*/ "Alot Date",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(7.0),
                                decoration: new BoxDecoration(
                                    border: new Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: new Text(
                                  "\$20",
                                  /*"\$" + lesson.price.toString()*/
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /*Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )*/
            ],
          ),

          //------------------------
          // bottomContent
          //------------------------
          Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    /*lesson.*/ "content",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  !_status
                      ? Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 45.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Container(
                                  child: new RaisedButton(
                                    child: new Text("Accept"),
                                    textColor: Colors.white,
                                    color: kSecondaryLightColor,
                                    onPressed: () {
                                      setState(() {
                                        _status = true;
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      });
                                    },
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(20.0)),
                                  )),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Container(
                                  child: new RaisedButton(
                                    child: new Text("Decline"),
                                    textColor: kSecondaryLightColor,
                                    color: kPrimaryColor,
                                    onPressed: () {
                                      setState(() {
                                        // _status = true;
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      });
                                    },
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(20.0)),
                                  )),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: 90.0),
                      GestureDetector(
                        child: Container(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 45.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 45.0,
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: RaisedButton.icon(
                                      color: kSecondaryLightColor,
                                      label: Text(
                                        'Scan QR',
                                        style: TextStyle(fontSize: 13.0),
                                      ),
                                      icon: Icon(
                                        Icons.code,
                                        size: 13.0,
                                      ),
                                      onPressed: () {
                                        _scanQR();
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(
                                              20.0)),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        /* child: new CircleAvatar(
                                backgroundColor: kSecondaryLightColor,
                                radius: 14.0,
                                child: new Icon(
                                  Icons.code,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),*/

                        onTap: () {
                          setState(() {
                            // _status = false;
                          });
                        },
                      ),
                      SizedBox(height: 90.0),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        print(result);
        // chech_in_out();
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
          print(result);
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
          print(result);
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
        print(result);
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
        print(result);
      });
    }
  }

  /*Widget _getQrCode() {
    return new
  }*/
}
