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
    
 

  // final authService =
  //       Provider.of<AuthService>(context, listen: false);

  //   return StreamBuilder<User>(
  //     stream: authService.onAuthStateChanged,
  //     builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
  //       final user=snapshot.data;

  //       if (snapshot.connectionState == ConnectionState.active) {
  //           if (!snapshot.hasData || snapshot.data == null) {
  //          return Login();
  //       }

  //         return Provider<User>.value(
  //           value: user,
  //           child: MyHomePage());
          
  //       }
  //       return Center(
  //           child: FlareActor(
  //             "assets/circular.flr",
  //             animation: "circular",
  //             fit: BoxFit.contain,
  //           ),
  //         );
  //     },
  //   );

//    if(user == null){
//      return
//    }
//    else{
//
//    }
  }
}
