import 'package:flutter/material.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/services/outgoing_service.dart';
import 'package:homesweethome/shared/witgets/witget_of_outgoings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DailyOutgoing extends StatefulWidget {
  @override
  _DailyOutgoingState createState() => _DailyOutgoingState();
}

class _DailyOutgoingState extends State<DailyOutgoing> {
  List<Outgoing> _listOfOutgoings; //_outgoings;
  var day01= DateTime.parse(DateFormat('yyyyMM01').format(DateTime.now()));
  var day07=DateTime.parse(DateFormat('yyyyMM07').format(DateTime.now()));
  var daydd=DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));

  

  // StreamSubscription<QuerySnapshot> todoOutgoings;
  // @override
  // void initState() {
  //   OutgoingService fireServ = new OutgoingService();

  //   _outgoings = new List();
  //   todoOutgoings?.cancel();
  //   todoOutgoings = fireServ.getOutgoingList().listen((QuerySnapshot snapshot) {
  //     final List<Outgoing> outgoings = snapshot.documents
  //         .map((documentSnapshot) => Outgoing.fromMap(documentSnapshot.data))
  //         .toList();

  //     // this.items = outgoings;

  //     setState(() {
  //       this._outgoings = outgoings;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    OutgoingService outgoingProvider = Provider.of<OutgoingService>(context);

    return StreamBuilder(
      stream: outgoingProvider.dailyOutgoingAsStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('StreamBuilder: ${snapshot.connectionState}');
        print("Day 01: " +day01.toString());
        print("Day 07: " +day07.toString());
        print("Day dd: " +daydd.toString());
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData != null) {
            debugPrint(snapshot.data.toString());
            _listOfOutgoings = snapshot.data;

            return SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 480,
                  child: ListView.builder(
                    itemCount: _listOfOutgoings.length,
                    itemBuilder: (BuildContext contex, int index) {
                      return containerWitgetofOutgoing(
                          context: context,
                          index: index,
                          list: _listOfOutgoings);
                    },
                  ),
                ),
              ],
            )

                //   containerWitgetofOutgoing(
                //   list: _listOfOutgoings,
                //   context: context,
                // ),
                );
          }
          return Container(
            child: Center(
              child: Text("There is no data"),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //  Container(
    //       child: Center(
    //       child: Text(
    //         "Gider eklemek için,sağ altta bulunan ekle butonuna tıklayınız",
    //         style: TextStyle(
    //           color: Color(0xffff0863),
    //           fontSize: 30,
    //         ),
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //   )
  }
}
