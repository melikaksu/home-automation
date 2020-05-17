import 'package:flutter/material.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/services/outgoing_service.dart';
import 'package:homesweethome/shared/witgets/witget_of_outgoings.dart';
import 'package:provider/provider.dart';

class MounthlyOutgoing extends StatefulWidget {
  @override
  _MounthlyOutgoingState createState() => _MounthlyOutgoingState();
}

class _MounthlyOutgoingState extends State<MounthlyOutgoing> {
  List<Outgoing> _listOfOutgoings; //_outgoings;

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
      stream: outgoingProvider.mounthlyOutgoingAsStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData != null) {
            // debugPrint(snapshot.data.toString());
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
              ),
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
  }
}
