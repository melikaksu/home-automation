import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/services/outgoing_service.dart';
import 'package:homesweethome/shared/witgets/witget_of_outgoings.dart';

class DaylyOutgoing extends StatefulWidget {
  @override
  _DaylyOutgoingState createState() => _DaylyOutgoingState();
}

class _DaylyOutgoingState extends State<DaylyOutgoing> {
  List<Outgoing> _outgoings;

  StreamSubscription<QuerySnapshot> todoOutgoings;

  @override
  void initState() {
    OutgoingService fireServ = new OutgoingService();

    _outgoings = new List();
    todoOutgoings?.cancel();
    todoOutgoings = fireServ.getOutgoingList().listen((QuerySnapshot snapshot) {
      final List<Outgoing> outgoings = snapshot.documents
          .map((documentSnapshot) => Outgoing.fromMap(documentSnapshot.data))
          .toList();

      // this.items = outgoings;

      setState(() {
        this._outgoings = outgoings;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _outgoings.isEmpty
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
          child: containerWitgetofOutgoing(list: _outgoings,context: context,),
          );
  }
}

