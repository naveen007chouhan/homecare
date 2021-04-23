import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/HomePages/tasklistDetail.dart';

import 'package:homecare/components/spinner_field_container.dart';

import 'package:homecare/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dayLeave=null;
  var dayLeaveID;
  FocusNode focusNode = new FocusNode();
  String AssignedDate= 'assigned_date';
  String DeadlineDate= 'deadline_date';
  List DayTypeList=[{'id':'0','name':'Choose Type'},{'id':'1','name':'DeadlineDate'},{'id':'2','name':'AssignedDate'}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 210,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kSecondaryLightColor, kSecondaryColor]),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20.0, top: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 8,
                                    spreadRadius: 3)
                              ],
                              border: Border.all(
                                width: 1.5,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://images.pexels.com/photos/2167673/pexels-photo-2167673.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Naveen Chouhan",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.camera_front,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "\$200",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      /*children: [
                                          TextSpan(
                                              text: ".50",
                                              style: TextStyle(
                                                  color: Colors.white38))
                                        ]*/
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.white,
                  child: ListView(
                    /*margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),*/
                    padding: EdgeInsets.only(top: 60),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 11.0),
                        child: Text(
                          "Today Task",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskDetail()));
                        },
                        child: Card(

                          // color: Colors.green,
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)
                                  // topRight: Radius.circular(10.0),
                                  // bottomRight: Radius.circular(10.0),
                                  // topLeft: Radius.circular(10.0),
                                  // bottomLeft: Radius.circular(10.0),
                                ),
                              ),
                              margin: const EdgeInsets.only(
                                  top: 5, left: 2, bottom: 5, right: 2),
                              child: Column(
                                children: [
                                  ListTile(

                                    leading:Card(
                                      color: kPrimaryColor,
                                      elevation: 5,

                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text("Processing",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orangeAccent)),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Type : ",
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Alot Date : ",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      trailing: Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color: Colors.grey[600],
                                          size: 30.0)),
                                  Divider(
                                    height: 1,
                                    color: kSecondaryLightColor,
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child:Padding(

                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("Dead Line : ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red)),
                                    ),
                                  ),

                                ],
                              )
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 140,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              // width: MediaQuery.of(context).size.width * 0.7,
              height: 115,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 8,
                      spreadRadius: 3,
                      offset: Offset(0, 10),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(50),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Task Filter",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.filter_1,
                                color: Color(0XFF00838F),
                              )
                            ],
                          ),
                          SpinnerFieldContainer(
                            child: DropdownButton(
                              underline: SizedBox(),
                              isExpanded: true,
                              hint: Text("Choose Type",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,color: Colors.orange)),
                              value: dayLeave,
                              style: new TextStyle(
                                color: Colors.orange,
                              ),
                              items: DayTypeList.map((explist) {
                                return DropdownMenuItem(
                                  value: explist['name'],
                                  child: Text(explist['name']),
                                  onTap: (){
                                    dayLeaveID = explist['id'];
                                    print("leavess-->"+explist['id']);
                                  },
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dayLeave = value;
                                  if(dayLeaveID==0){
                                    dayLeave = null;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                     /* Container(width: 1, height: 50, color: Colors.grey),*/

                    ],
                  ),
                  /*SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You spent \$ 1,494 this month",
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Let's see the cost statistics for this period",
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Tell me more",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF00B686)),
                    ),
                  )*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Future homeTaskList() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("log_basicAuth--> "+basicAuth);

    var all_task_list_url= All_API().baseurl+All_API().api_all_task_list;
    print("all_task_list_url -->" +all_task_list_url);



    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(all_task_list_url));

    // print("taskdetail_lat_long--> " + latitude+" "+longitude);
    request.fields.addAll({

      'employee_id': "5",
      'date_field': AssignedDate,
      /*'start_date': barcoderesult,
      'end_date': latitude,*/
    });

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("scanner_body_response -->" +response.body);

    var  jasonData = jsonDecode(response.body);
    String msg=jasonData['message'];
    print("scanner_MSG--> "+ msg );
    // print("log_statuscode_response -->" +jasonData.statusCode);


    // final Map<String, String> jasonData = jsonDecode(response.body);
    // String msg=jasonData['error'];
    // print("MSG--> "+ msg );
    try{

      if(response.statusCode==200){
        var  jasonData = jsonDecode(response.body);


        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(content: Text(msg,style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      }else{
        setState(() {
          // pr.hide();
          // progress=false;
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BottomBar();
              },
            ),
          );*/
          FocusScope.of(context).requestFocus(focusNode);
          final snackBar = SnackBar(content: Text(msg,style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }

    }catch(e){
      return e;
    }
  }
}
