import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/MessagingPages/chat_screen.dart';
import 'package:homecare/Screens/MessagingPages/models/GetChatListEmployeeModel.dart';
import 'package:homecare/Screens/MessagingPages/models/message_model.dart';
import 'package:homecare/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class MessagingScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<MessagingScreen> {
  FocusNode focusNode = new FocusNode();
  String employeeId;
  String companyId;

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
      GetChatList(companyId);
    });
    // GetEmployeeProfile(employeeId);
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
          'Chat',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        /*actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          ),
        ],*/
      ),
      body: FutureBuilder<GetChatListEmployeeModel>(
        future:GetChatList(companyId),
        // ignore: missing_return
        builder: (context,snapshot){
            switch (snapshot.connectionState) {
            case ConnectionState.none:
            return Text('Some error Found');
            case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            return Text('Data Fill');
            case ConnectionState.done:
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    // final Message chat = chats[index];
                    var chatlistdata=snapshot.data.data[index];
                    var empname = chatlistdata.employeeFirstname+" "+chatlistdata.employeeLastname;
                    var empprofile = All_API().baseurl_img+chatlistdata.employeePath+"/"+chatlistdata.employeeProfile;
                    var Empid =chatlistdata.empId;
                    return Empid!=employeeId?GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            user: empname,EmpId: Empid,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                                // shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                                  /*: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),*/
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(empprofile==All_API().baseurl_img_error?
                                All_API().baseurl_img_default
                                    :empprofile),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            empname,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          /*chat.sender.isOnline
                                              ? Container(
                                            margin: const EdgeInsets.only(left: 5),
                                            width: 7,
                                            height: 7,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          )
                                              : Container(
                                            child: null,
                                          ),*/
                                        ],
                                      ),
                                      /*Text(
                                        chat.time,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black54,
                                        ),
                                      ),*/
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  /*Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      chat.text,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ):Container();
                  },
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
    );
  }
  Future<GetChatListEmployeeModel>GetChatList(String Compid) async{
    var ChatList_url = All_API().baseurl + All_API().api_employeeBycompany+"/"+Compid;
    print("ChatList_url -->" + ChatList_url);
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("ChatList_basicAuth--> " + basicAuth);
    var headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('GET', Uri.parse(ChatList_url));
    /*request.fields.addAll({
      'employee_id': emplyID,

    });*/

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseded = await http.Response.fromStream(response);
    print("ChatList_get_response -->" +responseded.body.toString());

    final  jasonData = jsonDecode(responseded.body.toString());

    var  msg=jasonData['message'];
    print("ChatList_get_msg -->" +msg);
    if (response.statusCode == 200) {

      // FocusScope.of(context).requestFocus(focusNode);
      // final snackBar = SnackBar(content: Text('$msg Update ',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.green,);
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return GetChatListEmployeeModel.fromJson(jasonData);


    }
    else {
      print(response.reasonPhrase);
      // FocusScope.of(context).requestFocus(focusNode);
      // final snackBar = SnackBar(content: Text('$msg Not Update ',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.red,);
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
