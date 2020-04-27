import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/task.dart';
import 'package:homesweethome/services/firestore.dart';

class ListViewer extends StatefulWidget {
  @override
  _ListViewerState createState() => _ListViewerState();
}

class _ListViewerState extends State<ListViewer> {
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
  
    return SingleChildScrollView(
                child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 80,
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Stack(children: <Widget>[
                        // The containers in the background
                        Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80.0,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 14.0,
                                  shadowColor: Color(0x802196F3),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          todoType('${items[index].tasktype}'),
                                          Text(
                                            '${items[index].taskname}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '${items[index].taskdate}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                '${items[index].tasktime}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ]);
                    }),
              ),
            ],
          ),
        );

  }
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