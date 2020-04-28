import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/screens/login.dart';
import 'package:homesweethome/services/auth.dart';

class ResetPassword extends StatefulWidget {
  
  final Function toggleView;
  ResetPassword({this.toggleView});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthService _auth = AuthService();

  bool isLoading = false;

  var _formKey = GlobalKey<FormState>();

  String _email = '';

  TextEditingController _emailCont = TextEditingController();

  @override
  Widget build(BuildContext context) {


    
    return isLoading
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.user,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Giris()));
                    })
              ],
              backgroundColor: Colors.cyan,
              title: Center(
                  child: Text(
                "Şifre Resetleme",
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
                      ListTile(
                          title: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Geçerli bir Email giriniz' : null,
                        controller: _emailCont,
                        showCursor: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Kayıtlı Emailinizi giriniz',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.cyan, width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.cyan, width: 2),
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
                      SizedBox(height: 10.0),
                      Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 23),
                              child: Align(
                                alignment: Alignment.center,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.cyan, width: 2),
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
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
                                        ' Submit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      await _auth.forgorPassword(
                                        _email,
                                      );
                                    }
                                  },
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              child: Align(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.cyan, width: 2),
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
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
                                    ' Zaten Üyeyim!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18.0),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return Giris();
                                }));
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
