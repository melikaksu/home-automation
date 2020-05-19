import 'package:flutter/material.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/shared/funtions/get_days.dart';
import 'package:homesweethome/shared/witgets/witget_of_outgoings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeeklyOutgoing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Outgoing> _listoutgoing = Provider.of<List<Outgoing>>(context);

    List<Outgoing> getWeeklyOutgoings() {
      print("object");
      var monday = DateTime.parse(DateFormat('yyyyMMdd').format(getMonday()));
      var sunday = DateTime.parse(getSunday().toString());
      List<Outgoing> list = [];
      for (var i = 0; i < _listoutgoing.length; i++) {
        if (_listoutgoing[i].createdAt.toDate().isAfter(monday) &&
            _listoutgoing[i].createdAt.toDate().isBefore(sunday)) {
          list.add(_listoutgoing[i]);
          // print(list[i].name);
        }
      }
      return list;
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 480,
              child: ListView.builder(
                itemCount: getWeeklyOutgoings().length,
                itemBuilder: (BuildContext contex, int index) {
                  return containerWitgetofOutgoing(
                      context: context,
                      index: index,
                      list: getWeeklyOutgoings());
                },
              )),
        ],
      ),
    );

    // return StreamBuilder(
    //   stream: outgoingProvider.weeklyOutgoingAsStream(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     print('StreamBuilder: ${snapshot.connectionState}');
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       if (snapshot.hasData != null) {
    //         _listOfOutgoings = snapshot.data;
    //         print(DateTime.parse(getSunday().toString()));

    //         return SingleChildScrollView(
    //           child: Column(
    //             children: <Widget>[
    //               Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 height: 480,
    //                 child: ListView.builder(
    //                   itemCount: _listOfOutgoings.length,
    //                   itemBuilder: (BuildContext contex, int index) {
    //                     return containerWitgetofOutgoing(
    //                         context: context,
    //                         index: index,
    //                         list: _listOfOutgoings);
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       }
    //       return Container(
    //         child: Center(
    //           child: Text("There is no data"),
    //         ),
    //       );
    //     }
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }
}
