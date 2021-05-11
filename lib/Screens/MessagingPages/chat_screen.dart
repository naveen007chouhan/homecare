import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/MessagingPages/models/FetchChatDataListModel.dart';
import 'package:homecare/Screens/MessagingPages/models/SendChatDataModel.dart';
import 'package:homecare/Screens/MessagingPages/models/message_model.dart';
import 'package:homecare/Screens/MessagingPages/models/user_model.dart';
import 'package:homecare/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ChatScreen extends StatefulWidget {
  String user;
  String EmpId;

  ChatScreen({this.user,this.EmpId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  FocusNode focusNode = new FocusNode();
  String employeeId;
  String companyId;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController sendtextEditingController=TextEditingController() ;
  File uploadMessageimage;
  List chatlist= new List();
  ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }
  void insertSingleItem() {

    scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut
    );
  }
  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      employeeId = sharedPreferences.getString("employeeId");
      companyId = sharedPreferences.getString("companyId");
      FetchChatDataList(employeeId);
    });
    // GetEmployeeProfile(employeeId);
  }
  _chatBubble(fetchlist, bool isMe, bool isSameUser) {
    if (isMe) {
      return Wrap(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: kSecondaryLightColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                fetchlist,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "2:30 pm",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(All_API().baseurl_img_default),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Wrap(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                fetchlist,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(All_API().baseurl_img_default),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "8:00AM",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Form(
        key:formkey ,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              iconSize: 25,
              color: kSecondaryLightColor,
              onPressed: () {
                selectCamera();
              },
            ),
            Expanded(
              child: TextFormField(
                controller: sendtextEditingController,
                cursorColor: kSecondaryLightColor,
                validator: ((value) {
                  if (value.isEmpty) {
                    return "Not Send Empty Text";
                  }
                  return null;
                }),
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message..',
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: 25,
              color: kSecondaryLightColor,
              onPressed: () {
                if (formkey.currentState.validate()){
                  var Sendmsg = sendtextEditingController.text;
                  SendChatData(employeeId,Sendmsg);
                }
              },
            ),
            Container(width: 5),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int prevUserId;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: kSecondaryLightColor,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: widget.user,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              /*TextSpan(text: '\n'),
              widget.user.isOnline ?
              TextSpan(
                text: 'Online',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )
              :
              TextSpan(
                text: 'Offline',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )*/
            ],
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        width: double.infinity, height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                           reverse: false,
                          shrinkWrap: true,
                          // padding: EdgeInsets.all(20),
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          itemCount: chatlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            // final Message message = messages[index];
                            final bool isMe = chatlist[index]['fromId'] == employeeId;
                            final bool isSameUser = chatlist[index]['toId'] == widget.EmpId;
                            // prevUserId = message.sender.id;
                            return _chatBubble(chatlist[index]['message'], isMe, isSameUser);
                          },
                        ),


            ),
            _sendMessageArea(),
          ],
        ),
      ),
    );
  }
  Future<List<FetchChatDataListModel>> FetchChatDataList(String senderEmpID) async{
    var FetchChatDataList_url = All_API().baseurl + All_API().api_FetchChatData;
    print("FetchChatDataList_url -->" + FetchChatDataList_url);
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("FetchChatDataList_basicAuth--> " + basicAuth);
    var headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(FetchChatDataList_url));
    print("Sender ID---> "+senderEmpID);
    print("Reciver ID---> "+widget.EmpId + " --<>-- "+widget.user);
    var sender ="1";
    var reciver ="2";
    request.fields.addAll({
      'sender': senderEmpID,
      'receiver': widget.EmpId,
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseded = await http.Response.fromStream(response);
    print("FetchChatDataList_get_response -->" +responseded.body.toString());



    try{
      if (response.statusCode == 200) {
        Map  jasonData = jsonDecode(responseded.body);

        setState(() {
          chatlist=jasonData['data'];
          chatlist.forEach((element) {
            print("-----&&------>"+element['toId']);
          });
        });




      }
      else {
        print(response.reasonPhrase);
        // FocusScope.of(context).requestFocus(focusNode);
        // final snackBar = SnackBar(content: Text('$msg Not Update ',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      print( "Exception: --> "+e);
      return e;
    }

  }
  Future<SendChatDataModel>SendChatData(String senderEmpID,String msgss) async{
    sendtextEditingController.clear();
    var SendChatData_url = All_API().baseurl + All_API().api_SendChatData;
    print("SendChatData_url -->" + SendChatData_url);
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("SendChatData_basicAuth--> " + basicAuth);
    var headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };

    print("SendChatData_Sender ID---> "+senderEmpID);
    print("SendChatData_Reciver ID---> "+widget.EmpId + " --<>-- "+widget.user);
    var reciverEMPID=widget.EmpId;
    var sender ="1";
    var reciver ="2";
    var request = http.MultipartRequest('POST', Uri.parse(SendChatData_url));
    request.fields.addAll({
      'sender': senderEmpID,
      'receiver': widget.EmpId,
      'message': msgss,
    });

    print("----------->"+uploadMessageimage.toString());

    if(uploadMessageimage!=null){

      print("if ----------->"+uploadMessageimage.toString());
      final file = await http.MultipartFile.fromPath('attachment', uploadMessageimage.path);
      print("file---> : " + file.filename );
      request.files.add(file);

    }else{
      print("else ----------->"+uploadMessageimage.toString());
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseded = await http.Response.fromStream(response);
    print("SendChatData_get_response -->" +responseded.body);

    final  jasonData = jsonDecode(responseded.body);

    var  msg=jasonData['message'];
    print("SendChatData_get_msg -->" +msg);
    try{
      if (response.statusCode == 200) {
        insertSingleItem();
        // FocusScope.of(context).requestFocus(focusNode);
        // final snackBar = SnackBar(content: Text('$msg Update ',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        FetchChatDataList(employeeId);
        return SendChatDataModel.fromJson(jasonData);


      }
      else {
        print(response.reasonPhrase);
        // FocusScope.of(context).requestFocus(focusNode);
        // final snackBar = SnackBar(content: Text('$msg Not Update ',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e){
      print( "Exception: --> "+e);
      return e;
    }

  }
  void selectCamera() async {
    var imagepicker = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imagepicker != null) {
      setState(() {
        print("Bill_imagepicker--> " + imagepicker.path);
        uploadMessageimage = imagepicker;
        print("uploadMessageimage" + uploadMessageimage.path);
        //startUploading(uploadimage);
        // profileUpload(uploadimage, context);
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select Bill Image !!')));
    }
  }


}
