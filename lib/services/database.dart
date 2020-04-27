import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices(this.uid);

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String name, String email) async {
    return await userCollection
        .document(uid)
        .setData({'name': name, 'email': email});
  }
}

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

}