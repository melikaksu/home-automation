import 'package:flutter/material.dart';
import 'package:homesweethome/models/catagory.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/shared/witgets/witget_of_outgoings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DailyOutgoing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Catagory catagory = Catagory();
    List<Outgoing> _outgoing = Provider.of<List<Outgoing>>(context);

    List<List<Outgoing>> getByType() {
      DateTime today =
          DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
      List<List<Outgoing>> totalList = [];
      List<Outgoing> travelList = [];
      List<Outgoing> sportList = [];
      List<Outgoing> shopList = [];
      List<Outgoing> eduList = [];
      List<Outgoing> healthList = [];
      List<Outgoing> othersList = [];
      for (var i = 0; i < _outgoing.length; i++) {
        if (_outgoing[i].createdAt.toDate().isAfter(today)) {
          // _outgoing.sort((a, b) => a.outgoingdType.compareTo(b.outgoingdType));

          if (_outgoing[i].outgoingdType == catagory.shpping) {
            shopList.add(_outgoing[i]);
          }
          if (_outgoing[i].outgoingdType == catagory.aduqation) {
            eduList.add(_outgoing[i]);
            // print("Edu "+eduList[i].outgoingdType);
          }
          if (_outgoing[i].outgoingdType == catagory.health) {
            healthList.add(_outgoing[i]);
          }
          if (_outgoing[i].outgoingdType == catagory.travel) {
            travelList.add(_outgoing[i]);
          }
          if (_outgoing[i].outgoingdType == catagory.sport) {
            sportList.add(_outgoing[i]);
          }
          if (_outgoing[i].outgoingdType == catagory.others) {
            othersList.add(_outgoing[i]);
          }
        }
      }

      if (shopList.isNotEmpty) {
        totalList.add(shopList);
      }
      if (eduList.isNotEmpty) {
        totalList.add(eduList);
      }
      if (healthList.isNotEmpty) {
        totalList.add(healthList);
      }
      if (othersList.isNotEmpty) {
        totalList.add(othersList);
      }
      if (travelList.isNotEmpty) {
        totalList.add(travelList);
      }
      if (sportList.isNotEmpty) {
        totalList.add(sportList);
      }

      // for (var i = 0; i < totalList.length; i++) {
      //   print(totalList[i][i]);
      // }
      return totalList;
    }

    // List<Outgoing> getDailyOutgoings() {
    //   DateTime today =
    //       DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
    //   List<Outgoing> list = [];
    //   for (var i = 0; i < _outgoing.length; i++) {
    //     if (_outgoing[i].createdAt.toDate().isAfter(today)) {
    //       list.add(_outgoing[i]);
    //     }
    //     print(list[i].outgoingdType);
    //   }
    //   return list;
    // }

    // List<Outgoing> ctgOutgoing(List<Outgoing> armut) {
    //   int j;
    //   String element;

    //   for (int i = 1; i < armut.length; i++) {
    //     element = armut[i].outgoingdType;
    //     j = i - 1;
    //     while (j >= 0 && armut[j].outgoingdType == "Spor") {
    //       armut[j + 1].outgoingdType = armut[j].outgoingdType;
    //       j--;
    //     }
    //     armut[j + 1].outgoingdType = element;
    //   }

    //   return armut;
    // }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 480,
              child: ListView.builder(
                itemCount: getByType().length,
                itemBuilder: (BuildContext contex, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Card(
                          color: Colors.blueGrey[200],
                          child: ListTile(
                            title: Text(getByType()[index][0].outgoingdType),
                          )),
                    ),
                  );
                  // containerWitgetofOutgoing(
                  //     context: context, index: index, list: getByType()[index]);
                },
              )),
        ],
      ),
    );

    // return StreamBuilder(
    //   stream: outgoingProvider.dailyOutgoingAsStream(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     print('StreamBuilder: ${snapshot.connectionState}');
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       if (snapshot.hasData != null) {
    //         debugPrint(snapshot.data.toString());
    //         _listOfOutgoings = snapshot.data;
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
