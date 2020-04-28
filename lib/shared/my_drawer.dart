import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/screens/login.dart';
import 'package:homesweethome/services/auth.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final AuthService _auth = AuthService();
  String _userName = "";
  String _image;
  String _userMail = "";

  getImage() async {
    try {
      await FirebaseAuth.instance.currentUser().then((user) {
        setState(() => _image = user.photoUrl);
      });
    } catch (e) {
      return null;
    }
  }

  _getUserName() async =>
      await FirebaseAuth.instance.currentUser().then((user) {
        setState(() => this._userName = user.displayName);
      });

  _getUserMail() async =>
      await FirebaseAuth.instance.currentUser().then((user) {
        setState(() => this._userMail = user.email);
      });

  @override
  void initState() {
    _getUserMail();
     getImage();
    _getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            accountName: Text(_userName),
            accountEmail: Text(_userMail),
            currentAccountPicture: ClipOval(
                child: _image != null
                    ? Image.network(_image, fit: BoxFit.cover)
                    : Container()),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Color(0xff2d386b),
            ),
            title: Text(
              "Çıkış",
              style: TextStyle(color: Color(0xff2d386b)),
            ),
            onTap: () {
              _auth.signOutGoogle();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context)=>
          Giris(),
          fullscreenDialog: true,
             ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.drafts,
              color: Color(0xff2d386b),
            ),
            title: Text(
              "Draft",
              style: TextStyle(color: Color(0xff2d386b)),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.archive,
              color: Color(0xff2d386b),
            ),
            title: Text(
              "Arşiv",
              style: TextStyle(
                color: Color(0xff2d386b),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomLeft,
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.cogs,
                  color: Color(0xff2d386b),
                ),
                title: Text(
                  "Ayarlar",
                  style: TextStyle(color: Color(0xff2d386b)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
