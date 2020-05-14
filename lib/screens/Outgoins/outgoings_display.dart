import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/screens/Outgoins/outgoins_create_add.dart';
import 'package:homesweethome/shared/my_appbar.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'daily_outgoing.dart';
import 'monthly_outgoings.dart';
import 'weekly_outgoings.dart';

class OutgoingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    builder: (context) =>

                        CreateAndAddOutgoing()));


          },
          elevation: 5,
          highlightElevation: 3,
        ),
        resizeToAvoidBottomInset: false,

        
        body: TabBarView(
          children: <Widget>[
            DailyOutgoing(),
            WeeklyOutgoing(),
            MounthlyOutgoing(),
            Center(child: Text("Total Outgoings")),
          ],
        ),
      ),
    );
  }
}