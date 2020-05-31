import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homesweethome/auth_witget_builder.dart';
import 'package:homesweethome/services/auth.dart';
import 'package:homesweethome/wrapper.dart';
import 'package:provider/provider.dart';

import 'notifiers/category_notifier.dart';

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
        ChangeNotifierProvider<CategoryNotifier>(
          create: (BuildContext context) => CategoryNotifier(),
        ),

        //  ChangeNotifierProvider<FirestoreDatabase>(
        //   create: (_) => FirestoreDatabase(),
        //  ),

        // Provider<ImagePicker>(
        //   create: (BuildContext context) => ImagePicker(),
        // ),
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

// import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';


// class HomeScreen extends StatefulWidget {
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // Use temp variable to only update color when press dialog 'submit' button
//   ColorSwatch _tempMainColor;
//   Color _tempShadeColor;
//   ColorSwatch _mainColor = Colors.blue;
//   Color _shadeColor = Colors.blue[800];

//   void _openDialog(String title, Widget content) {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.all(6.0),
//           title: Text(title),
//           content: content,
//           actions: [
//             FlatButton(
//               child: Text('CANCEL'),
//               onPressed: Navigator.of(context).pop,
//             ),
//             FlatButton(
//               child: Text('SUBMIT'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 setState(() => _mainColor = _tempMainColor);
//                 setState(() => _shadeColor = _tempShadeColor);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _openColorPicker() async {
//     _openDialog(
//       "Color picker",
//       MaterialColorPicker(
//         selectedColor: _shadeColor,
//         onColorChange: (color) => setState(() => _tempShadeColor = color),
//         onMainColorChange: (color) => setState(() => _tempMainColor = color),
//         onBack: () => print("Back button pressed"),
//       ),
//     );
//   }

//   void _openMainColorPicker() async {
//     _openDialog(
//       "Main Color picker",
//       MaterialColorPicker(
//         selectedColor: _mainColor,
//         allowShades: false,
//         onMainColorChange: (color) => setState(() => _tempMainColor = color),
//       ),
//     );
//   }

//   void _openAccentColorPicker() async {
//     _openDialog(
//       "Accent Color picker",
//       MaterialColorPicker(
//         colors: accentColors,
//         selectedColor: _mainColor,
//         onMainColorChange: (color) => setState(() => _tempMainColor = color),
//         circleSize: 40.0,
//         spacing: 10,
//       ),
//     );
//   }

//   void _openFullMaterialColorPicker() async {
//     _openDialog(
//       "Full Material Color picker",
//       MaterialColorPicker(
//         colors: fullMaterialColors,
//         selectedColor: _mainColor,
//         onMainColorChange: (color) => setState(() => _tempMainColor = color),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Material color picker",
//             style: Theme.of(context).textTheme.headline5,
//           ),
//           const SizedBox(height: 62.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundColor: _mainColor,
//                 radius: 35.0,
//                 child: const Text("MAIN"),
//               ),
//               const SizedBox(width: 16.0),
//               CircleAvatar(
//                 backgroundColor: _shadeColor,
//                 radius: 35.0,
//                 child: const Text("SHADE"),
//               ),
//             ],
//           ),
//           const SizedBox(height: 32.0),
//           OutlineButton(
//             onPressed: _openColorPicker,
//             child: const Text('Show color picker'),
//           ),
//           const SizedBox(height: 16.0),
//           OutlineButton(
//             onPressed: _openMainColorPicker,
//             child: const Text('Show main color picker'),
//           ),
//           const Text('(only main color)'),
//           const SizedBox(height: 16.0),
//           OutlineButton(
//             onPressed: _openAccentColorPicker,
//             child: const Text('Show accent color picker'),
//           ),
//           const SizedBox(height: 16.0),
//           OutlineButton(
//             onPressed: _openFullMaterialColorPicker,
//             child: const Text('Show full material color picker'),
//           ),
//         ],
//       ),
//     );
//   }
// }