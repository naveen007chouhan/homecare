import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

class DocumentSaving extends StatefulWidget {
  String savingTaskEmpid;
  String savingTaskId;
  DocumentSaving({this.savingTaskEmpid, this.savingTaskId});

  @override
  _DocumentSavingState createState() => _DocumentSavingState();
}

class _DocumentSavingState extends State<DocumentSaving> {
// Declare this variable
  FocusNode focusNode = new FocusNode();
  int selectedRadioTile;
  // File uploadPDFimage;
  File uploadBILLimage;
  bool showselectdoc = false;
  var docu;
  static TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
    // setExtension();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  setExtension() {
    docu = uploadBILLimage.path;
    final extension = p.extension(docu);
    print("Extention----->" + extension);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                    child: Text(
                      "Upload Data",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        " Upload Document : ",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
              RadioListTile(
                value: 1,
                groupValue: selectedRadioTile,
                title: Text("PDF"),
                subtitle: Text("Want to upload pdf"),
                onChanged: (val) async {
                  print("Radio Tile pressed $val");
                  setSelectedRadioTile(val);
                  // File pickedFile = await FilePicker.getFile(
                  //     allowedExtensions: ['pdf'], type: FileType.custom);
                  // setState(() {
                  //   uploadBILLimage = pickedFile;
                  // });
                },
                activeColor: Colors.orange,
                /*secondary: OutlineButton(
                  // child: Text("Say Hi"),
                  onPressed: () {
                    print("Say PDF");
                  },
                ),*/
                selected: false,
              ),
              RadioListTile(
                value: 2,
                groupValue: selectedRadioTile,
                title: Text("Camera"),
                subtitle: Text("Want to upload picture"),
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  setSelectedRadioTile(val);
                },
                activeColor: Colors.orange,
                /*secondary: OutlineButton(
              // child: Text("Say Hi"),
              onPressed: () {
                print("Say Camera");
              },
            ),*/
                selected: false,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new IconButton(
                          // Bitcoin
                          icon: new Icon(
                            Icons.add,
                            size: 20,
                            color: kSecondaryColor,
                          ),
                          onPressed: () {
                            if (selectedRadioTile == 1) {
                              setState(() {
                                showselectdoc = false;
                                selectPDF();
                              });
                            } else if (selectedRadioTile == 2) {
                              setState(() {
                                showselectdoc = false;
                                selectCamera();
                              });
                            } else {
                              print("HELLO-->");
                              setState(() {
                                showselectdoc = true;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    showselectdoc == true
                        ? Container(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Text(
                                "Select PDF OR Camera First",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400),
                              ),
                            ))
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    showselectdoc == false
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: uploadBILLimage != null
                                      ? PDF.file(
                                          uploadBILLimage,
                                          height: 150,
                                          width: 150,
                                        )
                                      : Text("Select PDF"),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    child: CircleAvatar(
                                      backgroundImage: uploadBILLimage == null
                                          ? NetworkImage(
                                              'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                          : FileImage(
                                              File(uploadBILLimage.path)),
                                      radius: 50.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Row(),
                  ],
                ),
              ),
              TextFieldContainer(
                child: TextFormField(
                  controller: messageController,
                  validator: ((value) {
                    if (value.isEmpty) {
                      return "Field Required!!";
                    }
                    return null;
                  }),
                  cursorColor: kSecondaryLightColor,
                  maxLines: 5,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.message,
                      color: kSecondaryLightColor,
                    ),
                    labelText: "Message",
                    // labelText: "First Name",
                    border: InputBorder.none,

                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton.icon(
                        color: kSecondaryLightColor,
                        label: Text(
                          'Save',

                          style: TextStyle(
                              fontSize: 18.0, color: kPrimaryColor),
                        ),
                        icon: Icon(
                          Icons.design_services,
                          size: 18.0,
                        ),
                        onPressed: () {
                          SaveDocimage();
                          // print("taskid & Empid For Doc Saving-->" + widget.empid+" == "+widget.taskid );
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentSaving(savingTaskEmpid: widget.empid,savingTaskId: widget.taskid,)
                              )
                          );*/
                          /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectTaskUpload(),
                          )
                      );*/
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius:
                            new BorderRadius.circular(20.0)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton.icon(
                        color: kSecondaryLightColor,
                        label: Text(
                          'Compeleted',
                          style: TextStyle(
                              fontSize: 18.0, color: kPrimaryColor),
                        ),
                        icon: Icon(
                          Icons.design_services,
                          size: 18.0,
                        ),
                        onPressed: () {
                          // print("taskid & Empid For Doc Saving-->" + widget.empid+" == "+widget.taskid );
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentSaving(savingTaskEmpid: widget.empid,savingTaskId: widget.taskid,)
                              )
                          );*/
                          /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectTaskUpload(),
                          )
                      );*/
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius:
                            new BorderRadius.circular(20.0)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );



  }
  void SaveDocimage() async{
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("taskdetail_basicAuth--> " + basicAuth);
    var saveDOC_url = All_API().baseurl + All_API().api_savedoc;
    print("saveDOC_url_url -->" + saveDOC_url);
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var taskmessage = messageController.text;
    var request = http.MultipartRequest('POST', Uri.parse(saveDOC_url));
    request.fields.addAll({
      'employee_id': widget.savingTaskEmpid,
      'task_id': widget.savingTaskId,
      'message':taskmessage,
    });
    request.files.add(await http.MultipartFile.fromPath('file', uploadBILLimage.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("Upload Document----->"+await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print("Upload Document----->"+await response.stream.bytesToString());
      FocusScope.of(context).requestFocus(focusNode);
      final snackBar = SnackBar(content: Text('Data Saved  ',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else {
      print("Error---->"+response.reasonPhrase);
      FocusScope.of(context).requestFocus(focusNode);
      final snackBar = SnackBar(content: Text('Data Not Saved   ',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  void selectPDF() async {
    File pickedFile = await FilePicker.getFile(
        allowedExtensions: ['pdf'], type: FileType.custom);

    setState(() {
      uploadBILLimage = pickedFile;
      // setExtension();
      print("uploadBILLimage" + uploadBILLimage.path);
    });
    /*var imagepicker = await ImagePicker.pickImage(source: ImageSource.gallery);
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
    }*/
  }

  void selectCamera() async {
    var imagepicker = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imagepicker != null) {
      setState(() {
        print("Bill_imagepicker--> " + imagepicker.path);
        uploadBILLimage = imagepicker;
        print("uploadBILLimage" + uploadBILLimage.path);
        //startUploading(uploadimage);
        // profileUpload(uploadimage, context);
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select Bill Image !!')));
    }
  }

}


