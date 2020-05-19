import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homesweethome/auth_witget_builder.dart';

import 'package:homesweethome/services/auth.dart';
import 'package:homesweethome/services/list_service.dart';
import 'package:homesweethome/wrapper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<AuthService>(
          create: (BuildContext context) => AuthService(),
        ),

         ChangeNotifierProvider<ListService>(
          create: (_) => ListService(),
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
              primaryColor: Colors.white,
              accentColor: Colors.cyan,
            ),
            home: Wrapper(
              userSnapshot: snp,
            ),
          );
        },
      ),
    );
  }
}
