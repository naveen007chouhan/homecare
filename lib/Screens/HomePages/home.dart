import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/HomePages/HomeModel/DashboardDetailModel.dart';
import 'package:homecare/Screens/HomePages/HomeModel/DashboardDetailProfileModel.dart';
import 'package:homecare/Screens/HomePages/HomeModel/LastFiveTaskModel.dart';
import 'package:homecare/Screens/HomePages/tasklistDetail.dart';

import 'package:homecare/constants.dart';
import 'package:homecare/loading.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  var daslist;
  bool progress = true;
  FocusNode focusNode = new FocusNode();
  final TextStyle whiteText = TextStyle(color: Colors.white);

  Map<String, double> clientdataMap ;
  Map<String, double> dataMap;

  List<Color> colorlist = [
    Colors.pink,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.red[800],
    Colors.brown,
  ];
  List<Color> clientcolorlist = [
    Colors.blue,
  ];
  Widget taskpiecart() {
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 2000),
      chartLegendSpacing: 64,
      chartRadius: MediaQuery.of(context).size.width / 2.5,
      colorList: colorlist,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 42,
      centerText: "Tour",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,

        // legendShape: _BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }

  Widget clientpiecart() {
    return PieChart(
      dataMap: clientdataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 64,
      chartRadius: MediaQuery.of(context).size.width / 2.5,
      colorList: clientcolorlist,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 42,
      emptyColor: Colors.orange,
      centerText: "Client",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,

        // legendShape: _BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }

  List Demotask;

  String employeeId;
  String companyId;
String employeename;
String employeecode;

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      employeeId = sharedPreferences.getString("employeeId");
      companyId = sharedPreferences.getString("companyId");

      homeDetailList(employeeId);
      homeDetailForprofileList(employeeId);
      // homeTaskList(employeeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.dark,
        backgroundColor: kSecondaryLightColor,
        elevation: 8,
        leading: Image.asset(
          "assets/images/easyyhomecarelogo.png",
          height: 200,
          width: 200,
        ),
        title: Text(
          'Easy Home Care',
          style: TextStyle(
            color: Colors.white,
          ),
        ),

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(

          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              FutureBuilder <DashboardDetailProfileModel>(
                future: homeDetailForprofileList(employeeId),
            // ignore: missing_return
                 builder: (context,snapshot){
                   switch (snapshot.connectionState) {
                     case ConnectionState.none:
                       return Text('none');
                     case ConnectionState.waiting:
                       return Center(child: CircularProgressIndicator());
                     case ConnectionState.active:
                       return Text('');
                     case ConnectionState.done:
                       if(snapshot.hasData){
                         var profilecheck=snapshot.data.data.employeeDetail.profileImg;
                         var tourimgemp = All_API().baseurl_img+snapshot.data.data.employeeDetail.path+"/"+snapshot.data.data.employeeDetail.profileImg;
                         print("toureeeimg---->>"+tourimgemp);
                         var fname =  snapshot.data.data.employeeDetail.firstName;
                         var lname =  snapshot.data.data.employeeDetail.lastName;
                         var empname = fname+ " "+lname;

                         var empcode =snapshot.data.data.employeeDetail.slug;
                         var compcode=snapshot.data.data.employeeDetail.companyCode;
                          var compname=snapshot.data.data.employeeDetail.companyName;
                          return  Stack(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 10, right: 10.0, top: 2),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 170,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 100.0,
                                                height: 100.0,
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
                                                  borderRadius: BorderRadius.circular(50.0),
                                                ),

                                                padding: EdgeInsets.all(5),
                                                child: CircleAvatar(
                                                  backgroundImage:NetworkImage(
                                                      tourimgemp==All_API().baseurl_img_error?
                                                      All_API().baseurl_img_default
                                                      :tourimgemp),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 30,
                                right: 0,
                                child: Container(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                  // width: MediaQuery.of(context).size.width * 0.7,
                                  height: 140,
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
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [

                                                        WidgetSpan(
                                                          child: Container(
                                                              padding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                                                              child:Icon(Icons.perm_identity, size: 14,color:kSecondaryLightColor ,)),

                                                        ),

                                                        TextSpan(
                                                          text: empname == null
                                                              ? "Naveen Chouhan"
                                                              : empname.toUpperCase(),

                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600,
                                                              color: kSecondaryLightColor

                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                                    child: Row(
                                                      children: [

                                                        empcode == null
                                                            ? RichText(
                                                          text: TextSpan(
                                                            text: "xxxx",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              color:
                                                              kSecondaryLightColor,
                                                            ),
                                                          ),
                                                        )
                                                            : RichText(
                                                          text: TextSpan(
                                                            text: empcode,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              color:Colors.grey,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [

                                                        WidgetSpan(
                                                          child: Container(
                                                              padding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                                                              child:Icon(Icons.home, size: 14,color:kSecondaryLightColor ,)),

                                                        ),

                                                        TextSpan(
                                                          text: compname == null
                                                              ? "Naveen Chouhan"
                                                              : compname.toUpperCase(),

                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600,
                                                              color: kSecondaryLightColor

                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                                    child: Row(
                                                      children: [

                                                        compcode == null
                                                            ? RichText(
                                                          text: TextSpan(
                                                            text: "xxxx",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              color:
                                                              kSecondaryLightColor,
                                                            ),
                                                          ),
                                                        )
                                                            : RichText(
                                                          text: TextSpan(
                                                            text: compcode,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              color:Colors.grey,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                       }
                   }
                 }
              ),

              const SizedBox(height: 5.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Client",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              dataMap == null ? Loading() : clientpiecart(),
              const SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Tour Status",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                child: dataMap == null ? Loading() : taskpiecart(),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Last 5 Tour",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                height: 400,
                  child: FutureBuilder<LastFiveTaskModel>(
                    future: homeLASTFIVETaskList(employeeId),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('none');
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.active:
                            return Text('');
                          case ConnectionState.done:
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder: (context, index) {
                                    var lasttask = snapshot.data.data[index];
                                    var clientname=lasttask.clientfirstName+ " "+lasttask.clientlastName;
                                    print("lst_FIVE_TASK-->" + lasttask.taskImagemode.toString());
                                    var alot = lasttask.deadlineDate.toString();
                                    var alot1 = lasttask.assignedDate.toString();
                                    var tourimg = All_API().baseurl_img+lasttask.taskpath+lasttask.taskImage;
                                    var defaultimg = All_API().baseurl_img+lasttask.taskImage;
                                    var omgtaskmode =lasttask.taskImagemode;
                                    var alotsplit = alot1.split(" ");
                                    var assigndatealot = alotsplit[0];

                                    var deadlinealotsplit = alot.split(" ");
                                    var deadlinealot = deadlinealotsplit[0];

                                    print("datealot-->" + alot);
                                    print("datealot-->" + deadlinealot);
                                    print("datealot-->" + alot1);
                                    print("datealot-->" + assigndatealot);
                                    print("datealot-->" + tourimg );
                                    print("datealot-->" + defaultimg);
                                    print("datealot-->" + omgtaskmode.toString());
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TaskDetail(
                                                      empid: lasttask.employeeId,
                                                      taskid: lasttask.taskId,
                                                    )));
                                      },
                                      child: Card(
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Stack(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 200.0,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10.0),
                                                        topRight: Radius.circular(10.0),
                                                      ),
                                                      image: DecorationImage(
                                                        image:omgtaskmode==0? NetworkImage(defaultimg):NetworkImage(tourimg),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    // padding: const EdgeInsets.all(16.0),
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                    child: Text(
                                                      lasttask.taskName,
                                                      style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [

                                                            WidgetSpan(
                                                              child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                                                                child: Icon(Icons.category, size: 14,color:Colors.grey ,),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: lasttask.categoryName,
                                                              style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      Spacer(),
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [

                                                            WidgetSpan(
                                                              child: Padding(
                                                                padding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                                                                child: Icon(Icons.person, size: 14,color:Colors.grey ,),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: clientname,
                                                              style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20.0),
                                              ],
                                            ),
                                            Positioned(
                                              top: 10,
                                              left: 20.0,
                                              child: Container(
                                                color: Colors.green,
                                                padding: const EdgeInsets.all(4.0),
                                                child: Text(
                                                  lasttask.status,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 20.0,
                                              child: Container(
                                                color: Colors.blue,
                                                padding: const EdgeInsets.all(4.0),
                                                child: Text(
                                                  lasttask.taskModeName,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 170,
                                              left: 5.0,
                                              child: Container(
                                                color: Colors.orange,
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "Date :" + assigndatealot.toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 170,
                                              right: 5.0,
                                              child: Container(
                                                color: Colors.orange,
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "Deadline : " + deadlinealot.toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
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
                        }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<DashboardDetailModel> homeDetailList(String empid) async {
    var all_task_list_url =
        All_API().baseurl + All_API().api_dashboard + "/" + empid;
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
    var jasonDataNotification = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {

        progress = false;
        var daslist = DashboardDetailModel.fromJson(jasonDataNotification);

        setState(() {

          var completetask = daslist.data.completeTask;
          var pendingtask = daslist.data.pendingTask;
          var processing = daslist.data.processingTask;
          var TotalTask = daslist.data.totalTask;
          var ApprovedTask = daslist.data.approvedTask;
          var Rejectedtask = daslist.data.rejectedTask;
          var Totalclient = daslist.data.totalClient;

          double dd = double.parse(completetask.toString());
          double dd1 = double.parse(pendingtask.toString());
          double dd2 = double.parse(TotalTask.toString());
          double dd3 = double.parse(ApprovedTask.toString());
          double dd4 = double.parse(Rejectedtask.toString());
          double dd5 = double.parse(processing.toString());
          double dd6 = double.parse(Totalclient.toString());

          dataMap = {
            "Pending Tour": dd1==null?0.0:dd1,
            "Completed Tour": dd==null?0.0:dd,
            "Total Tour": dd2==null?0.0:dd2,
            "Approved Tour": dd3==null?0.0:dd3,
            "Rejected Tour": dd4==null?0.0:dd4,
            "Processing Tour": dd5==null?0.0:dd5,
          };
          clientdataMap={
            " Total Client": dd6==null?0.0:dd6,
          };

        });

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
  Future<DashboardDetailProfileModel> homeDetailForprofileList(String empid) async {
    var all_task_list_url =
        All_API().baseurl + All_API().api_dashboard + "/" + empid;
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
    print("Dash_Profile_body_response -->" + response.body);

    /*var jasonData = jsonDecode(response.body);
    // String msg = jasonData['message'];*/
    var jasonDataNotification = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {

        progress = false;
        return DashboardDetailProfileModel.fromJson(jasonDataNotification);



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

  Future<LastFiveTaskModel> homeLASTFIVETaskList(String empid) async {
    var all_LAST_task_list_url =
        All_API().baseurl + All_API().api_emp_Lastfivetask + "/" + empid;
    print("all_LAST_task_url -->" + all_LAST_task_list_url);
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("all_LAST_task_basicAuth--> " + basicAuth);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('GET', Uri.parse(all_LAST_task_list_url));

    print("all_LAST_task_empid--> " + employeeId);

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("all_LAST_task_body_response -->" + response.body);
    try {
      if (response.statusCode == 200) {
        /*setState(() {
          progress = false;
        });*/
        var jasonDataNotification = jsonDecode(response.body);
        return LastFiveTaskModel.fromJson(jasonDataNotification);
      } else {
        // setState(() {
        //   progress = false;
        // });
      }
    } catch (e) {
      return e;
    }
  }
}
