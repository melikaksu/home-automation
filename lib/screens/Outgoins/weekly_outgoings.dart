import 'package:flutter/material.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/services/outgoing_service.dart';
import 'package:homesweethome/shared/funtions/get_days.dart';
import 'package:homesweethome/shared/witgets/witget_of_outgoings.dart';
import 'package:provider/provider.dart';

class WeeklyOutgoing extends StatefulWidget {
  @override
  _WeeklyOutgoingState createState() => _WeeklyOutgoingState();
}

class _WeeklyOutgoingState extends State<WeeklyOutgoing> {
  List<Outgoing> _listOfOutgoings; //_outgoings;

  @override
  Widget build(BuildContext context) {
    OutgoingService outgoingProvider = Provider.of<OutgoingService>(context);

    return StreamBuilder(
      stream: outgoingProvider.weeklyOutgoingAsStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('StreamBuilder: ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData != null) {
            _listOfOutgoings = snapshot.data;
            print(DateTime.parse(getSunday().toString()));

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
