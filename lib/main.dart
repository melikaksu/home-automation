import 'package:flutter/material.dart';
import 'package:homesweethome/services/auth.dart';
import 'package:homesweethome/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (BuildContext context)=> AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Giderler',
        theme: ThemeData(
            cursorColor: Colors.black,
            //brightness: Brightness.dark,
            primarySwatch: Colors.cyan,
            primaryColor: Colors.cyan,
            accentColor: Color(0xff2d386b),),
      
        home:  Wrapper(),
      ), 
    );
  }
}

