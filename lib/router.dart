import 'package:flutter/material.dart';
import 'package:homesweethome/screens/home.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings at) {

    switch (at.name) {
      case '/' :
        return  MaterialPageRoute(
          builder: (_)=> MyHomePage()
        );
      // case '/addProduct' :
      //   return MaterialPageRoute(
      //     builder: (_)=> AddProduct()
      //   ) ;
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