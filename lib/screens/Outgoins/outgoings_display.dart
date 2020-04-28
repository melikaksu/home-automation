import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/shared/my_appbar.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'dayly_outgoing.dart';
import 'outgoins_creator.dart';

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

                        OutgoingScreen(Outgoing('', '',0,))));


          },
          elevation: 5,
          highlightElevation: 3,
        ),
        resizeToAvoidBottomInset: false,

        
        body: TabBarView(
          children: <Widget>[
            DaylyOutgoing(),
            Center(child: Text("Weekly Outgoings")),
            Center(child: Text("Mountly Outgoins")),
            Center(child: Text("Total Outgoings")),
          ],
        ),
      ),
    );
  }
}