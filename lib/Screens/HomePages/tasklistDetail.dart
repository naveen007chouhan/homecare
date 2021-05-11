import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/HomePages/DocumentSavePage.dart';
import 'package:homecare/Screens/HomePages/HomeModel/TaskDetailModel.dart';
import 'package:homecare/Screens/HomePages/taskdetail.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskDetail extends StatefulWidget {

  String taskid;
  String empid;
  TaskDetail(
      {this.taskid,
      this.empid});
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  Future<TaskDetailModel> taskdetaill;
  bool _status = false;
  String barcoderesult = "Hey there !";
  static TextEditingController feedmsgController = TextEditingController();
  // File scannedDocument;
  File uploadPDFimage;
  File uploadBILLimage;
  bool progress = false;
  FocusNode focusNode = new FocusNode();
  bool isCameraPermissionAccepted;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  SharedPreferences sharedPreferences;
  String latitude;
  String longitude;

  String status;
  String deadlinedate;
  String createdate;
  String clientname;
  String clientmob;
  String taskcat;
  String taskmode;
  String taskdes;
  String taskaddress;
  @override
  void initState() {
    // checkCameraPermission();
    // ScannedImage.fromJson(
    //     '{rectangleCoordinates: {bottomLeft: {x: 133.0, y: 718.0}, bottomRight: {x: 439.0, y: 699.0}, topLeft: {x: 95.0, y: 106.0}, topRight: {x: 407.0, y: 93.0}}, croppedImage: file:///data/user/0/com.example.document_scanner_example/cache/documents/aad9bed5-68ea-4bb9-a7a2-13c57b38949f.jpg, width: 500, initialImage: file:///data/user/0/com.example.document_scanner_example/cache/documents/919a73f2-2590-4148-b0c7-212dcfffaf94.jpg, height: 888}');
    super.initState();

    getPermission();
    // gettaaskdetail();
    taskdetaill=gettaaskdetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Tour Detail',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[

          /*IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () {
              // showAlertDialog(context);
            },
          ),*/
        ],
      ),
      body: Stack(
        children: <Widget>[

          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            child: FutureBuilder <TaskDetailModel>(
              future: taskdetaill,
                // ignore: missing_return
                builder: (context, snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('none');
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                      return Text('');
                    case ConnectionState.done:
                if(snapshot.hasData){
                  var deaddatetime = snapshot.data.data.taskDetail.deadlineDate.toString();
                  var crdatetime = snapshot.data.data.taskDetail.assignedDate.toString();
                  var creat = crdatetime.split(" ");
                  var crdate = deaddatetime.split(" ");
                  createdate =creat[0];
                  deadlinedate =crdate[0];
                  var tourimg = All_API().baseurl_img+snapshot.data.data.taskDetail.taskpath+snapshot.data.data.taskDetail.taskImage;
                  var defaultimg = All_API().baseurl_img+snapshot.data.data.taskDetail.taskImage;
                  var omgtaskmode =snapshot.data.data.taskDetail.taskImagemode;
                  print("datealot-->" + tourimg );
                  print("datealot-->" + defaultimg);
                  print("datealot-->" + omgtaskmode.toString());
                  print("datealot-->" + omgtaskmode.toString());
                  // status =snapshot.data.data.taskDetail.taskStatus;
                  // createdate= snapshot.data.data.taskDetail.
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
                                  image:omgtaskmode==0? NetworkImage(defaultimg):NetworkImage(tourimg),
                                  fit: BoxFit.cover,
                                ),
                              )),

                          Positioned(
                            top: 15,
                            left: 20.0,
                            child: Container(
                              color: Colors.green,
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                snapshot.data.data.taskDetail.taskStatus==null?"status":snapshot.data.data.taskDetail.taskStatus,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            right: 20.0,
                            child: Container(
                              color: Colors.blue,
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                snapshot.data.data.taskDetail.taskModeName==null?"status":snapshot.data.data.taskDetail.taskModeName,
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
                                  color: Colors.white, fontWeight: FontWeight.bold),
                              backgroundColor: Colors.orange,
                              label: Text("Date :" + createdate==null?"":createdate),
                            ),
                          ),
                          Positioned(
                            right: 5.0,
                            bottom: 0,
                            child: Chip(
                              elevation: 0,
                              labelStyle: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                              backgroundColor: Colors.orange,
                              label: Text("Deadline :" + deadlinedate==null?" ":deadlinedate),
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
                                  padding:
                                  const EdgeInsets.only(left: 6.0, bottom: 4.0),
                                  child: Text(
                                    snapshot.data.data.taskDetail.taskName==null?"":snapshot.data.data.taskDetail.taskName,
                                    style: TextStyle(fontSize: 25,color: Colors.black54,fontWeight: FontWeight.w400),
                                  ),
                                )),

                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0,top: 10),
                              child: Text(
                                "Basic Detail",
                                style: TextStyle(fontSize: 18,color: Colors.black87),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 6.0, bottom: 4.0,top: 10),
                              child: Text(
                                snapshot.data.data.taskDetail.taskCategory==null?"":"Category: "+snapshot.data.data.taskDetail.taskCategory,
                                style: TextStyle(fontSize: 16,color: Colors.black87,fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(height: 10.0),
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
                                    text: snapshot.data.data.taskDetail.clientName==null?"":snapshot.data.data.taskDetail.clientName,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                    ),
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
                                      padding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                                      child: Icon(Icons.phone, size: 14,color:Colors.grey ,),
                                    ),
                                  ),
                                  TextSpan(
                                    text: snapshot.data.data.taskDetail.clientMobile==null?"":snapshot.data.data.taskDetail.clientMobile,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                    ),
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
                                        padding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                                        child:Icon(Icons.email, size: 14,color:Colors.grey ,)),

                                  ),

                                  TextSpan(
                                    text: snapshot.data.data.taskDetail.clientEmail==null?"":snapshot.data.data.taskDetail.clientEmail,

                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),


                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                              child: Text(
                                "Description",
                                style: TextStyle(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                              child: snapshot.data.data.taskDetail.message==null? Text(
                                "Plumbing reached its early apex in ancient Rome, which saw the introduction of expansive systems of aqueducts, tile wastewater removal, and widespread use of lead pipes. The Romans used lead pipe inscriptions to prevent water theft. With the Fall of Rome both water supply and sanitation stagnated—or regressed—for well over 1,000 years. Improvement was very slow, with little effective progress made until the growth of modern densely populated cities in the 1800s. During this period, public health authorities began pressing for better waste disposal systems to be installed, to prevent or control epidemics of disease. ",
                                style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey),)
                                  :Text(snapshot.data.data.taskDetail.message,style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey)),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                              child: Text(
                                  snapshot.data.data.taskDetail.address==null?"":"Address : "+snapshot.data.data.taskDetail.address,
                                  style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black54)
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                              child: Text(
                                  snapshot.data.data.taskDetail.countryName==null?"":"Country : "+snapshot.data.data.taskDetail.countryName,
                                  style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black54)
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                              child: Text(
                                  snapshot.data.data.taskDetail.stateName==null?"":"State : "+snapshot.data.data.taskDetail.stateName,
                                  style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black54)
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                              child: Text(
                                  snapshot.data.data.taskDetail.cityName==null?"":"City : "+snapshot.data.data.taskDetail.cityName,
                                  style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black54)
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                              child: Text(
                                "Attachment : ",
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.data.attechment.length,
                            itemBuilder: (context,index){
                              var lastAttachmenttask = snapshot.data.data.attechment[index];
                              var Attempname=lastAttachmenttask.empFirstname+lastAttachmenttask.emplastname;
                              var message =lastAttachmenttask.message;
                              var date=lastAttachmenttask.createdDate.toString();
                              var splitdate=date.split(" ");
                              var createDate =splitdate[0];
                              var path = lastAttachmenttask.path;
                              var Attimage=All_API().baseurl_img+path+lastAttachmenttask.image;
                              var imaggee= lastAttachmenttask.image;
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                Attempname,
                                                style: TextStyle(color: kSecondaryLightColor, fontWeight: FontWeight.bold),
                                              ),
                                              Spacer(),
                                              Text(
                                                'Date:'+createDate,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14.0,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                          child: Row(
                                            children: <Widget>[
                                              Text(message, style: TextStyle(color: Colors.grey[400]),maxLines: 2,)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Download Attachment",

                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15.0,

                                                    ),
                                                  ),
                                                  WidgetSpan(
                                                    child: Container(
                                                        padding: const EdgeInsets.fromLTRB(1, 1, 5, 0),
                                                        child:Icon(Icons.download_outlined, size: 14,color:Colors.grey ,)),

                                                  ),


                                                ],
                                              ),
                                            ),
                                          ),
                                        ),


                                      ],
                                    )
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      snapshot.data.data.taskDetail.taskStatus =="pending"?Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton.icon(
                          color: kSecondaryLightColor,
                          label: Text(
                            'Scan QR',
                            style: TextStyle(
                                fontSize: 13.0, color: kPrimaryColor),
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
                      ):Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton.icon(
                          color: kSecondaryLightColor,
                          label: Text(
                            'Add New Attachment',
                            style: TextStyle(
                                fontSize: 18.0, color: kPrimaryColor),
                          ),
                          icon: Icon(
                            Icons.design_services,
                            size: 18.0,
                          ),
                          onPressed: () {
                            print("taskid & Empid For Doc Saving-->" + widget.empid+" == "+widget.taskid );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DocumentSaving(savingTaskEmpid: widget.empid,savingTaskId: widget.taskid,)
                                )
                            );

                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(20.0)),
                        ),
                      )
                    ],


                  );
                }else{
                  return Center(
                    child: Card(
                      color: Colors.blue[1000],
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "No Detail Found",
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
            )
          ),

        ],
      ),
    );
  }

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        barcoderesult = qrResult;
        print("barcode-->" + barcoderesult);
        chech_QRcode();
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          barcoderesult = "Camera permission was denied";
          print(barcoderesult);
        });
      } else {
        setState(() {
          barcoderesult = "Unknown Error $ex";
          print(barcoderesult);
        });
      }
    } on FormatException {
      setState(() {
        barcoderesult = "You pressed the back button before scanning anything";
        print(barcoderesult);
      });
    } catch (ex) {
      setState(() {
        barcoderesult = "Unknown Error $ex";
        print(barcoderesult);
      });
    }
  }

  void _scanPDF() async {
    var imagepicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imagepicker != null) {
      setState(() {
        print("PDF_imagepicker--> " + imagepicker.path);
        uploadBILLimage = imagepicker;
        //startUploading(uploadimage);
        // profileUpload(uploadimage, context);
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select Bill Image !!')));
    }
  }

  void _scanBillDoc() async {
    var imagepicker = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imagepicker != null) {
      setState(() {
        print("Bill_imagepicker--> " + imagepicker.path);
        uploadBILLimage = imagepicker;
        //startUploading(uploadimage);
        // profileUpload(uploadimage, context);
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select Bill Image !!')));
    }
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        //print("Position : "+_currentPosition.toString());
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

    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
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
    print("log_basicAuth--> " + basicAuth);

    var scan_qrcode_url = All_API().baseurl + All_API().api_scan_qrcode;
    print("scan_qrcode_url -->" + scan_qrcode_url);

    /*var body=jsonEncode({"firstname":fname,"lastname":lname,"email_id":email,"password":pass,"mobile_no":phn,"company_code":compcode});*/

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(scan_qrcode_url));
    latitude = sharedPreferences.getString("lat");
    longitude = sharedPreferences.getString("long");
    print("taskdetail_lat_long--> " +
        widget.empid +
        " " +
        widget.taskid +
        " " +
        barcoderesult +
        " " +
        latitude +
        " " +
        longitude);
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
    print("scanner_body_response -->" + response.body);

    var jasonData = jsonDecode(response.body);
    String msg = jasonData['message'];
    print("scanner_MSG--> " + msg);
    // print("log_statuscode_response -->" +jasonData.statusCode);

    // final Map<String, String> jasonData = jsonDecode(response.body);
    // String msg=jasonData['error'];
    // print("MSG--> "+ msg );
    try {
      if (response.statusCode == 200) {
        var jasonData = jsonDecode(response.body);

        setState(() {
          // pr.hide();
          progress = false;
          _status = true;
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return BottomBar();
          //     },
          //   ),
          // );
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
          // pr.hide();
          progress = false;
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BottomBar();
              },
            ),
          );*/
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

  Future<TaskDetailModel> gettaaskdetail()async{
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("taskdetail_basicAuth--> " + basicAuth);
    var taskdetail_url = All_API().baseurl + All_API().api_taskdetail;
    print("taskdetail_url -->" + taskdetail_url);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(taskdetail_url));

    print("taskdetail_taskID--> " +
        widget.taskid );
    request.fields.addAll({

      'task_id': widget.taskid,

    });

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("TASKDETAIL_body_response -->" + response.body);

    try {
      if (response.statusCode == 200) {
        var jasonData = jsonDecode(response.body);
        return TaskDetailModel.fromJson(jasonData);
        // status = taskdetail.data.taskDetail.taskStatus;
        // deadlinedate = taskdetail.data.taskDetail.deadlineDate.toString();
        // var crdatetime = taskdetail.data.taskDetail.assignedDate.toString();
        // clientname = taskdetail.data.taskDetail.clientName;
        // clientmob = taskdetail.data.taskDetail.clientMobile;
        // taskcat = taskdetail.data.taskDetail.taskCategory;
        // taskmode = taskdetail.data.taskDetail.taskModeName;
        // taskdes = taskdetail.data.taskDetail.message;
        // taskaddress = taskdetail.data.taskDetail.address;
        // var creat = crdatetime.split(" ");
        // createdate =creat[0];



      } else {

      }
    } catch (e) {
      return e;
    }
  }
}
