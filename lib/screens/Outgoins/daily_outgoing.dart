import 'package:flutter/material.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/shared/witgets/witget_of_outgoings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DailyOutgoing extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    List listOfCatagory = ["Seyahat", "Spor", "Alışveriş"];

    List<Outgoing> _outgoing = Provider.of<List<Outgoing>>(context);
    
   List<Outgoing> sortList(){
     List<Outgoing> tempList=[];
     String temp;
        DateTime today = DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
        List<Outgoing> list = [];
      for (var i = 0; i < _outgoing.length; i++) {
        if (_outgoing[i].createdAt.toDate().isAfter(today)) {
          list.add(_outgoing[i]);
        }
      }
      list.sort((a,b){
        return a.outgoingdType.toLowerCase().compareTo(b.outgoingdType.toLowerCase());
      });
      for(var i=1;i<=list.length;i++){
      var j=i-1;
      temp=list[i-1].outgoingdType;
       //alışveriş
       print(i.toString());
        print("temp: "+temp);

      while(j>=0 && temp!=list[j+1].outgoingdType){
       print("temp: "+temp);
        tempList.add(list[j]);
        print("TempList: "+tempList[j].outgoingdType);
        temp=list[j+1].outgoingdType;
        print("After temp: "+temp);
        // list.skip(j+1);
        j--;
        }  
        


         }

          
      return  tempList;
   } 


    List<Outgoing> getDailyOutgoings() {
      DateTime today =
          DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
      List<Outgoing> list = [];
      for (var i = 0; i < _outgoing.length; i++) {
        if (_outgoing[i].createdAt.toDate().isAfter(today)) {
          list.add(_outgoing[i]);
        }
        print(list[i].outgoingdType);
      }
      return list;
    }

    List<Outgoing> ctgOutgoing(List<Outgoing> armut) {
      int j;
      String element;

      for (int i = 1; i < armut.length; i++) {
        element = armut[i].outgoingdType;
        j = i - 1;
        while (j >= 0 && armut[j].outgoingdType == "Spor") {
          armut[j + 1].outgoingdType = armut[j].outgoingdType;
          j--;
        }
        armut[j + 1].outgoingdType = element;
      }
      
      return armut;
    }


    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 480,
    
              child: ListView.builder(
                itemCount: sortList().length,
                itemBuilder: (BuildContext contex, int index) {
                  return containerWitgetofOutgoing(
                      context: context,
                      index: index,
                      list: sortList());
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
