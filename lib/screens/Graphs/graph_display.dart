import 'package:flutter/material.dart';
import 'package:homesweethome/shared/my_appbar.dart';
import 'package:homesweethome/shared/my_drawer.dart';

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: MyDrawer(), appBar: myAppbar()),
    );
  }
}
