import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/user.dart';
import 'package:homesweethome/screens/home.dart';
import 'package:homesweethome/screens/email/password_reset.dart';
import 'package:homesweethome/screens/email/register.dart';
import 'package:homesweethome/services/auth.dart';
import 'package:provider/provider.dart';

class SignInWithEmail extends StatefulWidget {

  final String registerMail;
  SignInWithEmail([this.registerMail]);

  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {


  bool _textcontrol2 = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  TextEditingController _emailCont = TextEditingController();
  TextEditingController _passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
      
      
      final _auth = Provider.of<AuthService>(context,listen: false);

      Future <void> _signIn () async{
        try{
         User  user= await _auth.signInWithEmail(_email, _password);
         
         return user.userUid;
    
        
        } catch(e)
        {
          print(e.toString());
   
          return null;}
        
      }

    // setState(() {
    //   if (widget.registerMail!=null && widget.registerMail!=''){
    //     _emailCont.text=widget.registerMail;
    //   }

    // });

    return StreamBuilder<User>(
      stream: _auth.onAuthStateChanged,

      builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
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
                          Text(
                            "Üye ol",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Register()));
                      })
                ],
                backgroundColor: Colors.cyan,
                title: Center(
                    child: Text(
                  "Sisteme Giriş",
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
                          validator: (value) => value.isEmpty
                              ? 'Geçerli bir Email giriniz'
                              : null,
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onSaved: (a) {
                            setState(() {
                              _email = _emailCont.text;
                            });
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(color: Colors.cyan, width: 2),
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(_textcontrol2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(
                                      () => _textcontrol2 = !_textcontrol2);
                                }),
                            //prefixIcon: Icon(FontAwesomeIcons.key),
                            hintText: 'Lütfen şifrenizi giriniz',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(width: 2),
                            ),
                            labelText: "Şifre",
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onSaved: (a) {
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
                                        side: BorderSide(
                                            color: Colors.cyan, width: 2),
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    color: Color(0xffffffff),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.signInAlt,
                                          color: Color(0xff4754de),
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          ' Giriş',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                      
                                       _signIn().then((a)=>Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        MyHomePage()))).catchError((e)=>e);
                                       
                                      

                                      
                                        //  _signIn()
                                        //  .whenComplete(() { 
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //             builder: (BuildContext
                                        //                     context) =>
                                        //                 MyHomePage()));
                                        //   });
                                       
                                        

                                        // dynamic res = await _auth
                                        //     .signInWithEmail(_email, _password);
                                        // if (res == null) {
                                        //   print('Errorrrrrrr');
                                        // }
                                        // else {
                                        //   Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder:
                                        //               (BuildContext context) =>
                                        //                   MyHomePage()));
                                        // }
                                      }
                                    },
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),

///////////////////////////////////////////////////////////////////////////////////
                            Container(
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
                                      FontAwesomeIcons.user,
                                      color: Color(0xff4754de),
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      ' Şifremi unuttum!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return ResetPassword();
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
      },
    );
  }
}
