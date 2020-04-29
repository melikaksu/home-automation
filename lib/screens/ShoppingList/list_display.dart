import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/services/auth.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
        final _auth = Provider.of<AuthService>(context, listen: false);
        return
   

    Scaffold(
      drawer: MyDrawer(),
       floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.playlist_add,size: 30,),
          onPressed: () {
          
          },
          elevation: 5,
          highlightElevation: 3,
        ),
      appBar:AppBar(
                    leading: Builder(builder: (BuildContext context){
                      return IconButton(
                          icon: Icon(
                            FontAwesomeIcons.bars,
                            color: Color(0xff2d386b),
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer());
                    }), 
                    centerTitle: true,
                    title: Text(
                      'GİDER LİSTESİ',
                      style: TextStyle(
                          fontFamily: "hadowsIntoLight",
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                          color: Color(0xff2d386b)),
                    ),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(
                            FontAwesomeIcons.shareAlt,
                            color: Color(0xff2d386b),
                          ),
                          onPressed: () {}),
            
                    ],
                    elevation: 0.0,
                    backgroundColor: Colors.white),
      body: Container(),
    );
  }


}