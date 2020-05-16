import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs{

 informations(BuildContext context,String title,String description) async{

  return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(children: <Widget>[
           Text(description),
           TextField(
             

           )
          ],

      
          ),

        ),
        actions: <Widget>[
          FlatButton(onPressed: ()=>Navigator.pop(context)
          , child: Text("Ok")
          ) ,FlatButton(onPressed: ()=>Navigator.pop(context)
          , child: Text("Cancel")
          )
        ],



      );
      
    },
    
    );


}


}