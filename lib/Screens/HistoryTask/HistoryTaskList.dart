import 'package:flutter/material.dart';
import 'package:homecare/components/spinner_field_container.dart';
import 'package:homecare/constants.dart';

class TaskListHistory extends StatefulWidget {
  @override
  _TaskListHistoryState createState() => _TaskListHistoryState();
}

class _TaskListHistoryState extends State<TaskListHistory> {
  String dayLeave=null;
  var dayLeaveID;
  List DayTypeList=[{'id':'0','name':'Choose Type'},{'id':'1','name':'Employee'},{'id':'2','name':'User'}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                color: Colors.white,
                /*decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kSecondaryLightColor, kSecondaryColor]),
                ),*/
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20.0, top: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Task List",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                             /* Text(
                                "Naveen Chouhan",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),*/


                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.white,
                  /*decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [kSecondaryLightColor, kSecondaryColor]),
                  ),*/
                  // color: Colors.white60,
                  child: ListView(
                    /*margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),*/
                    padding: EdgeInsets.only(top: 30),
                    children: [

                      GestureDetector(
                        onTap: (){
                         /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskDetail()));*/
                        },
                        child: Card(

                          // color: Colors.green,
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)
                                  // topRight: Radius.circular(10.0),
                                  // bottomRight: Radius.circular(10.0),
                                  // topLeft: Radius.circular(10.0),
                                  // bottomLeft: Radius.circular(10.0),
                                ),
                              ),
                              margin: const EdgeInsets.only(
                                  top: 5, left: 2, bottom: 5, right: 2),
                              child: Column(
                                children: [
                                  ListTile(

                                    leading:Card(
                                      color: kPrimaryColor,
                                      elevation: 5,

                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text("Processing",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orangeAccent)),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Type : ",
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Alot Date : ",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      trailing: Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color: Colors.grey[600],
                                          size: 30.0)),
                                  Divider(
                                    height: 1,
                                    color: kSecondaryLightColor,
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child:Padding(

                                      padding: const EdgeInsets.all(10.0),
                                      child: Text("Dead Line : ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red)),
                                    ),
                                  ),

                                ],
                              )
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 90,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              // width: MediaQuery.of(context).size.width * 0.7,
              height: 115,
              decoration: BoxDecoration(
                 // color: Colors.white,
                  gradient: LinearGradient(
                      colors: [kSecondaryLightColor, kSecondaryColor]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.09),
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
                          Row(
                            children: [
                              Text(
                                "Task Filter",
                                style: TextStyle(
                                    color: Colors.grey.shade200,
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
                          ),
                          SpinnerFieldContainer(
                            child: DropdownButton(
                              underline: SizedBox(),
                              isExpanded: true,
                              hint: Text("Choose Type",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,color: Colors.orange)),
                              value: dayLeave,
                              style: new TextStyle(
                                color: Colors.orange,
                              ),
                              items: DayTypeList.map((explist) {
                                return DropdownMenuItem(
                                  value: explist['name'],
                                  child: Text(explist['name']),
                                  onTap: (){
                                    dayLeaveID = explist['id'];
                                    print("leavess-->"+explist['id']);
                                  },
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dayLeave = value;
                                  if(dayLeaveID==0){
                                    dayLeave = null;
                                  }
                                });
                              },
                            ),
                          ),
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

    );
  }
}
