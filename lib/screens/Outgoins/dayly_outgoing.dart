import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/services/outgoing_service.dart';

class DaylyOutgoing extends StatefulWidget {
  @override
  _DaylyOutgoingState createState() => _DaylyOutgoingState();
}

class _DaylyOutgoingState extends State<DaylyOutgoing> {


   



  List<Outgoing> items;
  



  StreamSubscription<QuerySnapshot> todoOutgoings;

  @override
  void initState()  {


    OutgoingService fireServ = new OutgoingService();
    
    items = new List();
    todoOutgoings?.cancel();
    todoOutgoings = fireServ.getOutgoingList().listen((QuerySnapshot snapshot) {
      final List<Outgoing> outgoings = snapshot.documents
          .map((documentSnapshot) => Outgoing.fromMap(documentSnapshot.data))
          .toList();

          // this.items = outgoings;

      setState(() {
        this.items = outgoings;
      });
    });
        super.initState();

    
  }

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
           ? Container(
              child: Center(
              child: Text(
                "Gider eklemek için,sağ altta bulunan ekle butonuna tıklayınız",
                style: TextStyle(
                  color: Color(0xffff0863),
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 480,
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Stack(children: <Widget>[
                          // The containers in the background
                          Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 6.0, right: 6.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60.0,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 6.0, bottom: 6.0),
                                  child: Material(
                                    color: Colors.white,
                                    elevation: 14.0,
                                    shadowColor: Color(0x802196F3),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            todoType('${items[index].type}'),
                                            Text(
                                              '${items[index].name}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.0),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${items[index].quantity}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
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
      case 'Seyahat':
        iconval = FontAwesomeIcons.mapMarkerAlt;
        colorval = Color(0xff4158ba);
        break;
      case 'Alışveriş':
        iconval = FontAwesomeIcons.shoppingCart;
        colorval = Color(0xfffb537f);
        break;
      case 'Eğitim':
        iconval = FontAwesomeIcons.graduationCap;
        colorval = Color(0xff4caf50);
        break;
      case 'Diğer':
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
