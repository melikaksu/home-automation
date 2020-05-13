import 'package:flutter/material.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/services/outgoing_service.dart';
import 'package:homesweethome/shared/witgets/witget_of_outgoings.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DaylyOutgoing extends StatefulWidget {
  @override
  _DaylyOutgoingState createState() => _DaylyOutgoingState();
}

class _DaylyOutgoingState extends State<DaylyOutgoing> {
  List<Outgoing> _listOfOutgoings; //_outgoings;
  bool isdaily;

  isDaily(
    List<Outgoing> list,
  ) {
    var currentDate = DateTime.now();
    for (var i = 0; i < list.length; i++) {
      if (DateFormat("EEEE").format(list[i].timecreatedAt.toDate()) ==
          DateFormat("EEEE").format(currentDate)) {
        setState(() {
          isdaily = true;
        });
      }
    }
  }

  @override
  void initState() {
    isDaily(_listOfOutgoings);
    super.initState();
  }

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
      stream: outgoingProvider.fetchOutgoingAsStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData != null) {
            _listOfOutgoings = snapshot.data.documents
                .map<Outgoing>(
                    (doc) => Outgoing.fromMap(doc.data, doc.documentID))
                .toList();

            isDaily(_listOfOutgoings);

            return SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 480,
                  child: ListView.builder(
                    itemCount: _listOfOutgoings.length,
                    itemBuilder: (BuildContext contex, int index) {
                      return isdaily
                          ? containerWitgetofOutgoing(
                              context: context,
                              index: index,
                              list: _listOfOutgoings)
                          : Center(child: Container());
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
