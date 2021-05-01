import 'package:flutter/material.dart';
import 'package:homecare/Screens/HomePages/tasklistDetail.dart';
import 'package:homecare/components/oval_top_border.dart';
import 'package:homecare/components/spinner_field_container.dart';
import 'package:homecare/constants.dart';

class TaskListHistory extends StatefulWidget {
  @override
  _TaskListHistoryState createState() => _TaskListHistoryState();
}

class _TaskListHistoryState extends State<TaskListHistory> {
 /* String dayLeave=null;
  var dayLeaveID;
  List DayTypeList=[{'id':'0','name':'Choose Type'},{'id':'1','name':'Employee'},{'id':'2','name':'User'}];*/
  void _showModalSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.white70.withOpacity(0.0),
        context: context,
        builder: (builder) {
          return new ClipPath(
            clipper: OvalTopBorderClipper(),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 250,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.grey.shade700,
                      spreadRadius: 80.0),
                ],
                color: Colors.white,
              ),
              padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 70.0, bottom: 5.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Pending"),
                      Text(
                        "5" ,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.orange),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Rejected"),
                      Text(
                        "5" ,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.orange),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Approved"),
                      Text(
                        "5" ,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.orange),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Completed"),
                      Text(
                        "5" ,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.orange),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: kSecondaryLightColor,
                    onPressed: () {
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Apply",
                            style: TextStyle(color: Colors.white)),

                        // Text("Rs.", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
  List Demotask = [
    {'id': '1', 'name': 'Plumbing','task':'Pipe fitting','client':'Jack Jonson','deadline':'2021-04-30','Date':'2021-04-27','status':'Processing','image':'https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg'},
    {'id': '2', 'name': 'Plumbing','task':'Leak repairing','client':'Nick Jonson','deadline':'2021-04-30','Date':'2021-04-27','status':'Approved','image':'https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg'},
    {'id': '3', 'name': 'Plumbing','task':'Pressure settlement','client':'Mick Williem','deadline':'2021-04-30','Date':'2021-04-27','status':'Rejected','image':'https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg'},
    {'id': '4', 'name': 'Plumbing','task':'Cleaning ','client':'Post Malon ','deadline':'2021-04-30','Date':'2021-04-27','status':'Pending','image':'https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg'},
    {'id': '5', 'name': 'Plumbing','task':'Accessory Changes','client':'Jackey','deadline':'2021-04-30','Date':'2021-04-27','status':'Processing','image':'https://st.depositphotos.com/1010613/2860/i/600/depositphotos_28608021-stock-photo-young-plumber-fixing-a-sink.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                color: Colors.grey[200],
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 90,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: TextField(
                          // controller: TextEditingController(text: locations[0]),
                          cursorColor: Theme.of(context).primaryColor,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          decoration: InputDecoration(
                              hintText: "Search Client",
                              hintStyle: TextStyle(
                                  color: kSecondaryLightColor, fontSize: 16),
                              prefixIcon: Material(
                                elevation: 0.0,
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                                child: Icon(Icons.search,color: kSecondaryLightColor,),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 13)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical:180,horizontal:10),
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          elevation: 4.0,
                          onPressed:_showModalSheet,
                          child: Container(
                            alignment: Alignment.center,
                            height: 30.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.person_add,
                                            color: kSecondaryLightColor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Client",
                                            style: TextStyle(
                                                color: kSecondaryLightColor,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical:180,horizontal:10),
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          elevation: 4.0,
                          onPressed:_showModalSheet,
                          child: Container(
                            alignment: Alignment.center,
                            height: 30.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.category,
                                            color: kSecondaryLightColor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Category",
                                            style: TextStyle(
                                                color: kSecondaryLightColor,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical:180,horizontal:10),
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          elevation: 4.0,
                          onPressed:_showModalSheet,
                          child: Container(
                            alignment: Alignment.center,
                            height: 30.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.account_tree_outlined,
                                            color: kSecondaryLightColor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Status",
                                            style: TextStyle(
                                                color: kSecondaryLightColor,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical:180,horizontal:10),
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          elevation: 4.0,
                          onPressed:_showModalSheet,
                          child: Container(
                            alignment: Alignment.center,
                            height: 30.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.timelapse_rounded,
                                            color: kSecondaryLightColor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Deadline",
                                            style: TextStyle(
                                                color: kSecondaryLightColor,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 245),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: Demotask.length,
                    itemBuilder: (BuildContext context, int index) {
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
                    }),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
