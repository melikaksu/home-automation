import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/models/user.dart';
import 'dart:async';

import 'package:homesweethome/notifiers/list_notifier.dart';

 class OutgoingService {
   User user;
   static String uid;
   OutgoingService([uid]);
   set(){
     uid=user.userUid;
   } 

   final CollectionReference outgoingCollections =
   Firestore.instance.collection(uid==null?" ":uid);

   final CollectionReference lisCollection =
   Firestore.instance.collection("lists");



//////////////////////////////////////////////////////////////////////////////

  Future<Outgoing> createOutgoingList({String name,String type,int quantity}) async {
      final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(outgoingCollections.document());
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
    Stream<QuerySnapshot> snapshots = outgoingCollections.snapshots();
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
   }

  

}
  getListofMyList(ListNotifier listNotifier)
   async{
     final CollectionReference lisCollection =
         Firestore.instance.collection("list");

     QuerySnapshot snapshot= await lisCollection.getDocuments();
     List<MyList> _listOfArmut=[];
     snapshot.documents.forEach((doc){
       MyList armut=MyList.fromMap(doc.data,doc.documentID);
       _listOfArmut.add(armut);
     }); 
     
     listNotifier.listofMyList=_listOfArmut;
   }
   
