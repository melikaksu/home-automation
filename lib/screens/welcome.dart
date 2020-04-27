import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/screens/home_page_screen.dart';
import 'package:homesweethome/screens/sign_in_wit_email.dart';
import 'package:homesweethome/services/auth.dart';

class Welcome extends StatefulWidget {
  
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

    final AuthService _auth = AuthService();

 
  var _formKey = GlobalKey<FormState>();
 
//  TextEditingController _email = TextEditingController();
//  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Center(
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontFamily: "Lobster",
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                ),
              )),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 65),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  

                
                  Column(
      
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Container(
                          width: 250.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.cyan),
                                  borderRadius:
                                  new BorderRadius.circular(30.0)),
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18.0),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return SignInWithEmail();
                                    }));
                              },
                            ),
                          )),
                      ListTile(
                        title: Center(
                          child: Container(
                              width: 250.0,
                              child: Align(
                                alignment: Alignment.center,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.cyan),
                                        borderRadius:
                                        new BorderRadius.circular(30.0)),
                                    color: Color(0xffffffff),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.google,
                                          color: Color(0xffCE107C),
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          'Google ile giriş yap',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {

                                    await _auth.signInWithGoogle().whenComplete((){
                                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                         return HomePage();
                                       }));
                                     
                                     });

                                    }),
                              )),
                        ),
                      ),
                      Container(
                          width: 250.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.cyan),
                                  borderRadius:
                                  new BorderRadius.circular(30.0)),
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18.0),
                                  ),
                                ],
                              ),
                              onPressed: () {},
                            ),
                          )),
                    ],
                ),
            
               ],
              ),
            ),
          ),
        ));
  }
}
