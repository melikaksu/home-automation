import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/services/firestore_service.dart';
import 'package:provider/provider.dart';

class Dialogs {
  informations(BuildContext context, String title, String description) {
    TextEditingController _nameController = TextEditingController();
    // GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
    var listProvider = Provider.of<FirestoreDatabase>(context, listen: false);
    Timestamp createdAt = Timestamp.now();

    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
                Form(
                  child: ListTile(
                    title: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Eleman eklemediniz!' : null,
                      controller: _nameController,
                      showCursor: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                        filled: true,
                        prefixIcon: Icon(FontAwesomeIcons.listAlt),
                        hintText: 'Aklınızda ne var? ',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide:
                              BorderSide(color: Colors.cyan, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                      ),
                      // onSaved: (a) {
                      //   setState(() {
                      //     name = a;
                      //     _nameController.clear();
                      //   });
                      // },
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () async {
        
                    await listProvider.addList(MyList(
                        name: _nameController.text, createdAt: createdAt));
                    _nameController.clear();
                  
                },
                child: Text("Ok")),
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel"))
          ],
        );
      },
    );
  }
}
