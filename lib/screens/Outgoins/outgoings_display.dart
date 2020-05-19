import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/screens/Outgoins/all_outgoings.dart';
import 'package:homesweethome/screens/Outgoins/outgoins_create_add.dart';
import 'package:homesweethome/services/outgoing_service.dart';
import 'package:homesweethome/shared/my_appbar.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:provider/provider.dart';
import 'daily_outgoing.dart';
import 'monthly_outgoings.dart';
import 'weekly_outgoings.dart';
class OutgoingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Outgoing> _listOfOutgoings; //_outgoings;
    OutgoingService outgoingProvider = Provider.of<OutgoingService>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: myAppbar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: Icon(FontAwesomeIcons.plus),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateAndAddOutgoing()));
          },
          elevation: 5,
          highlightElevation: 3,
        ),
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
            stream: outgoingProvider.fetchOutgoingAsStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print('StreamBuilder: ${snapshot.connectionState}');
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  _listOfOutgoings = snapshot.data;
                  return MultiProvider(
                    providers: [
                    Provider<List<Outgoing>>.value(value: _listOfOutgoings),
                    ],
                    child: TabBarView(
                      children: <Widget>[
                        DailyOutgoing(),
                        WeeklyOutgoing(),
                        MonthlyOutgoing(),
                        AllOutgoing()
                      ],
                    ),
                  );
                }
              }
              return Container();
            }),
      ),
    );
  }
}
