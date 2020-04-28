import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Graphs/graph_display.dart';
import 'Outgoins/outgoings_display.dart';
import 'ShoppingList/list_display.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
            color: Colors.blueGrey ,
            animationCurve: Curves.easeInOutCubic,
            backgroundColor: Colors.white,
            buttonBackgroundColor:Colors.white,
            animationDuration: Duration(milliseconds: 300),
            height: 50.0,
            items: <Widget>[
               Icon(FontAwesomeIcons.wallet,size:30,color: Colors.black87,),
               Icon(FontAwesomeIcons.chartPie ,size:30,color:Colors.black87,),
               Icon(FontAwesomeIcons.listAlt ,size:30,color: Colors.black87,)
            ],
            index: _index,    
            onTap: (a) {
              setState(() {
                _index = a;
              });
            },
          ),
          body: [
            OutgoingPage(),
            GraphPage(),
            ListPage()
          ].elementAt(_index),
        ));
  }
}
 