
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/screens/email/sign_in_with_email.dart';
import 'package:homesweethome/screens/home.dart';
import 'package:homesweethome/screens/login.dart';
import 'package:homesweethome/services/auth.dart';



class Register extends StatefulWidget  {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  bool _textcontrol = true;
  bool _textcontrol2 = true;

  var _formKey = GlobalKey<FormState>();
   String error;
  String _email = '';
  String _password = '';
  // String _name = "";
  

  TextEditingController _emailCont = TextEditingController();
  // TextEditingController _nameCont = TextEditingController();
  TextEditingController _passwordCont = TextEditingController();
  TextEditingController _passwordCheckCont = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(FontAwesomeIcons.user),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                })
          ],
          backgroundColor: Colors.cyan,
          title: Center(
              child: Text(
            "Yeni Kayıt",
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
///////////////////////////////////////////////////////////////////////////////////
                  // ListTile(
                  //   title: TextFormField(
                  //     validator: (value) =>
                  //         value.isEmpty ? 'Lütfen isminizi giriniz' : null,
                  //     controller: _nameCont,
                  //     showCursor: true,
                  //     decoration: InputDecoration(
                  //       fillColor: Colors.white,
                  //       prefixIcon: Icon(Icons.email),
                  //       hintText: 'Kayıt olmak için bir isim giriniz',
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(20.0),
                  //         borderSide: BorderSide(color: Colors.cyan, width: 2),
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(20.0),
                  //         borderSide: BorderSide(color: Colors.cyan),
                  //       ),
                  //       labelText: "Name",
                  //       labelStyle: TextStyle(
                  //           color: Colors.black, fontWeight: FontWeight.bold),
                  //     ),
                  //     onChanged: (a) {
                  //       // setState(() => _name = a);
                  //     },
                  //   ),
                  // ),

                  Divider(),

                  ListTile(
                      title: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Geçerli bir Email giriniz' : null,
                    controller: _emailCont,
                    showCursor: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Kayıt olmak için mailinizi giriniz',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.cyan, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onChanged: (a) {
                      setState(() => _email = a);
                    },
                  )),

                  Divider(),

///////////////////////////////////////////////////////////////////////////////////
                  ListTile(
                      title: TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Şifre kısmı boş bırakılamaz!';
                      } else if (value.length < 6) {
                        return 'Şifreniz en az 6 karakter içermeli!';
                      } else {
                        return null;
                      }
                    },
                    obscureText: _textcontrol2,
                    controller: _passwordCont,
                    showCursor: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_textcontrol2
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() => _textcontrol2 = !_textcontrol2);
                          }),
                      //prefixIcon: Icon(FontAwesomeIcons.key),
                      hintText: 'Lütfen şifrenizi giriniz',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.cyan, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      labelText: "Şifre",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onSaved: (a) {
                      setState(() => _passwordCont.text = a);
                    },
                  )),
///////////////////////////////////////////////////////////////////////////////////

                  ListTile(
                      title: TextFormField(
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Şifre kısmı boş bırakılamaz!';
                      } else if (value != _passwordCont.text) {
                        return 'Girilen şifreler uyuşmamaktadır!';
                      } else {
                        return null;
                      }
                    },
                    // ignore: missing_return
                    obscureText: _textcontrol,
                    controller: _passwordCheckCont,
                    showCursor: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(_textcontrol
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() => _textcontrol = !_textcontrol);
                          }),
                      // prefixIcon: Icon(FontAwesomeIcons.key),
                      hintText: 'Lütfen şifrenizi giriniz',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.cyan, width: 2),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      labelText: "Şifre Tekrarı",
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onChanged: (a) {
                      setState(() => _password = a);
                    },
                  )),
                  SizedBox(height: 10.0),
///////////////////////////////////////////////////////////////////////////////////

                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 23),
                        child: Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.cyan, width: 2),
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Color(0xffffffff),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.signInAlt,
                                  color: Color(0xff4754de),
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  ' Kaydol',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await _auth
                                    .registerWithEmail(_email, _password)
                                    .whenComplete(() {
                                     Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MyHomePage()),
                                  );
                                }).catchError((e) {
                                  print(e.toString());

                                  return null;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
///////////////////////////////////////////////////////////////////////////////////

                      Container(
                          child: Align(
                        alignment: Alignment.center,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.cyan, width: 2),
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Color(0xffffffff),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.user,
                                color: Color(0xff4754de),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                ' Zaten Üyeyim',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Login()));
                          },
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
