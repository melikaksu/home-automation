import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:homesweethome/auth_witget_builder.dart';
import 'package:homesweethome/services/auth.dart';
import 'package:homesweethome/wrapper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
        Provider<AuthService>(
          create: (BuildContext context) => AuthService(),
        ),
        Provider<FirebaseStorage>(
          create: (BuildContext context) => FirebaseStorage(),
        ),
        Provider<ImagePicker>(
          create: (BuildContext context) => ImagePicker(),
        ),
      ],
      child: AuthWidgetBuilder(
          builder: (cntx, snp) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Giderler',
            theme: ThemeData(
              cursorColor: Colors.black,
              // brightness: Brightness.dark,
              primarySwatch: Colors.cyan,
              primaryColor: Colors.cyan,
              accentColor: Color(0xff2d386b),
            ),
            home: Wrapper(userSnapshot: snp,),
          );
        },
      ),
    );
  }
}
