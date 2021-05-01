import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/WelcomePages/WelcomeScreen.dart';
import 'package:homecare/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  String employeeId;
  String employeeMobileNo;
  String emailid;
  String firstname;
  String lastname;
  String employeename;
  String state;
  String country;
  String city;
  String address;
  String postalcode;

  TextEditingController _textEditingControllerFName ;
  TextEditingController _textEditingControllerLName;
  TextEditingController _textEditingControllerEmailId;
  TextEditingController _textEditingControllerPhoneNo ;
  TextEditingController _textEditingControllerCountry ;
  TextEditingController _textEditingControllerState ;
  TextEditingController _textEditingControllerCity ;
  TextEditingController _textEditingControllerAddress ;
  TextEditingController _textEditingControllerPostalCode ;

  bool progress = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      employeeId = sharedPreferences.getString("employeeId");
      employeeMobileNo = sharedPreferences.getString("employeeMobileNo");
      emailid = sharedPreferences.getString("employeeEmail");
      firstname = sharedPreferences.getString("firstname");
      lastname = sharedPreferences.getString("lastname");
      country = sharedPreferences.getString("country");
      state = sharedPreferences.getString("state");
      city = sharedPreferences.getString("city");
      address = sharedPreferences.getString("address");
      postalcode = sharedPreferences.getString("zip");
      employeename = firstname + " " + lastname;
      print("employeename -> " + employeename);
      _textEditingControllerFName =  TextEditingController(text: firstname);
      _textEditingControllerLName =  TextEditingController(text: lastname);
      _textEditingControllerEmailId =  TextEditingController(text: emailid);
      _textEditingControllerPhoneNo =  TextEditingController(text: employeeMobileNo);
      _textEditingControllerCountry =  TextEditingController(text: country);
      _textEditingControllerState =  TextEditingController(text: state);
      _textEditingControllerCity =  TextEditingController(text: city);
      _textEditingControllerPostalCode =  TextEditingController(text: postalcode);
      _textEditingControllerAddress =  TextEditingController(text: address);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            'PROFILE',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[

            IconButton(
              icon: Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                showAlertDialog(context);
              },
            ),
          ],
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new NetworkImage(
                                            "https://images.pexels.com/photos/2167673/pexels-photo-2167673.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      backgroundColor: kSecondaryLightColor,
                                      radius: 25.0,
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Parsonal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                    ],
                                  )
                                ],
                              )),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: new TextField(
                                        controller: _textEditingControllerFName,
                                        decoration: const InputDecoration(
                                            hintText: "Naveen"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new TextField(
                                        controller: _textEditingControllerLName,
                                        decoration: const InputDecoration(
                                            hintText: "Chouhan"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new TextField(
                                        controller: _textEditingControllerEmailId,
                                        decoration: const InputDecoration(

                                            hintText: "naveen@gmail.com"),
                                        enabled: !_status,
                                      ),
                                    ),
                                  ),
                                ],
                              )),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new TextField(
                                        controller: _textEditingControllerPhoneNo,
                                        decoration: const InputDecoration(
                                            hintText: "7891234569"),
                                        enabled: !_status,
                                      ),
                                    ),
                                  ),
                                ],
                              )),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new TextField(
                                          controller: _textEditingControllerCountry,
                                          decoration: const InputDecoration(
                                              hintText: "India"),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new TextField(
                                        controller: _textEditingControllerState,
                                        decoration: const InputDecoration(
                                            hintText: "Rajasthan"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new TextField(
                                        controller: _textEditingControllerCity,
                                        decoration: const InputDecoration(
                                            hintText: "Jodhpur"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new TextField(
                                        controller: _textEditingControllerPostalCode,
                                        decoration: const InputDecoration(
                                            hintText: "305001"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: kSecondaryLightColor,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () async{
        if (employeeId.toString().isNotEmpty) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setBool("loggedIn", false);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen()),
            ModalRoute.withName('/'),
          );
          /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(),
            ),
          );*/
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are You Shure, You Want To Logout..",style: TextStyle(fontSize: 12),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: kSecondaryLightColor,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: kSecondaryLightColor,
                    color: kPrimaryColor,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  void UpdateEmployeeProfile() async{
    var employee_update_url = All_API().baseurl + All_API().api_employee_update;
    print("employee_update_url -->" + employee_update_url);
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("employee_update_basicAuth--> " + basicAuth);
    var headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(employee_update_url));
    request.fields.addAll({
      'employee_id': '8',
      'firstname': 'TestNaveen',
      'lastname': 'Chouhan',
      'mobile_no': '1234567812',
      'company_code': '',
      'password': '',
      'email_id': 'testchouhan@gmail.com',
      'country': 'india',
      'state': 'rajasthan',
      'city': 'ajmer',
      'zip': '305001',
      'address': 'New Chandar Nagar'
    });
    // request.files.add(await http.MultipartFile.fromPath('file', ));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
