import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:homesweethome/screens/login.dart';
import 'package:homesweethome/screens/home.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
       return StreamBuilder(
       stream: FirebaseAuth.instance.onAuthStateChanged,
       builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {

        //  var at= snapshot.data;
         
        if(snapshot.connectionState==ConnectionState.waiting){
           return SpinKitWave(
             color: Colors.deepOrange,
             size: 40,
           );
         }
         if(!snapshot.hasData || snapshot.data==null){
           return Login();
         }
         return   MyHomePage();

     },);


//    if(user == null){
//      return
//    }
//    else{
//
//    }

  }
}
