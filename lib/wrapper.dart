import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homesweethome/screens/login.dart';
import 'package:homesweethome/screens/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        //  var at= snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: FlareActor(
              "assets/circular.flr",
              animation: "circular",
              fit: BoxFit.contain,
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Login();
        }
        return MyHomePage();
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
