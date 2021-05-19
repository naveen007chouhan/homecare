import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/ClientPages/Model/ClientlistModel.dart';
import 'package:homecare/Screens/HistoryTask/HistoryTaskList.dart';
import 'package:homecare/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ClientDetail extends StatefulWidget {
  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientDetail> {
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
      print("HistoryemployeeId -> " + employeeId);
      clientlist();
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       backgroundColor: kSecondaryLightColor,
       elevation: 8,
       title: Text(
         All_Lan().client_area,
         style: TextStyle(
           color: Colors.white,
         ),
       ),
     ),
     body: FutureBuilder<ClientListModel>(
       future:clientlist(),
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
                   var chatlistdata=snapshot.data.data[index];
                   var empname = chatlistdata.clientFirstname+" "+chatlistdata.clientLastname;
                   var clientid =chatlistdata.clientId;
                   var email=chatlistdata.clientEmail;
                   var mob=chatlistdata.clientMobile;
                   return GestureDetector(
                     onTap: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => TaskListHistory(ClientId: clientid,)));
                     },
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

                             child: CircleAvatar(
                               radius: 35,
                               backgroundImage: NetworkImage(All_API().baseurl_img_default),
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
                                       ],
                                     ),
                                   ],
                                 ),
                                 SizedBox(
                                   height: 10,
                                 ),
                                 Container(
                                   alignment: Alignment.topLeft,
                                   child: Text(
                                     email,
                                     style: TextStyle(
                                       fontSize: 13,
                                       color: Colors.black54,
                                     ),
                                     overflow: TextOverflow.ellipsis,
                                     maxLines: 2,
                                   ),
                                 ),
                                 SizedBox(
                                   height: 10,
                                 ),
                                 Container(
                                   alignment: Alignment.topLeft,
                                   child: Text(
                                     mob,
                                     style: TextStyle(
                                       fontSize: 13,
                                       color: Colors.black54,
                                     ),
                                     overflow: TextOverflow.ellipsis,
                                     maxLines: 2,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                   );
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
     )
   );
  }
  Future<ClientListModel> clientlist() async {
    var url = All_API().baseurl + All_API().api_clientBycompany+"/"+employeeId;
    print("all_LAST_task_url -->" + url);
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("all_LAST_task_basicAuth--> " + basicAuth);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('GET', Uri.parse(url));

    print("all_LAST_task_empid--> " + employeeId);

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("all_LAST_task_body_response -->" + response.body);

    try {
      if (response.statusCode == 200) {
        var jasonDataNotification = jsonDecode(response.body);
        return ClientListModel.fromJson(jasonDataNotification);
      }
    } catch (e) {
      return e;
    }
  }
}