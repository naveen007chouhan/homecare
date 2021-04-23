import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskDetail extends StatefulWidget {
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  bool _status = false;
  String barcoderesult = "Hey there !";
  static TextEditingController feedmsgController = TextEditingController();
  // File scannedDocument;
  File uploadPDFimage;
  File uploadBILLimage;
  bool progress =false;
  FocusNode focusNode = new FocusNode();
  bool isCameraPermissionAccepted;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  SharedPreferences sharedPreferences;
  String latitude;
  String longitude;
  @override
  void initState() {
    // checkCameraPermission();
    // ScannedImage.fromJson(
    //     '{rectangleCoordinates: {bottomLeft: {x: 133.0, y: 718.0}, bottomRight: {x: 439.0, y: 699.0}, topLeft: {x: 95.0, y: 106.0}, topRight: {x: 407.0, y: 93.0}}, croppedImage: file:///data/user/0/com.example.document_scanner_example/cache/documents/aad9bed5-68ea-4bb9-a7a2-13c57b38949f.jpg, width: 500, initialImage: file:///data/user/0/com.example.document_scanner_example/cache/documents/919a73f2-2590-4148-b0c7-212dcfffaf94.jpg, height: 888}');
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
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
                                  // "\$20",
                                  /*"\$" + lesson.price.toString()*/
                                  "Dead Line",
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
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      /*lesson.*/ "kjbvjbadkjvbkjbvkjadbv"
                        "VBAJKAv kjadb v"
                        "dva h dkd avhk dva"
                        "advjh avh ad da"
                        " hvhd v;hda v;adB kjABVKJCB"
                        "v hjd V;hd vhd "
                        "db vsdb naveebeebanawevbibavjnaveencajkjcajcAvASCHLhsvac''"
                        "ASVCiACAC'ivVCSiuvsbsabaSBASBacASCacsa ACJ lcA"
                        "A C A: as;kACS;ca ;aC  aKC hac ckaS"
                        "AHC ;A;hA  :KshuvcHvhA"
                        "ACLHcaHc ah h; A"
                        "ACLhbCbiCbicaBc:"
                        "iAIBlhBA"
                        "ICPiPipA"
                        "ACSBUIibS:"
                        "kjbvjbadkjvbkjbvkjadbv"
                        "VBAJKAv kjadb v"
                        "dva h dkd avhk dva"
                        "advjh avh ad da"
                        " hvhd v;hda v;adB kjABVKJCB"
                        "v hjd V;hd vhd "
                        "db vsdb naveebeebanawevbibavjnaveencajkjcajcAvASCHLhsvac''"
                        "ASVCiACAC'ivVCSiuvsbsabaSBASBacASCacsa ACJ lcA"
                        "A C A: as;kACS;ca ;aC  aKC hac ckaS"
                        "AHC ;A;hA  :KshuvcHvhA",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),

                  !_status
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 45.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                height: 45.0,
                                // padding: EdgeInsets.only(left: 10.0),
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
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    /*Container(
                              height: 45.0,
                              // padding: EdgeInsets.only(left: 10.0),
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
                            ),*/
                                    Container(
                                      height: 45.0,
                                      // padding: EdgeInsets.only(left: 10.0),
                                      child: RaisedButton.icon(
                                        color: kPrimaryColor,
                                        label: Text(
                                          'Upload Bill',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: kSecondaryLightColor),
                                        ),
                                        icon: Icon(
                                          Icons.camera_alt,
                                          size: 13.0,
                                          color: kSecondaryLightColor,
                                        ),
                                        onPressed: () async {
                                          _scanBillDoc();
                                        },
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    20.0)),
                                      ),
                                    ),
                                    Container(
                                      height: 45.0,
                                      // padding: EdgeInsets.only(left: 10.0),
                                      child: RaisedButton.icon(
                                        color: kSecondaryLightColor,
                                        label: Text(
                                          'Upload PDF',
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                        icon: Icon(
                                          Icons.picture_as_pdf,
                                          size: 13.0,
                                        ),
                                        onPressed: () {
                                          _scanPDF();
                                        },
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    20.0)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                /* Container(
                                height: 45.0,
                                // padding: EdgeInsets.only(left: 10.0),
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
                              ),*/
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextFieldContainer(
                                        child: TextFormField(
                                          controller: feedmsgController,
                                          maxLines: 1,
                                          validator: ((value) {
                                            if (value.isEmpty) {
                                              return "Field Required!!";
                                            }
                                            return null;
                                          }),
                                          cursorColor: kSecondaryLightColor,
                                          decoration: InputDecoration(

                                            icon: Icon(
                                              Icons.message,
                                              color: kSecondaryLightColor,
                                            ),
                                            // hintText: "First Name",
                                            border: InputBorder.none,
                                            // border: OutlineInputBorder(
                                            //   borderRadius: BorderRadius.circular(0),
                                            // ),
                                            labelText: "Message",

                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                          color: Colors.blue[1000]
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          //addMessage();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.send,
                                            size: 20,
                                            color: kSecondaryLightColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        barcoderesult = qrResult;
        print("barcode-->"+barcoderesult);
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
        sharedPreferences.setString("lat", _currentPosition.latitude.toString());
        sharedPreferences.setString("long", _currentPosition.longitude.toString());
      });

      // _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
  Future<void> getPermission() async{
    sharedPreferences=await SharedPreferences.getInstance();
    PermissionStatus permission=await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if(permission==PermissionStatus.denied)
    {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator=Geolocator();

    GeolocationStatus geolocationStatus=await geolocator.checkGeolocationPermissionStatus();

    switch(geolocationStatus)
    {
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
// void _clickbillDoc() async{
//   isCameraPermissionAccepted == null
//       ? Center(
//     child: CircularProgressIndicator(),
//   )
//       : isCameraPermissionAccepted
//       ? Stack(
//     children: <Widget>[
//       Column(
//         children: <Widget>[
//           Expanded(
//             child: scannedDocument != null
//                 ? Image(
//               image: FileImage(scannedDocument),
//             )
//                 : DocumentScanner(
//               onDocumentScanned:
//                   (ScannedImage scannedImage) {
//                 print("document : " +
//                     scannedImage.croppedImage);
//
//                 setState(() {
//                   scannedDocument = scannedImage
//                       .getScannedDocumentAsFile();
//                   // imageLocation = image;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//       scannedDocument != null
//           ? Positioned(
//         bottom: 20,
//         left: 0,
//         right: 0,
//         child: RaisedButton(
//             child: Text("retry"),
//             onPressed: () {
//               setState(() {
//                 scannedDocument = null;
//               });
//             }),
//       )
//           : Container(),
//     ],
//   )
//       : Center(
//     child: Text("camera permission denied"),
//   ),
// }
// checkCameraPermission() async {
//   PermissionStatus cameraPermission = await Permission.camera.request();
//
//   isCameraPermissionAccepted = cameraPermission.isGranted;
//
//   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//     setState(() {});
//   });
// }
/*Widget _getQrCode() {
    return new
  }*/

  void chech_QRcode() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      progress=true;
      // pr.show();

    });
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("log_basicAuth--> "+basicAuth);

    var scan_qrcode_url= All_API().baseurl+All_API().api_scan_qrcode;
    print("scan_qrcode_url -->" +scan_qrcode_url);

    /*var body=jsonEncode({"firstname":fname,"lastname":lname,"email_id":email,"password":pass,"mobile_no":phn,"company_code":compcode});*/

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(scan_qrcode_url));
    latitude=sharedPreferences.getString("lat");
    longitude=sharedPreferences.getString("long");
    print("taskdetail_lat_long--> " + latitude+" "+longitude);
    request.fields.addAll({

      'employee_id': "5",
      'task_id': '2',
      'qr_code': barcoderesult,
      'latitude': latitude,
      'longitude': longitude,
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

        setState(() {
          // pr.hide();
          progress=false;
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
        final snackBar = SnackBar(content: Text(msg,style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      }else{
        setState(() {
          // pr.hide();
          progress=false;
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


