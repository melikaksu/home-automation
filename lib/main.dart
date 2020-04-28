import 'package:flutter/material.dart';
import 'package:homesweethome/models/user_details.dart';
import 'package:homesweethome/services/auth.dart';
import 'package:homesweethome/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
<<<<<<< HEAD
<<<<<<< HEAD
        title: 'Giderler ve Alışveriş Listessi ',
=======
        title: 'Flutter Demo',
>>>>>>> 131ee040a7fa10283f16347a68595722443d60aa
=======
        title: 'Giderler',
>>>>>>> d6d6e80810d8128b8de378fbc6e8dabbc3c6a9e6
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

