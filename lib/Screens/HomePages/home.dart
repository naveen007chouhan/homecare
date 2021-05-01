import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecare/API/Api.dart';
import 'package:homecare/Screens/HomePages/HomeModel/TaskListModel.dart';
import 'package:homecare/Screens/HomePages/tasklistDetail.dart';

import 'package:homecare/components/spinner_field_container.dart';

import 'package:homecare/constants.dart';
import 'package:homecare/loading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getfromCurrentDate()
    getData();
  }

  String dayLeave = null;
  bool progress = true;
  var dayLeaveID;
  FocusNode focusNode = new FocusNode();
  TextEditingController _textEditingControllerToDate = TextEditingController();
  TextEditingController _textEditingControllerFromDate =
  TextEditingController();
  String AssinDeadlineDate = "assigned_date";
  final TextStyle whiteText = TextStyle(color: Colors.white);

  DateTime currentDate = DateTime.now();
  String StartDate="2021-04-25";
  String EndDate="2021-04-30";

  List DayTypeList = [
    {'id': '0', 'name': 'Choose Type'},
    {'id': '1', 'name': 'DeadlineDate'},
    {'id': '2', 'name': 'AssignedDate'}
  ];
  List Demotask = [
    {'id': '1', 'name': 'Plumbing','task':'Pipe fitting','client':'Jack Jonson','deadline':'2021-04-30','Date':'2021-04-27','status':'Processing','image':'https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg'},
    {'id': '2', 'name': 'Plumbing','task':'Leak repairing','client':'Nick Jonson','deadline':'2021-04-30','Date':'2021-04-27','status':'Approved','image':'https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg'},
    {'id': '3', 'name': 'Plumbing','task':'Pressure settlement','client':'Mick Williem','deadline':'2021-04-30','Date':'2021-04-27','status':'Rejected','image':'https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg'},
    {'id': '4', 'name': 'Plumbing','task':'Cleaning ','client':'Post Malon ','deadline':'2021-04-30','Date':'2021-04-27','status':'Pending','image':'https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg'},
    {'id': '5', 'name': 'Plumbing','task':'Accessory Changes','client':'Jackey','deadline':'2021-04-30','Date':'2021-04-27','status':'Processing','image':'https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg'},
  ];


  String employeeId;
  String companyId;
  String firstname;
  String lastname;
  String employeename;

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      employeeId = sharedPreferences.getString("employeeId");
      companyId = sharedPreferences.getString("companyId");
      firstname = sharedPreferences.getString("firstname");
      lastname = sharedPreferences.getString("lastname");
      employeename = firstname + " " + lastname;
      print("employeename -> " + employeename);
    });
  }

  getfromCurrentDate() async {

    String formatted = DateFormat("yyyy-MM-dd").format(DateTime.now());
    StartDate = formatted;
    print("DateTime_Formate:--> " + formatted);
    String formatted1 = DateFormat("yyyy-MM-dd").format(DateTime.now());
    EndDate = formatted1;
    print("DateTime_Formate:--> " + formatted1);

    setState(() {
      /*sharedPreferences.setString("dateCurrent", formatted);
      print("Today Date : "+sharedPreferences.getString("dateCurrent"));*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Container(
          child: Stack(
            children: [
              Padding(
                padding:
                const EdgeInsets.only(left: 10, right: 10.0, top: 30),
                child: Column(
                  children: [
                    Container(
                      height: 490,
                      /*decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [kSecondaryLightColor, kSecondaryColor]),
                      ),*/
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.1),
                                        blurRadius: 8,
                                        spreadRadius: 3)
                                  ],
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                padding: EdgeInsets.all(5),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://images.pexels.com/photos/2167673/pexels-photo-2167673.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),

                            ],
                          ),
                          const SizedBox(height: 20.0),


                          Card(
                            elevation: 8,
                            child: _buildTile(
                              color: Colors.orange,
                              icon: Icons.portrait,
                              title: "Total Client",
                              data: "5",
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Card(
                            elevation: 8,
                            child: Column(
                              children: [
                                _buildTile(
                                  color: Colors.blue,
                                  icon: Icons.portrait,
                                  title: "Total Task",
                                  data: "40",
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: ListTile(
                                    leading: new IconButton(
                                      icon: new Icon(
                                        Icons.circle,
                                        color: Colors.orange,
                                        size: 10.0,
                                      ),
                                      // onPressed: () => Navigator.of(context).pop(),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        "Pending " ,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    trailing:Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "10 " ,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: ListTile(
                                      leading: new IconButton(
                                        icon: new Icon(
                                          Icons.circle,
                                          color: Colors.green,
                                          size: 10.0,
                                        ),
                                        // onPressed: () => Navigator.of(context).pop(),
                                      ),
                                      title: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "Completed " ,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      trailing:Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "10 " ,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: ListTile(
                                      leading: new IconButton(
                                        icon: new Icon(
                                          Icons.circle,
                                          color: Colors.blue,
                                          size: 10.0,
                                        ),
                                        // onPressed: () => Navigator.of(context).pop(),
                                      ),
                                      title: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "Approved " ,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      trailing:Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "10 " ,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: ListTile(
                                      leading: new IconButton(
                                        icon: new Icon(
                                          Icons.circle,
                                          color: Colors.red,
                                          size: 10.0,
                                        ),
                                        // onPressed: () => Navigator.of(context).pop(),
                                      ),
                                      title: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "Rejected " ,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      trailing:Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "10 " ,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                  ),
                                ),

                              ],
                            ),
                          ),




                          //Text Field From Date && Too Date
                          /*Container(
                      padding: EdgeInsets.only(top: 65),
                      child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            child: ListTile(
                              // leading: const Icon(Icons.calendar_today),
                                title: TextFormField(
                                  controller: _textEditingControllerFromDate,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    labelText: "From Date",
                                    hintText: StartDate,),
                                  onTap: () async{
                                    DateTime date = DateTime(1900);
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    date = await showDatePicker(
                                        context: context,
                                        initialDate:DateTime.now(),
                                        firstDate:DateTime(1900),
                                        lastDate: DateTime(2100));
                                    currentDate = date==null?"Select Date":date;
                                    var str = currentDate.toString();
                                    var Strdate = str.split(" ");
                                    var dateFrom = Strdate[0].trim();
                                    StartDate = _textEditingControllerFromDate.text = dateFrom;
                                  },
                                  validator: ((value){
                                    if(value.isEmpty){
                                      return 'Please fill Date';
                                    }
                                    return null;
                                  }),
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: ListTile(
                              // leading: const Icon(Icons.calendar_today),
                                title: TextFormField(
                                  controller: _textEditingControllerToDate,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    labelText: "To Date",
                                    hintText: EndDate,),
                                  onTap: () async{
                                    DateTime date = DateTime(1900);
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    date = await showDatePicker(
                                        context: context,
                                        initialDate:DateTime.now(),
                                        firstDate:DateTime(1900),
                                        lastDate: DateTime(2100));
                                    currentDate = date==null?"Select Date":date;
                                    var str = currentDate.toString();
                                    var Strdate = str.split(" ");
                                    var dateTo = Strdate[0].trim();
                                    EndDate = _textEditingControllerToDate.text = dateTo;
                                  },
                                  validator: ((value){
                                    if(value.isEmpty){
                                      return 'Please fill Expenses Date';
                                    }
                                    return null;
                                  }),
                                )
                            ),
                          ),
                        ),
                      ],
                      ),
                    ),*/
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 11.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Last 5 Task",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                    ),

                   /* Container(
                      child: FutureBuilder<TodayTaskListModel>(
                          future: homeTaskList(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    var tasklist = snapshot.data.data[index];
                                    print("all_task_list_tasklist--> " +
                                        tasklist.status);
                                    var alotdatetime =
                                    tasklist.assignedDate.toString();
                                    var alotdate = alotdatetime.split(" ");
                                    var ALOTdate = alotdate[0].trim();
                                    var ALOttime = alotdate[1].trim();

                                    var daadlinedatetime =
                                    tasklist.deadlineDate.toString();
                                    var daadlinedate =
                                    daadlinedatetime.split(" ");
                                    var DEADLindate = daadlinedate[0].trim();
                                    var DEADLintime = daadlinedate[1].trim();
                                    var empid =
                                    tasklist.employeeId.toString();
                                    var tskid = tasklist.taskId.toString();
                                    var addrs = tasklist.address.toString();
                                    print("ID Checking--> " +
                                        empid +
                                        " " +
                                        tskid +
                                        " " +
                                        addrs);
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TaskDetail(
                                                      employid: empid,
                                                      taskid: tskid,
                                                      alotdate: ALOTdate,
                                                      deadlinedate:
                                                      DEADLindate,
                                                      addrs: addrs,
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
                                                        image: NetworkImage("https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg"),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                SizedBox(height: 15,),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    // padding: const EdgeInsets.all(16.0),
                                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                                    child: Text(
                                                      "Plumbing",
                                                      style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    // padding: const EdgeInsets.all(16.0),
                                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                    child:Text("Client : Jack Jonson", style: Theme.of(context).textTheme.title.merge(TextStyle(
                                                        fontSize: 15.0
                                                    ))),
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Date: 2021-04-27",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        "Dead Line : 2021-04-30",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14.0,
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
                                                  "Processing",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    );
                                  });
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
                          }),

                    ),*/
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: Demotask.length,
                        itemBuilder: (context, index){
                          print("Image" +Demotask[index].toString());
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TaskDetail(
                                            employid: "5",
                                            taskid: "2",
                                            alotdate: "ALOTdate",
                                            deadlinedate:
                                            "DEADLindate",
                                            addrs: "addrs",
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
                                              image: NetworkImage(Demotask[index]['image']),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      SizedBox(height: 15,),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          // padding: const EdgeInsets.all(16.0),
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          child: Text(
                                            Demotask[index]['name'],
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              Demotask[index]['client'],
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "Task: "+Demotask[index]['task'],
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0,
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
                                        Demotask[index]['status'],
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
                                            "Date :"+Demotask[index]['Date'],
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
                                            "Deadline :"+Demotask[index]['deadline'],
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
                    )
                  ],
                ),
              ),
              Positioned(
                top: 55,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 55),
                  // width: MediaQuery.of(context).size.width * 0.7,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 8,
                          spreadRadius: 3,
                          offset: Offset(0, 10),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(50),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*Row(
                                children: [
                                  Text(
                                    "Task Filter",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.filter_1,
                                    color: Color(0XFF00838F),
                                  )
                                ],
                              ),*/
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    employeename == null
                                        ? "Naveen Chouhan"
                                        : employeename.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: kSecondaryLightColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.perm_identity,
                                        color: kSecondaryLightColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "NODP3D",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: kSecondaryLightColor,
                                          ),
                                           /*children: [
                                              TextSpan(
                                                  text: ".50",
                                                  style: TextStyle(
                                                      color: Colors.white38))
                                            ]*/
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )

                            ],
                          ),
                          /* Container(width: 1, height: 50, color: Colors.grey),*/
                        ],
                      ),
                      /*SizedBox(
                        height: 10,
                      ),
                      Text(
                        "You spent \$ 1,494 this month",
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Let's see the cost statistics for this period",
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        width: double.maxFinite,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Tell me more",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF00B686)),
                        ),
                      )*/
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Container _buildTile(
      {Color color, IconData icon, String title, String data}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: color,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: whiteText.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 50.0),
          Text(
            data,
            style:
            whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          SizedBox(width: 20.0),
        ],
      ),
    );
  }

  Future<TodayTaskListModel> homeTaskList() async {
    var all_task_list_url = All_API().baseurl + All_API().api_all_task_list;
    print("all_task_list_url -->" + all_task_list_url);
    String username = All_API().keyuser;
    String password = All_API().keypassvalue;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("all_task_list_basicAuth--> " + basicAuth);

    Map<String, String> headers = {
      All_API().key: All_API().keyvalue,
      'authorization': basicAuth,
    };
    var request = http.MultipartRequest('POST', Uri.parse(all_task_list_url));

    print("AllTaskList_Field--> " +
        employeeId +
        " " +
        AssinDeadlineDate +
        " " +
        StartDate +
        " " +
        EndDate);
    request.fields.addAll({
      'employee_id': employeeId,
      'date_field': AssinDeadlineDate,
      'start_date': StartDate,
      'end_date': EndDate,
    });

    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print("all_task_list_body_response -->" + response.body);

    var jasonData = jsonDecode(response.body);
    String msg = jasonData['message'];

    // print("log_statuscode_response -->" +jasonData.statusCode);

    // final Map<String, String> jasonData = jsonDecode(response.body);
    // String msg=jasonData['error'];
    // print("MSG--> "+ msg );
    var jasonDataNotification = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
        progress = false;
        print("all_task_list_MSG--> " + msg);
        /* FocusScope.of(context).requestFocus(focusNode);
        final snackBar = SnackBar(
          content: Text(
            msg,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);*/

        return TodayTaskListModel.fromJson(jasonDataNotification);
        // return null;
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
          /* FocusScope.of(context).requestFocus(focusNode);
          final snackBar = SnackBar(
            content: Text(
              msg,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
        });
      }
    } catch (e) {
      return e;
    }
  }
}
