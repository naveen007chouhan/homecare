import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/ClientPages/clientlist.dart';
import 'package:homecare/Screens/HistoryTask/HistoryTaskList.dart';
import 'package:homecare/Screens/HomePages/HomeModel/DashboardDetailProfileModel.dart';
import 'package:homecare/Screens/HomePages/HomeModel/LastFiveTaskModel.dart';
import 'package:homecare/Screens/HomePages/tasklistDetail.dart';

import 'package:homecare/constants.dart';
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

  FocusNode focusNode = new FocusNode();
  final TextStyle whiteText = TextStyle(color: Colors.white);

  String employeeId;
  String companyId;

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      employeeId = sharedPreferences.getString("employeeId");
      companyId = sharedPreferences.getString("companyId");
      homeDetailForprofileList(employeeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryLightColor,
        elevation: 8,
        leading: Image.asset(
          "assets/images/easyyhomecarelogo.png",
          height: 200,
          width: 200,
        ),
        title: Text(
          All_Lan().easyhomecare,
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
              FutureBuilder<DashboardDetailProfileModel>(
                  future: homeDetailForprofileList(employeeId),
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
                          var profilecheck =
                              snapshot.data.data.employeeDetail.profileImg;
                          var tourimgemp = All_API().baseurl_img +
                              snapshot.data.data.employeeDetail.path +
                              "/" +
                              snapshot.data.data.employeeDetail.profileImg;
                          var fname =
                              snapshot.data.data.employeeDetail.firstName;
                          var lname =
                              snapshot.data.data.employeeDetail.lastName;
                          var empname = fname + " " + lname;

                          var totalcl = snapshot.data.data.totalClient;
                          var totaltour = snapshot.data.data.totalTask;
                          var pendingtour = snapshot.data.data.pendingTask;
                          var processingtour =
                              snapshot.data.data.processingTask;
                          var completetour = snapshot.data.data.completeTask;
                          var approvedtour = snapshot.data.data.approvedTask;
                          var rejectedtour = snapshot.data.data.rejectedTask;

                          var empcode = snapshot.data.data.employeeDetail.slug;
                          var compcode =
                              snapshot.data.data.employeeDetail.companyCode;
                          var compname =
                              snapshot.data.data.employeeDetail.companyName;
                          return Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5.0, top: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.1),
                                                blurRadius: 8,
                                                spreadRadius: 3)
                                          ],
                                          border: Border.all(
                                            width: 1.5,
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 100.0,
                                                    height: 100.0,
                                                    decoration: BoxDecoration(
                                                      color: kSecondaryColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    .1),
                                                            blurRadius: 8,
                                                            spreadRadius: 3)
                                                      ],
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                    padding: EdgeInsets.all(5),
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          tourimgemp ==
                                                                  All_API()
                                                                      .baseurl_img_error
                                                              ? All_API()
                                                                  .baseurl_img_default
                                                              : tourimgemp),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Icon(
                                                            Icons.person,
                                                            color:
                                                                Colors.black26,
                                                            size: 15.0,
                                                          ),
                                                          SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Text(
                                                            empname == null
                                                                ? All_Lan().name
                                                                : empname
                                                                    .toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    kSecondaryLightColor),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                          empcode,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Icon(
                                                            Icons.home_filled,
                                                            color:
                                                                Colors.black26,
                                                            size: 15.0,
                                                          ),
                                                          SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          Text(
                                                            compname == null
                                                                ?All_Lan().name
                                                                : compname
                                                                    .toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    kSecondaryLightColor),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                          compcode,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.blue,
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.blue
                                                          .withOpacity(.2),
                                                      blurRadius: 50,
                                                      spreadRadius: 3)
                                                ],
                                              ),
                                              height: 110,
                                              width: 110,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 35, 10, 0),
                                                    child: totalcl == 0
                                                        ? Text("0",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 35,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                        : Text(totalcl.toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 35,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              All_Lan().total_client,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                        onTap:(){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ClientDetail()));
                                        }
                                    ),
                                    GestureDetector(
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.green,
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                            ),
                                            child: Container(
                                              height: 110,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.green
                                                          .withOpacity(.2),
                                                      blurRadius: 50,
                                                      spreadRadius: 3)
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(
                                                              10, 35, 10, 0),
                                                      child: totaltour == 0
                                                          ? Text("0",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 35,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))
                                                          : Text(
                                                              totaltour
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 35,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              All_Lan().total_tour,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                        onTap:(){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => TaskListHistory()));
                                        }
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 11.0),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      All_Lan().total_client,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.orange,
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.orange
                                                          .withOpacity(.2),
                                                      blurRadius: 50,
                                                      spreadRadius: 3)
                                                ],
                                              ),
                                              height: 70,
                                              width: 70,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 25, 10, 0),
                                                    child: pendingtour == 0
                                                        ? Text("0",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                        : Text(
                                                            pendingtour
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              All_Lan().pending_tour,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.pink,
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.pink
                                                          .withOpacity(.2),
                                                      blurRadius: 50,
                                                      spreadRadius: 3)
                                                ],
                                              ),
                                              height: 70,
                                              width: 70,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 25, 10, 0),
                                                    child: processingtour == 0
                                                        ? Text("0",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                        : Text(
                                                            processingtour
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              All_Lan().processing_tour,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.blue,
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.blue
                                                          .withOpacity(.2),
                                                      blurRadius: 50,
                                                      spreadRadius: 3)
                                                ],
                                              ),
                                              height: 70,
                                              width: 70,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 25, 10, 0),
                                                    child: completetour == 0
                                                        ? Text("0",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                        : Text(
                                                            completetour
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              All_Lan().completed_tour,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.green,
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.green
                                                          .withOpacity(.2),
                                                      blurRadius: 50,
                                                      spreadRadius: 3)
                                                ],
                                              ),
                                              height: 70,
                                              width: 70,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 25, 10, 0),
                                                    child: approvedtour == 0
                                                        ? Text("0",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                        : Text(
                                                            approvedtour
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              All_Lan().approved_tour,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.red,
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.red
                                                          .withOpacity(.2),
                                                      blurRadius: 50,
                                                      spreadRadius: 3)
                                                ],
                                              ),
                                              height: 70,
                                              width: 70,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            10, 25, 10, 0),
                                                    child: rejectedtour == 0
                                                        ? Text("0",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                        : Text(
                                                            rejectedtour
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              All_Lan().rejected_tour,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                                  All_Lan().no_result_found,
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
                  }),
              const SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    All_Lan().last_5_tour,
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
                                  var clientname = lasttask.clientfirstName +
                                      " " +
                                      lasttask.clientlastName;

                                  var alot = lasttask.deadlineDate.toString();
                                  var alot1 = lasttask.assignedDate.toString();
                                  var tourimg = All_API().baseurl_img +
                                      lasttask.taskpath +
                                      lasttask.taskImage;
                                  var defaultimg = All_API().baseurl_img +
                                      lasttask.taskImage;
                                  var omgtaskmode = lasttask.taskImagemode;
                                  var alotsplit = alot1.split(" ");
                                  var assigndatealot = alotsplit[0];

                                  var deadlinealotsplit = alot.split(" ");
                                  var deadlinealot = deadlinealotsplit[0];


                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TaskDetail(
                                                    empid: lasttask.employeeId,
                                                    taskid: lasttask.taskId,
                                                  )));
                                    },
                                    child: Card(
                                      elevation: 4.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                height: 200.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      topRight:
                                                          Radius.circular(10.0),
                                                    ),
                                                    image: DecorationImage(
                                                      image: omgtaskmode == 0
                                                          ? NetworkImage(
                                                              defaultimg)
                                                          : NetworkImage(
                                                              tourimg),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          WidgetSpan(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      1,
                                                                      1,
                                                                      5,
                                                                      0),
                                                              child: Icon(
                                                                Icons.category,
                                                                size: 14,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: lasttask
                                                                .categoryName,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
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
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      1,
                                                                      1,
                                                                      5,
                                                                      0),
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 14,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: clientname,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
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
                                            child: lasttask.status == "pending"
                                                ? Container(
                                                    color: Colors.orange,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      lasttask.status,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                  )
                                                : lasttask.status ==
                                                        "processing"
                                                    ? Container(
                                                        color: Colors.pink,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          lasttask.status,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      )
                                                    : lasttask.status ==
                                                                "completed" &&
                                                            lasttask.isApproved ==
                                                                "2"
                                                        ? Container(
                                                            color: Colors.red,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              "Rejected",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          )
                                                        : lasttask.status ==
                                                                    "completed" &&
                                                                lasttask.isApproved ==
                                                                    "1"
                                                            ? Container(
                                                                color: Colors
                                                                    .green,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "Approved",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                              )
                                                            : lasttask.status ==
                                                                        "completed" &&
                                                                    lasttask.isApproved ==
                                                                        "0"
                                                                ? Container(
                                                                    color: Colors
                                                                        .blue,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      "Completed",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12.0,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 20.0,
                                            child: Container(
                                              color: Colors.blue,
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    All_Lan().date+":" +
                                                        assigndatealot
                                                            .toString(),
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                  All_Lan().deadline_date+":" +
                                                        deadlinealot.toString(),
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

  Future<DashboardDetailProfileModel> homeDetailForprofileList(
      String empid) async {
    var all_task_list_url =
        All_API().baseurl + All_API().api_dashboard + "/" + empid;
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('GET', Uri.parse(all_task_list_url));

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jasonDataNotification = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
        return DashboardDetailProfileModel.fromJson(jasonDataNotification);
      } else {}
    } catch (e) {
      return e;
    }
  }

  Future<LastFiveTaskModel> homeLASTFIVETaskList(String empid) async {
    var all_LAST_task_list_url =
        All_API().baseurl + All_API().api_emp_Lastfivetask + "/" + empid;

    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request =
        http.MultipartRequest('GET', Uri.parse(all_LAST_task_list_url));
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    try {
      if (response.statusCode == 200) {
        var jasonDataNotification = jsonDecode(response.body);
        return LastFiveTaskModel.fromJson(jasonDataNotification);
      } else {
      }
    } catch (e) {
      return e;
    }
  }
}
