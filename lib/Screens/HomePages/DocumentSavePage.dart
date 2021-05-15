import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/HomePages/home.dart';
import 'package:homecare/Screens/HomePages/tasklistDetail.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';
import 'package:homecare/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class DocumentSaving extends StatefulWidget {
  String savingTaskEmpid;
  String savingTaskId;
  int savingAttachmentId;

  DocumentSaving(
      {this.savingTaskEmpid, this.savingTaskId, this.savingAttachmentId});

  @override
  _DocumentSavingState createState() => _DocumentSavingState();
}

class _DocumentSavingState extends State<DocumentSaving> {
  FocusNode focusNode = new FocusNode();
  int selectedRadioTile;
  File uploadBILLimage;
  bool showselectdoc = false;
  bool loading = false;
  static TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading==true?Loading():SingleChildScrollView(
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
                      All_Lan().upload_date,
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
                          All_Lan().upload_documents+": ",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
              RadioListTile(
                value: 1,
                groupValue: selectedRadioTile,
                title: Text(All_Lan().gallery),
                subtitle: Text(All_Lan().want_to_upload_image),
                onChanged: (val) async {
                  setSelectedRadioTile(val);
                },
                activeColor: Colors.orange,
                selected: false,
              ),
              RadioListTile(
                value: 2,
                groupValue: selectedRadioTile,
                title: Text(All_Lan().camera),
                subtitle: Text(All_Lan().want_to_upload_picture),
                onChanged: (val) {
                  setSelectedRadioTile(val);
                },
                activeColor: Colors.orange,
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
                                selectGallery();
                              });
                            } else if (selectedRadioTile == 2) {
                              setState(() {
                                showselectdoc = false;
                                selectCamera();
                              });
                            } else {
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
                                All_Lan().select_gallery_or_camera,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                    labelText:All_Lan().message,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton.icon(
                        color: kSecondaryLightColor,
                        label: Text(
                          All_Lan().save,
                          style:
                              TextStyle(fontSize: 18.0, color: kPrimaryColor),
                        ),
                        icon: Icon(
                          Icons.design_services,
                          size: 18.0,
                        ),
                        onPressed: () {
                          if (formkey.currentState.validate()) {
                            if(uploadBILLimage==null){
                              FocusScope.of(context).requestFocus(focusNode);
                              final snackBar = SnackBar(
                                content: Text(
                                  All_Lan().select_gallery,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }else{
                              SaveDocimage();
                            }

                          }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton.icon(
                        color: kSecondaryLightColor,
                        label: Text(
                          All_Lan().completed,
                          style:
                              TextStyle(fontSize: 18.0, color: kPrimaryColor),
                        ),
                        icon: Icon(
                          Icons.design_services,
                          size: 18.0,
                        ),
                        onPressed: widget.savingAttachmentId==0? null: () {
                                alertDialog(context);
                              },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
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

  void alertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(
            All_Lan().are_you_sure_you_want_to_complete,
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
              child: Text(
                All_Lan().accept,
                style: TextStyle(color: Colors.orange, fontSize: 15),
              ),
              onPressed: () {
                completetask();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void SaveDocimage() async {
    setState(() {
      loading=true;

    });
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var saveDOC_url = All_API().baseurl + All_API().api_savedoc;
    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var taskmessage = messageController.text;
    var request = http.MultipartRequest('POST', Uri.parse(saveDOC_url));
    request.fields.addAll({
      'employee_id': widget.savingTaskEmpid,
      'task_id': widget.savingTaskId,
      'message': taskmessage,
    });
    request.files
        .add(await http.MultipartFile.fromPath('file', uploadBILLimage.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responsed = await http.Response.fromStream(response);
    var jasonData = jsonDecode(responsed.body);
    var msg = jasonData['message'];
    if (response.statusCode == 200) {
      messageController.clear();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TaskDetail(
                empid: widget.savingTaskEmpid,
                taskid: widget.savingTaskId,
              )));
      setState(() {
        loading = false;
        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(
          content: Text(
            msg,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // GetEmployeeProfileIMG();
      });
    } else {
      messageController.clear();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TaskDetail(
                empid: widget.savingTaskEmpid,
                taskid: widget.savingTaskId,
              )));
      setState(() {
        loading = false;
        FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(
          content: Text(
            msg,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // GetEmployeeProfileIMG();
      });
    }
  }

  void selectGallery() async {
    var imagepicker = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imagepicker != null) {
      setState(() {
        uploadBILLimage = imagepicker;
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select Bill Image !!')));
    }
  }

  void selectCamera() async {
    var imagepicker = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imagepicker != null) {
      setState(() {
        uploadBILLimage = imagepicker;
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select Bill Image !!')));
    }
  }

  void completetask() async {
    setState(() {
      loading=true;
    });
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var CompleteTask_url = All_API().baseurl + All_API().api_completed_task;

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(CompleteTask_url));
    request.fields.addAll({
      'employee_id': widget.savingTaskEmpid,
      'task_id': widget.savingTaskId
    });

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jasonData = jsonDecode(response.body);
    var msg = jasonData['message'];
    try {
      if (response.statusCode == 200) {
        setState(() {
          loading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskDetail(
                    empid: widget.savingTaskEmpid,
                    taskid: widget.savingTaskId,
                  )));
          FocusScope.of(context).requestFocus(focusNode);
          final snackBar = SnackBar(
            content: Text(
              msg,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // GetEmployeeProfileIMG();
        });
      } else {
        setState(() {
          loading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskDetail(
                    empid: widget.savingTaskEmpid,
                    taskid: widget.savingTaskId,
                  )));
          FocusScope.of(context).requestFocus(focusNode);
          final snackBar = SnackBar(
            content: Text(
              msg,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // GetEmployeeProfileIMG();
        });
      }
    } catch (e) {
      return e;
    }
  }
}
