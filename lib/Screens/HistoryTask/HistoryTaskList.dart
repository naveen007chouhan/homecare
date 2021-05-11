import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/HistoryTask/Model/AllTaskListModel.dart';
import 'package:homecare/Screens/HomePages/tasklistDetail.dart';
import 'package:homecare/constants.dart';
import 'package:homecare/loading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class TaskListHistory extends StatefulWidget {
  @override
  _TaskListHistoryState createState() => _TaskListHistoryState();
}

class _TaskListHistoryState extends State<TaskListHistory> {

  FocusNode focusNode = new FocusNode();
  int selectedradiotile;
  bool progress = true;
  String employeeId;
  String companyId;
  String searchresult;
  TextEditingController _searchtextEditingController = TextEditingController() ;
  List dataList = new List();
  bool searchlist=true;
  int searchStatusCode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedradiotile = 0;
    getData();
  }
  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      employeeId = sharedPreferences.getString("employeeId");
      companyId = sharedPreferences.getString("companyId");
      // homeTaskList(employeeId);
      print("HistoryemployeeId -> " + employeeId);
    });
  }





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          'Tour Area',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          /*IconButton(
            icon: Icon(Icons.account_tree),
            color: Colors.white,
            onPressed: () {},
          ),*/
        ],
      ),
      body: SingleChildScrollView(
        child: Container(

          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20),
                child: Card(

                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(13.0),
                        bottomLeft: Radius.circular(13.0),
                        topLeft: Radius.circular(13.0),
                        topRight: Radius.circular(13.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 64,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor('#F8FAFB'),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(13.0),
                                bottomLeft: Radius.circular(13.0),
                                topLeft: Radius.circular(13.0),
                                topRight: Radius.circular(13.0),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: TextFormField(
                                      controller: _searchtextEditingController,
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: kSecondaryLightColor,
                                      ),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'Search by Tour,Category,Client',
                                        border: InputBorder.none,
                                        helperStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: HexColor('#B9BABC'),
                                        ),
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          letterSpacing: 0.2,
                                          color: HexColor('#B9BABC'),
                                        ),
                                      ),
                                      onChanged: (value){
                                        searchresult =value;
                                        homeAllTask(employeeId,searchresult);
                                      },

                                    ),
                                  ),
                                ),

                                new IconButton(
                                  icon: new Icon(Icons.search),
                                  // highlightColor: Colors.pink,
                                  color: HexColor('#B9BABC'),
                                  onPressed: (){
                                    searchlist=false;
                                    var Searchresultttt= _searchtextEditingController.text;
                                    searchresult =Searchresultttt;
                                    homeAllTask(employeeId,searchresult);
                                    print("Searchresultttt--> "+Searchresultttt);
                                  },
                                ),

                                /*SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Icon(Icons.search,
                                      color: HexColor('#B9BABC')),
                                )*/
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              if(searchlist==false)...[
                //...getBody(context),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                      height: 550,
                      child: FutureBuilder<AllTaskListModel>(
                        future: homeAllTask(employeeId,searchresult),
                        // ignore: missing_return
                        builder: (context, snapshot) {

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
                                                                  padding: const EdgeInsets.fromLTRB(10, 1, 1, 0),
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
                                        All_API().no_result_found,
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

                        },
                      )),
                ),
              ]
              else...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                      height: 550,
                      child: FutureBuilder<AllTaskListModel>(
                        future: homeAllTaskList(employeeId,searchresult),
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
                                                                  padding: const EdgeInsets.fromLTRB(10, 1, 1, 0),
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
                      )),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
  Future<AllTaskListModel> homeAllTaskList(String empid,String search) async {
    var all_LAST_task_list_url =
        All_API().baseurl + All_API().api_all_task_list;
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
    var request = http.MultipartRequest('POST', Uri.parse(all_LAST_task_list_url));

    print("all_LAST_task_empid--> " + employeeId);
    request.fields.addAll({
      'employee_id': empid,
      'search': '',
    });
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
        return AllTaskListModel.fromJson(jasonDataNotification);
      } else {
        /*setState(() {
          progress = false;
        });*/
      }
    } catch (e) {
      return e;
    }
  }
   getBody(BuildContext context) {

    var tourimg = All_API().baseurl_img;
    return dataList.map((data) => searchStatusCode==200?GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskDetail(
                  empid: data['employeeId'],
                  taskid: data['taskId'],
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
                        image: data['taskImagemode'] == 0
                            ? NetworkImage(tourimg+data['taskImage'])
                            : NetworkImage(tourimg+data['Taskpath']+data['taskImage']),
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
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      data['task_name'],
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    1, 1, 5, 0),
                                child: Icon(
                                  Icons.category,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: data['CategoryName'],
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
                                padding: const EdgeInsets.fromLTRB(
                                    10, 1, 1, 0),
                                child: Icon(
                                  Icons.person,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: data['ClientfirstName']+data['ClientlastName'],
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
                  data['status'],
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
                  data['task_mode_name'],
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
                      "Date :" +data['assigned_date'].split(' ').first ,
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
                      "Deadline : "+data['deadline_date'].split(' ').first ,
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
    ):Text('message'));
  }
  Future<AllTaskListModel> homeAllTask(String empid, String search) async {
    var all_LAST_task_list_url =
        All_API().baseurl + All_API().api_all_task_list;
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
    var request =
    http.MultipartRequest('POST', Uri.parse(all_LAST_task_list_url));

    print("all_LAST_task_empid--> " + employeeId);
    request.fields.addAll({
      'employee_id': empid,
      'search': search,
    });
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("all_LAST_task_body_response -->" + response.body);
    var jasonDataNotification = jsonDecode(response.body);
    searchStatusCode = response.statusCode;
    try {
      if (response.statusCode == 200) {
        return AllTaskListModel.fromJson(jasonDataNotification);

      } else {
        setState(() {
          searchlist==false;
        });
      }
    } catch (e) {
      return e;
    }
  }

}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

