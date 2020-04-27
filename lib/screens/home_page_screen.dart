import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homesweethome/shared/my_drawer.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page",textAlign: TextAlign.center,),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: (){}),
          IconButton(icon: Icon(Icons.star), onPressed: (){})
        ],
      ),
      drawer: MyDrawer(),
      body: Container(
        child: Text("Home Page"),
      ),
    );
  }

}