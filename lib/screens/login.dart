//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/screens/home.dart';
import 'package:homesweethome/screens/email/sign_in_with_email.dart';
import 'package:homesweethome/services/auth.dart';
import 'package:provider/provider.dart';
import 'ShoppingList/list_display.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 35, 65, 1),
        title: Center(
            child: Text(
          "Sisteme Giriş",
          style: TextStyle(
              fontFamily: "Lobster",
              fontWeight: FontWeight.w400,
              fontSize: 25,
              color: Colors.white),
        )),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/arka.png",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),

///////////////////////////////////////////////////////////////////////////////////////////

                  Container(
                    width: 250.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.cyan),
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xffffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.solidEnvelope,
                            color: Colors.lightGreen,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Email ile giriş yap',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignInWithEmail(),
                                fullscreenDialog: true));
                      },
                    ),
                  ),

///////////////////////////////////////////////////////////////////////////////////////////

                  Container(
                    width: 250.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.cyan),
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xffffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.google,
                            color: Color(0xffCE107C),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Google ile giriş yap',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        try {
                          await _auth.signInWithGoogle();

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return MyHomePage();
                          }));
                        } catch (e) {}
                      },
                    ),
                  ),
///////////////////////////////////////////////////////////////////////////////////////////

                  Container(
                    width: 250.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.cyan),
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xffffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.facebookF,
                            color: Color(0xff4754de),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Facebook ile giriş yap',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        try {
                          await _auth.signInAnonymously();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ListPage()));
                        } catch (e) {
                          print(e.toString());
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
