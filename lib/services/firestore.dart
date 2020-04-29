import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'dart:async';


//   String name;

//   static userinfo() async {


//   var currentUser = await _auth.currentUser();

//   String fuser= await Future.delayed(Duration.zero, () => currentUser.toString());
//   return fuser;
// }
  



// final CollectionReference myCollection=Firestore.instance.collection('list');

 class FirestoreService {

   final String uid;
  //  FirestoreService([this.uid]);
   
 FirestoreService({this.uid});


  final CollectionReference myCollection =
      Firestore.instance.collection("Yeni Bir Başlangıç");



//////////////////////////////////////////////////////////////////////////////

  Future<Outgoing> createOutgoingList({
    String name,
    String type,
    int quantity
  }) 
  async {
      final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.document(uid));
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

}
