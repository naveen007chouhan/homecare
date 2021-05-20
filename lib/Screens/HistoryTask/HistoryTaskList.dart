import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/HistoryTask/Model/AllTaskListModel.dart';
import 'package:homecare/Screens/HomePages/tasklistDetail.dart';
import 'package:homecare/components/text_field_container.dart';
import 'package:homecare/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskListHistory extends StatefulWidget {
  String ClientId;
  TaskListHistory({this.ClientId});
  @override
  _TaskListHistoryState createState() => _TaskListHistoryState();
}

class _TaskListHistoryState extends State<TaskListHistory> {
  FocusNode focusNode = new FocusNode();

  String employeeId;
  String companyId;
  String selectedtypeid;
  String dateselected="";
  String datesplit;
  String clientids;
  String searchKey = "";
  var searchController = TextEditingController();
  String dayLeave=null;
  List DayTypeList=[{'id':'0','name':'Assign Date'},{'id':'1','name':'Deadline Date'},];

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
      searchResult();
    });
  }
  DateTime currentDate = DateTime.now();
  Future<void> _selectDateFrom(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        var str = currentDate.toString();
        var Strdate = str.split(" ");
        datesplit = Strdate[0].trim();
        DateTime formatteddate = DateTime.parse(datesplit);
        dateselected = DateFormat("yyyy-MM-dd").format(formatteddate);
        print("dateselected ON Pick :--> " + dateselected);
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryLightColor,
        elevation: 8,
        title: Text(
            All_Lan().tour_area,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          new Container(
            color: Colors.white,
            child: new Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20),
              child: Container(
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
                                      controller: searchController,
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: kSecondaryLightColor,
                                      ),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText:All_Lan().search_by_tour_category_client,
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
                                      onChanged: ((String search) {
                                        setState(() {
                                          searchKey = search;
                                          print(searchKey);
                                        });
                                      }),
                                    ),
                                  ),
                                ),
                                new IconButton(
                                  icon: new Icon(Icons.search),
                                  // highlightColor: Colors.pink,
                                  color: HexColor('#B9BABC'),
                                  onPressed: () {
                                    searchKey = searchController.text;
                                    searchResult();
                                  },
                                ),
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
            ),
          ),
          new Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFieldContainer(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text("Select Type",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      value: dayLeave,
                      items: DayTypeList.map((explist) {
                        return DropdownMenuItem(
                          value: explist['name'],
                          child: Text(explist['name']),
                          onTap: (){
                            selectedtypeid = explist['id'];
                            print("selectedtype-->"+explist['id']);
                          },
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dayLeave = value;
                          if(selectedtypeid==0){
                            dayLeave = null;
                          }
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: TextFieldContainer(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_outlined),
                            Spacer(),
                            Text(dateselected==""?"Select Date":dateselected),
                          ],
                        ),
                      ),
                      onTap: (){
                        _selectDateFrom(context);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          new Expanded(
            child: getBody(),
          )
        ],
      ),
    );
  }

  Widget getBody() {
    return FutureBuilder<AllTaskListModel>(
        future: searchResult(),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Some error Found');
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return Text('Data Fill');
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
                      var clientname =
                          lasttask.clientfirstName + " " +
                              lasttask.clientlastName;
                      print("lst_FIVE_TASK-->" +
                          lasttask.taskImagemode.toString());
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

                      print("datealot-->" + alot);
                      print("datealot-->" + deadlinealot);
                      print("datealot-->" + alot1);
                      print("datealot-->" + assigndatealot);
                      print("datealot-->" + tourimg);
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
                                          image: omgtaskmode == 0
                                              ? NetworkImage(defaultimg)
                                              : NetworkImage(tourimg),
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
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      1, 1, 5, 0),
                                                  child: Icon(
                                                    Icons.category,
                                                    size: 14,
                                                    color: Colors.grey,
                                                  ),
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
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 1, 1, 0),
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 14,
                                                    color: Colors.grey,
                                                  ),
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
                                child: lasttask.status == "pending"
                                    ? Container(
                                  color: Colors.orange,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    lasttask.status,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                )
                                    : lasttask.status == "processing"
                                    ? Container(
                                  color: Colors.pink,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    lasttask.status,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                )
                                    : lasttask.status == "completed" &&
                                    lasttask.isApproved == "2"
                                    ? Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "Rejected",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                )
                                    : lasttask.status == "completed" &&
                                    lasttask.isApproved == "1"
                                    ? Container(
                                  color: Colors.green,
                                  padding:
                                  const EdgeInsets.all(4.0),
                                  child: Text(
                                    "Approved",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                )
                                    : lasttask.status == "completed" &&
                                    lasttask.isApproved == "0"
                                    ? Container(
                                  color: Colors.blue,
                                  padding:
                                  const EdgeInsets.all(
                                      4.0),
                                  child: Text(
                                    "Completed",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
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
                                        All_Lan().date + ":" +
                                            assigndatealot.toString(),
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
                                        All_Lan().deadline_date + ": " +
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
          }
        });
  }

  Future<AllTaskListModel> searchResult() async {
    var url = All_API().baseurl + All_API().api_all_task_list;
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
    var request = http.MultipartRequest('POST', Uri.parse(url));

    if(widget.ClientId==null){
      clientids="";
    }else{
      clientids=widget.ClientId;
    }
    if(selectedtypeid==null){
      selectedtypeid="";
    }else{
      selectedtypeid;
    }
     print("all_LAST_selectedtypeid--> " + selectedtypeid);
    print("all_LAST_Dateselected--> " + dateselected);
    print("all_LAST_task_empid--> " + employeeId);
    print("all_LAST_clientid--> " + clientids);

    request.fields.addAll({
      'employee_id': employeeId,
      'search': searchKey,
      'client_id': clientids,
      'date_type': selectedtypeid,
      'date':dateselected,
    });
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("all_LAST_task_body_response -->" + response.body);

    try {
      if (response.statusCode == 200) {
        var jasonDataNotification = jsonDecode(response.body);
        return AllTaskListModel.fromJson(jasonDataNotification);
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
