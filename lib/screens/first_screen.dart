import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homesweethome/models/task.dart';
import 'package:homesweethome/services/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../my_drawer.dart';



class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

   var user=FirebaseAuth.instance.currentUser();
   var _userUid;

   _getUserName() async =>
      await FirebaseAuth.instance.currentUser().then((user) {
        setState(() => this._userUid = user.uid);
      });

  List<Task> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> todoTasks;

  @override
  void initState() {
    _getUserName();
    super.initState();

    items=new List();

    todoTasks?.cancel();
    todoTasks=fireServ.getTaskList(uid: _userUid).listen((QuerySnapshot snapshot){
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
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: MyDrawer(),
      body: 
         ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Stack(children: <Widget>[
                    // The containers in the background
                      Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // height: 80.0,
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
          
  
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xFFFA7397),
      //   child: Icon(
      //     FontAwesomeIcons.listUl,
      //     color: Color(0xFFFDDE42),
      //   ),
      //   onPressed: () {
      //     //Navigator.push(context,MaterialPageRoute(builder: (context) => TaskScreen()),
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => TaskScreen(Task('', '', '', '', '')),
      //           fullscreenDialog: true),
      //     );
      //   },
      // ),
    );
  }


  Widget todoType(String icontype) {
    IconData iconval;
    Color colorval;
    switch (icontype) {
      case 'Seyahat':
        iconval = FontAwesomeIcons.mapMarkerAlt;
        colorval = Color(0xff4158ba);
        break;
      case 'Alışveriş':
        iconval = FontAwesomeIcons.shoppingCart;
        colorval = Color(0xfffb537f);
        break;
      case 'Spor':
        iconval = FontAwesomeIcons.dumbbell;
        colorval = Color(0xff4caf50);
        break;
      case 'Okul':
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
  }}