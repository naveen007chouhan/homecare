import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/Login/Login.dart';
import 'package:homecare/Screens/ProfilePages/Model/GetProfileDataModel.dart';
import 'package:homecare/Screens/SignUp/SignUpScreen.dart';
import 'package:homecare/Screens/WelcomePages/WelcomeScreen.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';
import 'package:homecare/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _status = true;
  bool loading = false;
  FocusNode focusNode = new FocusNode();
  String employeeId;
  String companyId;

  String firstName;
  String lastName;
  String email;
  String address;
  String mobileNo;

  String getcountryid;
  String getstateid;
  String getcityid;

  String countryName;
  String stateName;
  String cityName;

  String zip;

  String profileImage = "";
  String profilePath;
  String profile;

  var imageString;

  TextEditingController _textEditingControllerFName;

  TextEditingController _textEditingControllerLName;
  TextEditingController _textEditingControllerEmailId;
  TextEditingController _textEditingControllerPhoneNo;

  TextEditingController _textEditingControllerCountry;

  TextEditingController _textEditingControllerState;

  TextEditingController _textEditingControllerCity;

  TextEditingController _textEditingControllerAddress;

  TextEditingController _textEditingControllerPostalCode;

  bool progress = true;
  File uploadProfileimage;
  var country;
  var countryID;

  List countryList = new List();
  var state, stateID;
  List stateList = new List();
  var city;
  var cityID;
  List cityList = new List();

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
      companyId = sharedPreferences.getString("companyId");
      GetEmployeeProfile();
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

          title: Text(
            All_Lan().profile,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout),
              color: Colors.white,
              onPressed: () {
                alertDialog(context);
              },
            ),
          ],
        ),
        body: loading==true?Loading():SingleChildScrollView(
          child: new Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                new Container(
                  height: 250.0,
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child:
                            new Stack(fit: StackFit.loose, children: <Widget>[
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
                                      image: uploadProfileimage == null
                                          ? NetworkImage(profileImage ==
                                                  All_API().baseurl_img_error
                                              ? All_API().baseurl_img_default
                                              : profileImage)
                                          : FileImage(uploadProfileimage),
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ],
                          ),
                          Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: _status == true ? false : true,
                            child: Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: new CircleAvatar(
                                        backgroundColor: kSecondaryLightColor,
                                        radius: 25.0,
                                        child: new Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        selectImage();
                                      },
                                    )
                                  ],
                                )),
                          ),
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
                                left: 25.0, right: 25.0, top: 5.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      All_Lan().personal_information,
                                      style: TextStyle(
                                          fontSize: 20.0,
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
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFieldContainer(
                                child: TextFormField(
                                  controller: _textEditingControllerFName,
                                  validator: ((value) {
                                    if (value.isEmpty) {
                                      return "Field Required!!";
                                    }
                                    return null;
                                  }),
                                  cursorColor: kSecondaryLightColor,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      color: kSecondaryLightColor,
                                    ),
                                    // hintText: "First Name",
                                    border: InputBorder.none,
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(0),
                                    // ),
                                    labelText:All_Lan().firstname,
                                    enabled: !_status,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFieldContainer(
                                child: TextFormField(
                                  controller: _textEditingControllerLName,
                                  validator: ((value) {
                                    if (value.isEmpty) {
                                      return "Field Required!!";
                                    }
                                    return null;
                                  }),
                                  cursorColor: kSecondaryLightColor,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      color: kSecondaryLightColor,
                                    ),
                                    labelText: All_Lan().lastname,
                                    // labelText: "First Name",
                                    border: InputBorder.none,
                                    enabled: !_status,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFieldContainer(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _textEditingControllerEmailId,
                            cursorColor: kSecondaryLightColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.email_rounded,
                                color: kSecondaryLightColor,
                              ),
                              labelText: All_Lan().emailid,
                              border: InputBorder.none,
                              enabled: !_status,
                            ),
                          ),
                        ),
                        TextFieldContainer(
                          child: TextFormField(
                            controller: _textEditingControllerAddress,
                            maxLines: 4,
                            validator: ((value) {
                              if (value.isEmpty) {
                                return "Field Required!!";
                              }
                              return null;
                            }),
                            cursorColor: kSecondaryLightColor,
                            decoration: InputDecoration(
                              counterStyle: TextStyle(
                                height: double.minPositive,
                              ),
                              counterText: "",
                              icon: Icon(
                                Icons.location_city,
                                color: kSecondaryLightColor,
                              ),
                              labelText: All_Lan().address,
                              border: InputBorder.none,
                              enabled: !_status,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFieldContainer(
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  hint: countryName != null
                                      ? Text(
                                          country == null
                                              ? countryName
                                              : country,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold))
                                      : Text(All_Lan().country),
                                  value: country,
                                  items: countryList.map((explist) {
                                    return DropdownMenuItem(
                                      value: explist['name'],
                                      child: Text(explist['name']),
                                      onTap: () {
                                        countryID = explist['id'];
                                        getState(countryID);
                                        print("countryID-->" + countryID);
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      country = value;
                                      print("countryID_OnChange-->" + country);
                                      if (countryID == 0) {
                                        country = null;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFieldContainer(
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  hint: stateName != null
                                      ? Text(state == null ? stateName : state,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold))
                                      : Text(All_Lan().state),
                                  value: state,
                                  items: stateList.map((explist) {
                                    return DropdownMenuItem(
                                      value: explist['name'],
                                      child: Text(explist['name']),
                                      onTap: () {
                                        stateID = explist['id'];
                                        getCity(stateID);
                                        print("stateID-->" + stateID);
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      state = value;
                                      city = null;
                                      if (stateID == 0) {
                                        state = null;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFieldContainer(
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  hint: cityName != null
                                      ? Text(city == null ? cityName : city,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold))
                                      : Text(All_Lan().city),
                                  value: city,
                                  items: cityList.map((explist) {
                                    return DropdownMenuItem(
                                      value: explist['name'],
                                      child: Text(explist['name']),
                                      onTap: () {
                                        cityID = explist['id'];

                                        print("cityID-->" + cityID);
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      city = value;
                                      if (cityID == 0) {
                                        city = "";
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFieldContainer(
                                child: TextFormField(
                                  controller: _textEditingControllerPostalCode,
                                  validator: ((value) {
                                    if (value.isEmpty) {
                                      return "Field Required!!";
                                    }
                                    return null;
                                  }),
                                  cursorColor: kSecondaryLightColor,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.code_outlined,
                                      color: kSecondaryLightColor,
                                    ),
                                    labelText: All_Lan().postal_code,
                                    // labelText: "First Name",
                                    border: InputBorder.none,
                                    enabled: !_status,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        !_status ? _getActionButtons() : new Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
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
          getCountry();
        });
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    focusNode.dispose();
    super.dispose();
  }

  void alertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(All_Lan().logout),
          content: Text(
            All_Lan().are_you_sure_you_want_to_exit,
            style: TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text(
                All_Lan().cancel,
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.orange, fontSize: 15),
              ),
              onPressed: () async {
                if (employeeId.toString().isNotEmpty) {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setBool("loggedIn", false);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()),
                    ModalRoute.withName('/'),
                  );
                }
              },
            )
          ],
        );
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
                child: new Text(All_Lan().save),
                textColor: Colors.white,
                color: kSecondaryLightColor,
                onPressed: () {
                  setState(() {
                    UpdateEmployeeProfile();
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
                child: new Text(All_Lan().cancel),
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

  Future<GetProfileDataModel> GetEmployeeProfile() async {
    var employee_get_url =
        All_API().baseurl + All_API().api_get_profile + "/" + employeeId;
    print("employee_get_DATA_url -->" + employee_get_url);
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("new_employee_Get_basicAuth--> " + basicAuth);
    var headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('GET', Uri.parse(employee_get_url));
    request.fields.addAll({
      'employee_id': employeeId,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseded = await http.Response.fromStream(response);
    print("new_profile_get_profile_response -->" + responseded.body.toString());

    final jasonData = jsonDecode(responseded.body.toString());

    var msg = jasonData['message'];
    print("profile_EMPL_employee_fname_get_msg -->" + msg);
    if (response.statusCode == 200) {
      setState(() {
        var onlyprofiledata = GetProfileDataModel.fromJson(jasonData);
        firstName = onlyprofiledata.data.firstName;
        lastName = onlyprofiledata.data.lastName;
        email = onlyprofiledata.data.email;
        address = onlyprofiledata.data.address;
        countryName = onlyprofiledata.data.countryName;
        mobileNo = onlyprofiledata.data.mobileNo;
        stateName = onlyprofiledata.data.stateName;
        cityName = onlyprofiledata.data.cityName;
        getcountryid = onlyprofiledata.data.country;
        getstateid = onlyprofiledata.data.state;
        getcityid = onlyprofiledata.data.city;
        zip = onlyprofiledata.data.zip;
        profilePath = onlyprofiledata.data.path;
        profile = onlyprofiledata.data.profileImg;
        profileImage = All_API().baseurl_img + profilePath + "/" + profile;
        print("profileIMAGE Check---> " + profileImage);
        countryID = getcountryid;
        stateID = getstateid;
        cityID = getcityid;
        print("employee_fname--> " + firstName);
        _textEditingControllerFName = TextEditingController(text: firstName);
        print("employee_fname--> " + _textEditingControllerFName.text);
        _textEditingControllerLName = TextEditingController(text: lastName);
        _textEditingControllerPhoneNo = TextEditingController(text: mobileNo);
        _textEditingControllerEmailId = TextEditingController(text: email);
        _textEditingControllerCountry = TextEditingController(text: countryName);
        _textEditingControllerState = TextEditingController(text: stateName);
        _textEditingControllerCity = TextEditingController(text: cityName);
        _textEditingControllerPostalCode = TextEditingController(text: zip);
        _textEditingControllerAddress = TextEditingController(text: address);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  void selectImage() async {
    var imagepicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imagepicker != null) {
      setState(() {
        uploadProfileimage = imagepicker;
        print("uploadProfileimage--->> " + uploadProfileimage.path);

      });
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Please Select Profile Image !!')));
    }
  }



  void getCountry() async {
    var country_url =
        All_API().baseurl + All_API().api_getcountry ;
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("employee_update_basicAuth--> " + basicAuth);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.Request('GET',Uri.parse(country_url));

    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      print("-------->" + response.body);
      setState(() {
        // _status = true;
        countryList = json["data"];
        print("List-------->" + countryList.length.toString());
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  void getState(String cID) async {
    var state_url =
        All_API().baseurl + All_API().api_getstate+"/"+cID;
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("employee_update_basicAuth--> " + basicAuth);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.Request(
        'GET',
        Uri.parse(state_url));

    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("state-------->" + response.body);

      setState(() {
        // _status = true;
        stateList = json["data"];
        print("state List-------->" + stateList.length.toString());
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        stateList = json["data"];
      });
    }
  }

  void getCity(String stID) async {
    var city_url =
        All_API().baseurl + All_API().api_getcity+"/"+stID;
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("employee_update_basicAuth--> " + basicAuth);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.Request(
        'GET',
        Uri.parse(city_url));

    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        cityList = json["data"];
        print("city List-------->" + cityList.length.toString());
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        cityList = json["data"];
        print("city List-------->" + cityList.length.toString());
      });
    }
  }

  void UpdateEmployeeProfile() async{
    setState(() {
      loading = true;
      // GetEmployeeProfileIMG();
    });
    var fname = _textEditingControllerFName.text;
    var lname = _textEditingControllerLName.text;
    var email = _textEditingControllerEmailId.text;
    var mobile = _textEditingControllerPhoneNo.text;
    var country = _textEditingControllerCountry.text;
    var state = _textEditingControllerState.text;
    var city = _textEditingControllerCity.text;
    var zip = _textEditingControllerPostalCode.text;
    var add = _textEditingControllerAddress.text;
    print("-------------------->"+fname+"\n"+lname+"\n"+email+"\n"+mobile+"\n"+country+"\n"+state+"\n"
        +city+"\n"+zip+"\n"+add+"\n"+companyId+"\n"+countryID+"\n"+stateID+"\n"+cityID);
    var employee_update_url = All_API().baseurl + All_API().api_employee_update;
    print("employee_update_url -->" + employee_update_url);
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("employee_update_basicAuth--> " + basicAuth);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(employee_update_url));
    request.fields.addAll({
      'firstname': fname,
      'lastname': lname,
      'email_id': email,
      'address': add,
      'mobile_no': mobile,
      'country': countryID,
      'state': stateID,
      'city': cityID,
      'employee_id': employeeId,
      'company_id': companyId,
      'zip': zip,
    });

    if (uploadProfileimage == null) {
      var multipartFile = http.MultipartFile.fromString('file', profile);

      request.files.add(multipartFile);
    } else if (uploadProfileimage != null) {
      imageString = uploadProfileimage.path;
      final files = await http.MultipartFile.fromPath('file', imageString);
      print("member_image_file---> : " + files.toString());
      request.files.add(files);
    }


    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print("UPDATE &&&&@------------>"+response.body);

    if (response.statusCode == 200) {
      print("UPDATE------------>"+ response.body);
      setState(() {
        loading = false;
        _status = true;
        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(
          content: Text(
            "Saved Successfully",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
    else {
      print("Error-------->"+response.reasonPhrase);
      setState(() {
        loading = false;
        _status = true;
        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(
          content: Text(
            "Data Not Saved ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // GetEmployeeProfileIMG();
      });
    }
  }
}
