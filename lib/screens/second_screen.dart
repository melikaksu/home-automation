  
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/task.dart';
import 'package:homesweethome/screens/list_viewer.dart';
import 'package:homesweethome/screens/task_list_creatar.dart';
import 'package:homesweethome/services/firestore.dart';

import '../my_drawer.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<Task> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> todoTasks;

  @override
  void initState() {
    super.initState();

    items=new List();

    todoTasks?.cancel();
    todoTasks=fireServ.getTaskList().listen((QuerySnapshot snapshot){
        final List<Task> tasks=snapshot.documents
        .map((documentSnapshot) => Task. fromMap(documentSnapshot.data))
        .toList();

        setState(() {
        this.items = tasks;
      });
      
    });

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 4,
          child: Scaffold(
                      drawer: MyDrawer(),
            floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueGrey ,
            child: Icon(FontAwesomeIcons.plus),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TaskScreen(Task('', '', '', '', ''))));
            },
            elevation: 5,
            highlightElevation: 3,
          ),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
                  
                    leading: Builder(builder: (BuildContext context) {
                      return IconButton(
                          icon: Icon(
                            FontAwesomeIcons.bars,
                            color: Color(0xff2d386b),
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer());
                    }),
                    centerTitle: true,
                    title: Text(
                      'AppBar',
                      style: TextStyle(
                          fontFamily: "Lobster",
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          color: Color(0xff2d386b)),
                    ),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.shareAlt,
                            color: Color(0xff2d386b),
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.cogs,
                            color: Color(0xff2d386b),
                          ),
                          onPressed: () {})
                    ],
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    bottom: 
                    PreferredSize(
                          preferredSize: Size.fromHeight(60),
                          child: Container(
                            color: Colors.transparent,
                            child: SafeArea(
                              child: Column(
                                children: <Widget>[
                        TabBar(
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                color: Color(0xffff0863),
                                width: 3.0,
                              ),
                              // insets: EdgeInsets.fromLTRB(
                              //     40.0, 20.0, 40.0, 0)
                            ),
                            //  indicatorWeight: 20,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: Color(0xff2d386b),
                            labelStyle: TextStyle(
                              // fontFamily: "Lobster",
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                            unselectedLabelColor: Colors.black26,
                            tabs: [
                          Tab(
                            child: Text("GÜNLÜK"),

                            // icon: Icon(FontAwesomeIcons.clock,
                            //     size: 20),
                          ),
                          Tab(
                            text: "HAFTALIK",
                            // icon: Icon(FontAwesomeIcons.clock,
                            //     size: 20),
                          ),
                          Tab(
                            text: "AYLIK",
                            // icon: Icon(FontAwesomeIcons.recordVinyl,
                            //     size: 20),
                          ),
                          Tab(
                            text: "TÜMÜ",
                            // icon: Icon(Icons.supervised_user_circle,
                            //     size: 20),
                          ),
                        ])
                  ]
                            
                      ),
                    ),
                  ),
                )),

         body: TabBarView(
                  children: <Widget>[
                    
                    ListViewer(),

                    Text("Third Screen"),

                    Text("Third Screen"), Text("Third Screen"),
                  
                  ],
                ),


       
      ), 
    );
  }


  Widget todoType(String icontype) {
    IconData iconval;
    Color colorval;
    switch (icontype) {
      case 'travel':
        iconval = FontAwesomeIcons.mapMarkerAlt;
        colorval = Color(0xff4158ba);
        break;
      case 'shopping':
        iconval = FontAwesomeIcons.shoppingCart;
        colorval = Color(0xfffb537f);
        break;
      case 'gym':
        iconval = FontAwesomeIcons.dumbbell;
        colorval = Color(0xff4caf50);
        break;
      case 'party':
        iconval = FontAwesomeIcons.glassCheers;
        colorval = Color(0xff9962d0);
        break;
      default:
         iconval = FontAwesomeIcons.tasks;
         colorval = Color(0xff0dc8f5);
      //
    }
    return CircleAvatar(
      backgroundColor: colorval,
      child: Icon(iconval, color: Colors.white, size: 20.0),
    );
  }

  // Widget _myAppBar(context) {
  //   return Container(
  //     height: 80.0,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //           colors: [
  //             const Color(0xFFFA7397),
  //             const Color(0xFFFDDE42),
  //           ],
  //           begin: const FractionalOffset(0.0, 0.0),
  //           end: const FractionalOffset(1.0, 0.0),
  //           stops: [0.0, 1.0],
  //           tileMode: TileMode.clamp),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.only(top: 16.0),
  //       child: Center(
  //           child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           Expanded(
  //             flex: 1,
  //             child: Container(
  //               child: IconButton(
  //                   icon: Icon(
  //                     FontAwesomeIcons.arrowLeft,
  //                     color: Colors.white,
  //                   ),
  //                   onPressed: () {
  //                     //
  //                   }),
  //             ),
  //           ),
  //           Expanded(
  //             flex: 5,
  //             child: Container(
  //               child: Text(
  //                 'ToDo Tasks',
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 20.0),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             flex: 1,
  //             child: Container(
  //               child: IconButton(
  //                   icon: Icon(
  //                     FontAwesomeIcons.search,
  //                     color: Colors.white,
  //                   ),
  //                   onPressed: () {
  //                     //
  //                   }),
  //             ),
  //           ),
  //         ],
  //       )),
  //     ),
  //   );
  // }
}