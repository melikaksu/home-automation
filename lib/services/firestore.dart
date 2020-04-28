import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homesweethome/models/task.dart';
import 'package:homesweethome/services/auth.dart';
import 'dart:async';

   var at = AuthService();

//   String name;

//   static userinfo() async {


//   var currentUser = await _auth.currentUser();

//   String fuser= await Future.delayed(Duration.zero, () => currentUser.toString());
//   return fuser;
// }
  



// final CollectionReference myCollection=Firestore.instance.collection('list');

 class FirestoreService {
    String value;
    static String col="init";
    String get collectionName {
    return value;
     }
     set name(String a){
      col=a;
    } 
   
    

  final CollectionReference myCollection =
      Firestore.instance.collection(col);



//////////////////////////////////////////////////////////////////////////////

  Future<Task> createTaskList({
    String name,
    String type,
    int quantity
  }) async {

      final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.document());
      final Task tasks = Task(name,type,quantity);
      final Map<String, dynamic> data = tasks.toMap();
      await tx.set(ds.reference, data);
      return data;
    };


    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Task.fromMap(mapData);
    }).catchError((onError) {
      print("Error:$onError");
      return null;
    });
  }
//////////////////////////////////////////////////////////////////////////////

  Stream<QuerySnapshot> getTaskList({int offset, int limit,}) {
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
