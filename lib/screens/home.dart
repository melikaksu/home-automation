import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/screens/second_screen.dart';
import 'package:homesweethome/my_drawer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;

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
               Icon(FontAwesomeIcons.wallet),
            
                  Icon(FontAwesomeIcons.chartPie),
          
                Icon(Icons.playlist_add)
            ],
            index: _index,    
            onTap: (a) {
              setState(() {
                _index = a;
              });
            },
          ),
          body: [
            SecondPage(),
            Text("data"),
            Text("data"),
          ].elementAt(_index),
        ));
  }
}
 