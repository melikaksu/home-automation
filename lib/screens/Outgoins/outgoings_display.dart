import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/screens/Outgoins/outgoins_creator.dart';
import 'package:homesweethome/shared/my_appbar.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'dayly_outgoing.dart';

class OutgoingPage extends StatefulWidget {
  @override
  _OutgoingPageState createState() => _OutgoingPageState();
}

class _OutgoingPageState extends State<OutgoingPage> {
  // List<Outgoing> items;
  // FirestoreService fireServ = new FirestoreService();
  // StreamSubscription<QuerySnapshot> todoTasks;

  // @override
  // void initState() {
  //   super.initState();

  //   items = new List();

  //   todoTasks?.cancel();
  //   todoTasks = fireServ.getOutgoingList().listen((QuerySnapshot snapshot) {
  //     final List<Outgoing> outgoings = snapshot.documents
  //         .map((documentSnapshot) => Outgoing.fromMap(documentSnapshot.data))
  //         .toList();

  //     setState(() {
  //       this.items = outgoings;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: myAppbar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: Icon(FontAwesomeIcons.plus),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OutgoingScreen(Outgoing('', '',0,))));
          },
          elevation: 5,
          highlightElevation: 3,
        ),
        resizeToAvoidBottomInset: false,

        
        body: TabBarView(
          children: <Widget>[
            DaylyOutgoing(),
            Center(child: Text("Weekly Outgoings")),
            Center(child: Text("Mountly Outgoins")),
            Center(child: Text("Total Outgoings")),
          ],
        ),
      ),
    );
  }

  // Widget todoType(String icontype) {
  //   IconData iconval;
  //   Color colorval;
  //   switch (icontype) {
  //     case 'travel':
  //       iconval = FontAwesomeIcons.mapMarkerAlt;
  //       colorval = Color(0xff4158ba);
  //       break;
  //     case 'shopping':
  //       iconval = FontAwesomeIcons.shoppingCart;
  //       colorval = Color(0xfffb537f);
  //       break;
  //     case 'gym':
  //       iconval = FontAwesomeIcons.dumbbell;
  //       colorval = Color(0xff4caf50);
  //       break;
  //     case 'party':
  //       iconval = FontAwesomeIcons.glassCheers;
  //       colorval = Color(0xff9962d0);
  //       break;
  //     default:
  //       iconval = FontAwesomeIcons.tasks;
  //       colorval = Color(0xff0dc8f5);
  //     //
  //   }
  //   return CircleAvatar(
  //     backgroundColor: colorval,
  //     child: Icon(iconval, color: Colors.white, size: 20.0),
  //   );
  // }

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
