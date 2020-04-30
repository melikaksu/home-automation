import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/user.dart';
import 'package:homesweethome/screens/login.dart';
import 'package:homesweethome/services/auth.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    final _auth = Provider.of<AuthService>(context, listen: false);

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            accountName: Text(user.userName != null ? user.userName : "Anonymous"),
            accountEmail: Text(user.userEmail != null ? user.userEmail : "Anonymous"),
            currentAccountPicture: ClipOval(
              child: user.photoUrl != null
                  ? Image.network(user.photoUrl, fit: BoxFit.cover)
                  : Center(
                      child: user.userName != null
                          ? CircularProgressIndicator()
                          : Container(),
                    ),
            ),
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Login(),
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
