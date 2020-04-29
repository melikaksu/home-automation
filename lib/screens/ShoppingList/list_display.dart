import 'package:flutter/material.dart';
import 'package:homesweethome/models/avatar_reference.dart';
import 'package:homesweethome/services/firebase_storage_service.dart';
import 'package:homesweethome/services/firestore.dart';
import 'package:homesweethome/services/image_picker.dart';
import 'package:homesweethome/shared/avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {

    Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // 1. Get image from picker
      final imagePicker =
          Provider.of<ImagePickerService>(context, listen: false);
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        // 2. Upload to storage
        final storage =
            Provider.of<FirebaseStorageService>(context, listen: false);
        final downloadUrl = await storage.uploadAvatar(file: file);
        // 3. Save url to Firestore
        final database = Provider.of<FirestoreService>(context, listen: false);
        await database.setAvatarReference(AvatarReference(downloadUrl));
        // 4. (optional) delete local file as no longer needed
        await file.delete();
      }
    } catch (e) {
      print(e);
    }
  }

 Widget _buildUserInfo({BuildContext context}) {
    final database = Provider.of<FirestoreService>(context, listen: false);
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(),
      builder: (context, snapshot) {
        final avatarReference = snapshot.data;
        return Avatar(
          photoUrl: avatarReference?.downloadUrl,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
          onPressed: () => _chooseAvatar(context),
        );
      },
    );
  }

    
    return
    Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () {},
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Column(
            children: <Widget>[
              _buildUserInfo(context: context),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ); 

    // Scaffold(
    //   drawer: MyDrawer(),
    //    floatingActionButton: FloatingActionButton(
    //       backgroundColor: Colors.blueGrey,
    //       child: Icon(Icons.playlist_add,size: 30,),
    //       onPressed: () {
          
    //       },
    //       elevation: 5,
    //       highlightElevation: 3,
    //     ),
    //   appBar:AppBar(
    //                 leading: Builder(builder: (BuildContext context){
    //                   return IconButton(
    //                       icon: Icon(
    //                         FontAwesomeIcons.bars,
    //                         color: Color(0xff2d386b),
    //                       ),
    //                       onPressed: () => Scaffold.of(context).openDrawer());
    //                 }), 
    //                 centerTitle: true,
    //                 title: Text(
    //                   'GİDER LİSTESİ',
    //                   style: TextStyle(
    //                       fontFamily: "hadowsIntoLight",
    //                       fontWeight: FontWeight.bold,
    //                       fontStyle: FontStyle.italic,
    //                       fontSize: 25,
    //                       color: Color(0xff2d386b)),
    //                 ),
    //                 actions: <Widget>[
    //                   IconButton(
    //                       icon: Icon(
    //                         FontAwesomeIcons.shareAlt,
    //                         color: Color(0xff2d386b),
    //                       ),
    //                       onPressed: () {}),
            
    //                 ],
    //                 elevation: 0.0,
    //                 backgroundColor: Colors.white),
    //   body: Container(),
    // );
  }


}