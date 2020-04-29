import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homesweethome/screens/login.dart';
import 'package:homesweethome/screens/home.dart';
import 'package:homesweethome/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
 

  final authService =
        Provider.of<AuthService>(context, listen: false);

    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {

        if (snapshot.connectionState == ConnectionState.active) {
            if (!snapshot.hasData || snapshot.data == null) {
           return Login();
        }

          return MyHomePage();
          
        }
        return Center(
            child: FlareActor(
              "assets/circular.flr",
              animation: "circular",
              fit: BoxFit.contain,
            ),
          );
      },
    );

//    if(user == null){
//      return
//    }
//    else{
//
//    }
  }
}
