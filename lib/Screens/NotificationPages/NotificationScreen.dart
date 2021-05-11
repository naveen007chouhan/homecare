import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/NotificationPages/Model/NotificationModel.dart';
import 'package:homecare/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreens extends StatefulWidget {
  @override
  _NotificationScreensState createState() => _NotificationScreensState();
}

class _NotificationScreensState extends State<NotificationScreens> {
  String employeeId;
  String companyId;
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
      companyId = sharedPreferences.getString("companyId");
      Notification(employeeId);
      print("employeeId -> " + employeeId);
    });
  }
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
        /*IconButton(
          icon: Icon(Icons.notification_important_outlined),
          color: Colors.white,
          onPressed: () {},
        ),*/
      ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<NotificationModel>(
              future: Notification(employeeId),
              // ignore: missing_return
              builder: (context, snapshot) {

                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, index) {
                          var lasttask = snapshot.data.data[index];
                          var alot=lasttask.createdAt.toString();

                          var cfirst=lasttask.employeefirstName.toString();
                          var llast=lasttask.employeelastName.toString();
                          var clientname=cfirst+" "+llast;
                          var deadlinealotsplit =alot.split(" ");
                          var deadlinealot =deadlinealotsplit[0];
                          var timealot =deadlinealotsplit[1];

                          print("datealot-->"+deadlinealot);
                          // var pathimg =
                          //     lasttask.path + lasttask.taskImage.toString();

                          print("fivetask--> " + lasttask.toString());
                          // print("pathimg--> " + pathimg);
                          return Card(
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
                                     /* leading: Container(
                                        padding: EdgeInsets.only(right: 12.0),
                                        decoration: new BoxDecoration(
                                            border: new Border(
                                                right: new BorderSide(width: 1.0, color: Colors.white24))),
                                        child: Image.network("https://images.pexels.com/photos/2167673/pexels-photo-2167673.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"),
                                      ),*/
                                      title: Text(
                                        clientname,
                                        style: TextStyle(color: kSecondaryLightColor, fontWeight: FontWeight.bold),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Row(
                                        children: <Widget>[
                                          Text(lasttask.message, style: TextStyle(color: Colors.grey[400]),maxLines: 2,)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Date:'+deadlinealot,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            'Time :'+timealot,
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
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Card(
                          color: Colors.blue[1000],
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              All_API().no_task_found,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.orange,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }

              },
            ),
          ],
        ),
      )
    );
  }
  Future<NotificationModel> Notification(empid) async {
    var all_task_list_url =
        All_API().baseurl + All_API().api_get_Notification + "/" + empid;
    print("Dash_Field_url -->" + all_task_list_url);
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("Dash_Field_basicAuth--> " + basicAuth);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('GET', Uri.parse(all_task_list_url));

    print("Dash_Field--> " + employeeId);

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("Dash_Field_body_response -->" + response.body);

    /*var jasonData = jsonDecode(response.body);
    // String msg = jasonData['message'];*/
    // var jasonDataNotification = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
        var jasonDataNotification = jsonDecode(response.body);
        // progress = false;
        // print("Dash_Field_MSG--> " + msg);
        // var completetask=jasonDataNotification['data'][0]['CompleteTask'] ;
        // var pendingtask=jasonDataNotification['data'][0]['pendingTask'] ;
        // var TotalTask=jasonDataNotification['data'][0]['totalTask'] ;
        // // List taskrel= jasonDataNotification['data'][0]['LastFiveTask'];
        // print("LIST--->"+ taskrel[0]);
        return NotificationModel.fromJson(jasonDataNotification);

        // print("compTASK_MSG--> " + completetask.toString());
        // return null;
      } else {
        setState(() {
          progress = false;
        });
      }
    } catch (e) {
      return e;
    }
  }
}
