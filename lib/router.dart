import 'package:flutter/material.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/screens/ShoppingList/add_list.dart';
import 'package:homesweethome/screens/home.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings at) {

    MyList myList;

    switch (at.name) {
      case '/' :
        return  MaterialPageRoute(
          builder: (_)=> MyHomePage()
        );
      case '/addList' :
        return MaterialPageRoute(
          builder: (_)=> AddList(myList)
        ) ;
      // case '/productDetails' :
      //   return MaterialPageRoute(
      //       builder: (_)=> ProductDetails(product: _at,)
      //   ) ;
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