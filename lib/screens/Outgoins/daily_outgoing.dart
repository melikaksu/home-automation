import 'package:flutter/material.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/shared/witgets/witget_of_outgoings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DailyOutgoing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<Outgoing> _listOfOutgoings; //_outgoings;
    // OutgoingService outgoingProvider = Provider.of<OutgoingService>(context);
     List<Outgoing> _outgoing=Provider.of<List<Outgoing>>(context);

    List<Outgoing> getDailyOutgoings(){
       DateTime today=DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
       List<Outgoing> list=[];

       for(var i=0;i<_outgoing.length;i++){
        if(_outgoing[i].createdAt.toDate().isAfter(today)){
        if(_outgoing[i].outgoingdType=="Seyahat"){
          list.add(_outgoing[i]);
          }  
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
                  itemCount: getDailyOutgoings().length,
                  itemBuilder: (BuildContext contex, int index) {
                    return containerWitgetofOutgoing(
                    context: context, index: index, list: getDailyOutgoings());
                  },
                )
           ),
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
