import 'package:flutter/material.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/screens/ShoppingList/add_list.dart';
import 'package:homesweethome/screens/ShoppingList/list_details.dart';
import 'package:homesweethome/screens/home.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings at) {


    switch (at.name) {
      case '/' :
        return  MaterialPageRoute(
          builder: (_)=> MyHomePage()
        );
      case '/addList' :
        return MaterialPageRoute(
          builder: (_)=> AddList()
        ) ;
      case '/listDetails' :
        return MaterialPageRoute(
            builder: (_)=> ListDetails()
        ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${at.name}'),
              ),
            ));
    }
  }
}