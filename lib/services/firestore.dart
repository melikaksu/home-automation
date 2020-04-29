import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:homesweethome/models/avatar_reference.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/services/auth.dart';
import 'dart:async';

import 'package:homesweethome/services/firestore_path.dart';

   var at = AuthService();

//   String name;

//   static userinfo() async {


//   var currentUser = await _auth.currentUser();

//   String fuser= await Future.delayed(Duration.zero, () => currentUser.toString());
//   return fuser;
// }
  



// final CollectionReference myCollection=Firestore.instance.collection('list');

 class FirestoreService {
   final String uid;
   FirestoreService([this.uid]):assert(uid!=null);
   
//  FirestoreService({ @required this.uid}) : assert(uid != null);
  


    String value;
    static String col=" ";
    String get collectionName {
    return value;
     }
     set name(String a){
      col=a;
    } 
   
    

  final CollectionReference myCollection =
      Firestore.instance.collection(col);



//////////////////////////////////////////////////////////////////////////////

  Future<Outgoing> createOutgoingList({
    String name,
    String type,
    int quantity
  }) async {

      final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.document());
     
      final Outgoing outgoings = Outgoing(name,type,quantity);
      final Map<String, dynamic> data = outgoings.toMap();
      await tx.set(ds.reference, data);
      return data;
    };


    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Outgoing.fromMap(mapData);
    }).catchError((onError) {
      print("Error:$onError");
      return null;
    });
  }
//////////////////////////////////////////////////////////////////////////////

  Stream<QuerySnapshot> getOutgoingList({int offset, int limit,}) {
    Stream<QuerySnapshot> snapshots = myCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }


  // Sets the avatar download url
  Future<void> setAvatarReference(AvatarReference avatarReference) async {
    final path = FirestorePath.avatar(uid);
    final reference = Firestore.instance.document(path);
    await reference.setData(avatarReference.toMap());
  }

  // Reads the current avatar download url
  Stream<AvatarReference> avatarReferenceStream() {
    final path = FirestorePath.avatar(uid);
    final reference = Firestore.instance.document(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => AvatarReference.fromMap(snapshot.data));
  }


}
