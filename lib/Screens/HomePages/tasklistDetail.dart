import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/BottomNavigation/bottombar.dart';
import 'package:homecare/Screens/HomePages/DocumentSavePage.dart';
import 'package:homecare/Screens/HomePages/HomeModel/TaskDetailModel.dart';
import 'package:homecare/constants.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskDetail extends StatefulWidget {
  String taskid;
  String empid;

  TaskDetail({this.taskid, this.empid});

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  Future<TaskDetailModel> taskdetaill;
  String barcoderesult = "Hey there !";
  PermissionStatus permissionstorage;
  bool progress = false;
  FocusNode focusNode = new FocusNode();
  bool isCameraPermissionAccepted;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  SharedPreferences sharedPreferences;
  String latitude;
  String longitude;
  String prog = "0";
  String status;
  String deadlinedate;
  String createdate;
  String clientname;
  String clientmob;
  String taskcat;
  String taskmode;
  String taskdes;
  String taskaddress;
  var dio = Dio();

  @override
  void initState() {
    super.initState();

    getPermission();
    taskdetaill = gettaaskdetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryLightColor,
        elevation: 8,
        title: Text(
          All_Lan().tour_details,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              child: FutureBuilder<TaskDetailModel>(
                future: taskdetaill,
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
                        var deaddatetime = snapshot
                            .data.data.taskDetail.deadlineDate
                            .toString();
                        var crdatetime = snapshot
                            .data.data.taskDetail.assignedDate
                            .toString();
                        var creat = crdatetime.split(" ");
                        var crdate = deaddatetime.split(" ");
                        createdate = creat[0];
                        deadlinedate = crdate[0];
                        var tourimg = All_API().baseurl_img +snapshot.data.data.taskDetail.taskpath + snapshot.data.data.taskDetail.taskImage;
                        var defaultimg = All_API().baseurl_img +snapshot.data.data.taskDetail.taskImage;
                        var omgtaskmode =snapshot.data.data.taskDetail.taskImagemode;
                        var attachmentno = snapshot.data.data.attachmentIs;
                        var taskiddetail = snapshot.data.data.taskDetail.taskId;
                        var taskCategoryemp = snapshot.data.data.taskDetail.taskCategory;
                        var taskpathemp = snapshot.data.data.taskDetail.taskpath;
                        var taskAttachmentspdf =  All_API().baseurl_img+taskpathemp+snapshot.data.data.taskDetail.taskAttachments;
                        print("taskAttachmentspdf--> "+taskAttachmentspdf);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                    height: 250,
                                    width: double.infinity,
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        image: omgtaskmode == 0
                                            ? NetworkImage(defaultimg)
                                            : NetworkImage(tourimg),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Positioned(
                                  top: 15,
                                  left: 20.0,
                                  child: snapshot.data.data.taskDetail
                                              .taskStatus ==
                                          "pending"
                                      ? Container(
                                          color: Colors.orange,
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            snapshot.data.data.taskDetail
                                                .taskStatus,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        )
                                      : snapshot.data.data.taskDetail
                                                  .taskStatus ==
                                              "processing"
                                          ? Container(
                                              color: Colors.pink,
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                snapshot.data.data.taskDetail
                                                    .taskStatus,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            )
                                          : snapshot.data.data.taskDetail
                                                          .taskStatus ==
                                                      "completed" &&
                                                  snapshot.data.data.taskDetail
                                                          .isApproved ==
                                                      "2"
                                              ? Container(
                                                  color: Colors.red,
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    "Rejected",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                )
                                              : snapshot.data.data.taskDetail
                                                              .taskStatus ==
                                                          "completed" &&
                                                      snapshot
                                                              .data
                                                              .data
                                                              .taskDetail
                                                              .isApproved ==
                                                          "1"
                                                  ? Container(
                                                      color: Colors.green,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Approved",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                    )
                                                  : snapshot
                                                                  .data
                                                                  .data
                                                                  .taskDetail
                                                                  .taskStatus ==
                                                              "completed" &&
                                                          snapshot
                                                                  .data
                                                                  .data
                                                                  .taskDetail
                                                                  .isApproved ==
                                                              "0"
                                                      ? Container(
                                                          color: Colors.blue,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(
                                                            "Completed",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
                                ),
                                Positioned(
                                  top: 15,
                                  right: 20.0,
                                  child: Container(
                                    color: Colors.blue,
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      snapshot.data.data.taskDetail
                                                  .taskModeName ==
                                              null
                                          ? "status"
                                          : snapshot.data.data.taskDetail
                                              .taskModeName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 5.0,
                                  bottom: 0.0,
                                  child: Chip(
                                    elevation: 0,
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    backgroundColor: Colors.orange,
                                    label: Text(All_Lan().date+":" + createdate == null
                                        ? ""
                                        : All_Lan().date+":" +createdate),
                                  ),
                                ),
                                Positioned(
                                  right: 5.0,
                                  bottom: 0,
                                  child: Chip(
                                    elevation: 0,
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    backgroundColor: Colors.orange,
                                    label: Text(
                                        All_Lan().deadline_date+":" + deadlinedate == null
                                            ? " "
                                            : All_Lan().deadline_date+":" +deadlinedate),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6.0, bottom: 4.0),
                                        child: Text(
                                          snapshot.data.data.taskDetail
                                                      .taskName ==
                                                  null
                                              ? ""
                                              : snapshot.data.data.taskDetail
                                                  .taskName,
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )),
                                  Container(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6.0, bottom: 4.0, top: 10),
                                        child: Text(
                                          snapshot.data.data.taskDetail
                                              .taskCategory ==
                                              null
                                              ? All_Lan().category+": "
                                              : All_Lan().category+": " +
                                              snapshot.data.data.taskDetail
                                                  .taskCategory,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )),
                                  const SizedBox(height: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0, bottom: 4.0, top: 10),
                                    child: Text(
                                      All_Lan().client_details +" :",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black87),
                                    ),
                                  ),

                                  const SizedBox(height: 10.0),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                1, 1, 5, 0),
                                            child: Icon(
                                              Icons.person,
                                              size: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: snapshot.data.data.taskDetail
                                                      .clientName ==
                                                  null
                                              ? ""
                                              : snapshot.data.data.taskDetail
                                                  .clientName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                1, 1, 5, 0),
                                            child: Icon(
                                              Icons.phone,
                                              size: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: snapshot.data.data.taskDetail
                                                      .clientMobile ==
                                                  null
                                              ? ""
                                              : snapshot.data.data.taskDetail
                                                  .clientMobile,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      1, 1, 5, 0),
                                              child: Icon(
                                                Icons.email,
                                                size: 14,
                                                color: Colors.grey,
                                              )),
                                        ),
                                        TextSpan(
                                          text: snapshot.data.data.taskDetail
                                                      .clientEmail ==
                                                  null
                                              ? ""
                                              : snapshot.data.data.taskDetail
                                                  .clientEmail,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),

                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: snapshot.data.data.taskDetail.address ==
                                              null
                                              ? ""
                                              : "Address : " +
                                              snapshot.data.data.taskDetail
                                                  .address,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: snapshot.data.data.taskDetail
                                              .countryName ==
                                              null
                                              ? ""
                                              : "Country : " +
                                              snapshot.data.data.taskDetail
                                                  .countryName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: snapshot.data.data.taskDetail
                                              .stateName ==
                                              null
                                              ? ""
                                              : "State : " +
                                              snapshot.data.data.taskDetail
                                                  .stateName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: snapshot.data.data.taskDetail
                                              .cityName ==
                                              null
                                              ? ""
                                              : "City : " +
                                              snapshot.data.data.taskDetail
                                                  .cityName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0, bottom: 4.0, top: 10),
                                    child: Text(
                                      All_Lan().description,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black87),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0, bottom: 4.0),
                                    child:
                                        snapshot.data.data.taskDetail.message ==
                                                null
                                            ? Text(
                                                "Plumbing reached its early apex in ancient Rome, which saw the introduction of expansive systems of aqueducts, tile wastewater removal, and widespread use of lead pipes. The Romans used lead pipe inscriptions to prevent water theft. With the Fall of Rome both water supply and sanitation stagnated—or regressed—for well over 1,000 years. Improvement was very slow, with little effective progress made until the growth of modern densely populated cities in the 1800s. During this period, public health authorities began pressing for better waste disposal systems to be installed, to prevent or control epidemics of disease. ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                snapshot.data.data.taskDetail
                                                    .message,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey)),
                                  ),

                                  taskAttachmentspdf==""?Container():Align(
                                    alignment: Alignment.bottomCenter,
                                    child: RaisedButton.icon(
                                      color: kSecondaryLightColor,
                                      label: Text(
                                        All_Lan().download_attachment,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: kPrimaryColor),
                                      ),
                                      icon: Icon(
                                        Icons.download_outlined,
                                        size: 18.0,
                                      ),
                                      onPressed: () async{
                                        print("printtt---> HELLO");
                                        if (permissionstorage ==
                                            PermissionStatus
                                                .denied) {
                                          await PermissionHandler()
                                              .requestPermissions([
                                            PermissionGroup
                                                .storage
                                          ]);
                                        } else {
                                          print("printtt---> HELLO 1");
                                          String path = await ExtStorage.getExternalStoragePublicDirectory(
                                              ExtStorage.DIRECTORY_DOWNLOADS);
                                          String fullpath ="$path/EHC-tourdetail-$taskiddetail-$taskCategoryemp.pdf";
                                          print("printtt---> HELLO 2");
                                          DownloadPDF(
                                              dio,
                                              taskAttachmentspdf,
                                              fullpath);
                                        }
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(
                                              20.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 4.0, top: 10),
                              child: Text(
                                All_Lan().attachment+" :",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black87),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      snapshot.data.data.attechment.length,
                                  itemBuilder: (context, index) {
                                    var lastAttachmenttask =
                                        snapshot.data.data.attechment[index];
                                    var Attempname =
                                        lastAttachmenttask.empFirstname +
                                            lastAttachmenttask.emplastname;
                                    var message = lastAttachmenttask.message;
                                    var Atttaskid = lastAttachmenttask.id;
                                    var EmpFirstname =
                                        lastAttachmenttask.empFirstname;
                                    var date = lastAttachmenttask.createdDate
                                        .toString();
                                    var splitdate = date.split(" ");
                                    var createDate = splitdate[0];
                                    var path = lastAttachmenttask.path;
                                    var Attimageurl = All_API().baseurl_img +
                                        path +
                                        "/" +
                                        lastAttachmenttask.image;
                                    var AttPDFurl = All_API().baseurl_img +
                                        path +
                                        "/" +
                                        lastAttachmenttask.attachment;
                                    var AttPDF = lastAttachmenttask.attachment;
                                    var imaggee = lastAttachmenttask.image;
                                    return Card(
                                      elevation: 8.0,
                                      margin: new EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 6.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white54,
                                            // color: Color.fromRGBO(64, 75, 96, .9),
                                            border: Border.all(
                                              color:
                                                  kSecondaryLightColor, // red as border color
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 10),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      Attempname,
                                                      style: TextStyle(
                                                          color:
                                                              kSecondaryLightColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      'Date:' + createDate,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      message,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[400]),
                                                      maxLines: 2,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: imaggee == ""
                                                      ? GestureDetector(
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      "Download Attachment (PDF)",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        15.0,
                                                                  ),
                                                                ),
                                                                WidgetSpan(
                                                                  child:
                                                                      Container(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              1,
                                                                              1,
                                                                              5,
                                                                              0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.download_outlined,
                                                                            size:
                                                                                14,
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            //get mobilw dwnload path

                                                            if (permissionstorage ==
                                                                PermissionStatus
                                                                    .denied) {
                                                              await PermissionHandler()
                                                                  .requestPermissions([
                                                                PermissionGroup
                                                                    .storage
                                                              ]);
                                                            } else {
                                                              String path = await ExtStorage
                                                                  .getExternalStoragePublicDirectory(
                                                                      ExtStorage
                                                                          .DIRECTORY_DOWNLOADS);
                                                              String fullpath =
                                                                  "$path/EHC-$Atttaskid-$EmpFirstname.pdf";
                                                              DownloadPDF(
                                                                  dio,
                                                                  AttPDFurl,
                                                                  fullpath);
                                                            }
                                                          },
                                                        )
                                                      : GestureDetector(
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      "Download Attachment (Image)",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        15.0,
                                                                  ),
                                                                ),
                                                                WidgetSpan(
                                                                  child:
                                                                      Container(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              1,
                                                                              1,
                                                                              5,
                                                                              0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.download_outlined,
                                                                            size:
                                                                                14,
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () async {
                                                            if (permissionstorage ==
                                                                PermissionStatus
                                                                    .denied) {
                                                              await PermissionHandler()
                                                                  .requestPermissions([
                                                                PermissionGroup
                                                                    .storage
                                                              ]);
                                                            } else {
                                                              String path = await ExtStorage
                                                                  .getExternalStoragePublicDirectory(
                                                                      ExtStorage
                                                                          .DIRECTORY_DOWNLOADS);
                                                              String fullpath =
                                                                  "$path/EHC-$Atttaskid-$imaggee";
                                                              DownloadIMG(
                                                                  dio,
                                                                  Attimageurl,
                                                                  fullpath);
                                                            }
                                                          },
                                                        ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ),
                            snapshot.data.data.taskDetail.taskStatus ==
                                    "pending"
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: RaisedButton.icon(
                                      color: kSecondaryLightColor,
                                      label: Text(
                                        "Scan qr",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: kPrimaryColor),
                                      ),
                                      icon: Icon(
                                        Icons.qr_code,
                                        size: 13.0,
                                      ),
                                      onPressed: () {
                                        _scanQR();
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                    ),
                                  )
                                : snapshot.data.data.taskDetail.taskStatus ==
                                        "processing"
                                    ? Align(
                                        alignment: Alignment.bottomCenter,
                                        child: RaisedButton.icon(
                                          color: kSecondaryLightColor,
                                          label: Text(
                                            All_Lan().add_new_attachment,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: kPrimaryColor),
                                          ),
                                          icon: Icon(
                                            Icons.design_services,
                                            size: 18.0,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DocumentSaving(
                                                          savingTaskEmpid:
                                                              widget.empid,
                                                          savingTaskId:
                                                              widget.taskid,
                                                          savingAttachmentId:
                                                              attachmentno,
                                                        )));
                                          },
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      20.0)),
                                        ),
                                      )
                                    : Container()
                          ],
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
                },
              )),
        ],
      ),
    );
  }

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        barcoderesult = qrResult;
        chech_QRcode();
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          barcoderesult = "Camera permission was denied";
        });
      } else {
        setState(() {
          barcoderesult = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        barcoderesult = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        barcoderesult = "Unknown Error $ex";
      });
    }
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        sharedPreferences.setString(
            "lat", _currentPosition.latitude.toString());
        sharedPreferences.setString(
            "long", _currentPosition.longitude.toString());
      });

      // _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> getPermission() async {
    sharedPreferences = await SharedPreferences.getInstance();
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    permissionstorage = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    }

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.disabled:
        print('Disabled');
        break;
      case GeolocationStatus.restricted:
        print('Restricted');
        break;
      case GeolocationStatus.denied:
        print('Denied');
        break;
      case GeolocationStatus.unknown:
        print('Unknown');
        break;
      case GeolocationStatus.granted:
        print('Granted --> ');
        _getCurrentLocation();
        break;
    }
  }

  void chech_QRcode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      progress = true;
      // pr.show();
    });
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var scan_qrcode_url = All_API().baseurl + All_API().api_scan_qrcode;

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(scan_qrcode_url));
    latitude = sharedPreferences.getString("lat");
    longitude = sharedPreferences.getString("long");

    request.fields.addAll({
      'employee_id': widget.empid,
      'task_id': widget.taskid,
      'qr_code': barcoderesult,
      'latitude': latitude,
      'longitude': longitude,
    });

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    var jasonData = jsonDecode(response.body);
    String msg = jasonData['message'];

    try {
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BottomBar();
            },
          ),
        );
        setState(() {
          progress = false;
        });
        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(
          content: Text(
            msg,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      } else {
        setState(() {
          progress = false;
          FocusScope.of(context).requestFocus(focusNode);
          final snackBar = SnackBar(
            content: Text(
              msg,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } catch (e) {
      return e;
    }
  }

  Future<TaskDetailModel> gettaaskdetail() async {
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var taskdetail_url = All_API().baseurl + All_API().api_taskdetail;

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(taskdetail_url));
    request.fields
        .addAll({'task_id': widget.taskid, 'employee_id': widget.empid});

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    try {
      if (response.statusCode == 200) {
        var jasonData = jsonDecode(response.body);
        return TaskDetailModel.fromJson(jasonData);
      } else {}
    } catch (e) {
      return e;
    }
  }

  // ignore: non_constant_identifier_names
  void DownloadPDF(Dio dio, String attPDFurl, String fullpath) async {
    try {
      Response response = await dio.get(
        attPDFurl,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: true,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      FocusScope.of(context).requestFocus(focusNode);
      final snackBar = SnackBar(
        content: Text(
          "PDF is download,Check in download folder ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //write in download folder
      File file = File(fullpath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
    }
  }

  void DownloadIMG(Dio dio, String attIMGurl, String fullpath) async {
    try {
      Response response = await dio.get(
        attIMGurl,
        onReceiveProgress: showDownloadProgressIMG,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: true,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      FocusScope.of(context).requestFocus(focusNode);
      final snackBar = SnackBar(
        content: Text(
          "Image is download,Check in download folder ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //write in download folder
      File file = File(fullpath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
    }
  }

  void showDownloadProgress(int count, int total) {
    if (total != -1) {
      print((count / total * 100).toStringAsFixed(0) + "%");
    }
  }

  void showDownloadProgressIMG(int count, int total) {
    if (total != -1) {
      print((count / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
