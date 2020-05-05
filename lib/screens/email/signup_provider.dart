import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/services/auth.dart';
import 'package:homesweethome/services/dialog_service.dart';
import 'package:provider/provider.dart';

import '../login.dart';

class SignUp extends StatelessWidget with ChangeNotifier {
  bool _textcontrol = true;
  bool _textcontrol2 = true;

  var _formKey = GlobalKey<FormState>();
  String error;
  String _email = '';
  String _password = '';
  String _name = "";

  TextEditingController _emailCont = TextEditingController();
  TextEditingController _nameCont = TextEditingController();
  TextEditingController _passwordCont = TextEditingController();
  TextEditingController _passwordCheckCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DialogService _dialogService = DialogService();
    final auth = Provider.of<AuthService>(context);

    Future signup(String email, String password) async {
      try{
        var result = await auth.registerWithEmail(email, password);
         if(result is bool){
            await _dialogService.showDialog(
            title: 'Sign Up Failure',
            description: 'General sign up failure. Please try again later',
          );
      
        }

        else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: result,
        );
        }

      }catch(e){print(e.toString());}
      

      // if (result is bool) {
      //   if (result) {
      //   } else {
      //     await _dialogService.showDialog(
      //       title: 'Sign Up Failure',
      //       description: 'General sign up failure. Please try again later',
      //     );
      //   }
      // } else {
      //   await _dialogService.showDialog(
      //     title: 'Sign Up Failure',
      //     description: result,
      //   );
      // }
    }

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
                  ListTile(
                    title: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Lütfen isminizi giriniz' : null,
                      controller: _nameCont,
                      showCursor: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Kayıt olmak için bir isim giriniz',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.cyan, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                        labelText: "Name",
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (a) {
                         _name = a;
                        notifyListeners();
                      },
                    ),
                  ),

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
                      _email = a;
                      notifyListeners();
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
                            _textcontrol2 = !_textcontrol2;
                            notifyListeners();
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
                      _passwordCont.text = a;
                      notifyListeners();
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
                            _textcontrol = !_textcontrol;
                            notifyListeners();
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
                      _password = a;
                      notifyListeners();
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
                          child: Consumer(
                            builder:
                                (BuildContext context, value, Widget child) {
                              return RaisedButton(
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
                                      ' Kaydol',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    signup(
                                      _email,
                                      _password,
                                  );
                                  }
                                },
                              );
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
