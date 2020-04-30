import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homesweethome/screens/login.dart';
import 'package:homesweethome/screens/home.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  
  const Wrapper({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if(userSnapshot.connectionState==ConnectionState.active){
      return userSnapshot.hasData ? MyHomePage(): Login();
    }
    return Center(
            child: FlareActor(
              "assets/circular.flr",
              animation: "circular",
              fit: BoxFit.contain,
            ),
          );
  }
}
