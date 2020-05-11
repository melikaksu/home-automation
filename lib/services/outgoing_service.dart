import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'dart:async';
import 'dart:collection';
import 'package:flutter/cupertino.dart';

//  class OutgoingService {
//    User user;
//    static String uid;
//    OutgoingService([uid]);
//    set(){
//      uid=user.userUid;
//    } 

//    final CollectionReference outgoingCollections =
//    Firestore.instance.collection(uid==null?" ":uid);

//    final CollectionReference lisCollection =
//    Firestore.instance.collection("lists");



// //////////////////////////////////////////////////////////////////////////////

//   Future<Outgoing> createOutgoingList({String name,String type,int quantity}) async {
//       final TransactionHandler createTransaction = (Transaction tx) async {
//       final DocumentSnapshot ds = await tx.get(outgoingCollections.document());
//       final Outgoing outgoings = Outgoing(name,type,quantity);
//       final Map<String, dynamic> data = outgoings.toMap();
//       await tx.set(ds.reference, data);
//       return data;
//     };
//     return Firestore.instance.runTransaction(createTransaction).then((mapData) {
//       return Outgoing.fromMap(mapData);
//     }).catchError((onError) {
//       print("Error:$onError");
//       return null;
//     });
//   }
// //////////////////////////////////////////////////////////////////////////////

//     Stream<QuerySnapshot> getOutgoingList({int offset, int limit,}) {
//     Stream<QuerySnapshot> snapshots = outgoingCollections.snapshots();
//     if (offset != null) {
//       snapshots = snapshots.skip(offset);
//     }
//     if (limit != null) {
//       snapshots = snapshots.take(limit);
//     }
//     return snapshots;
//    }

  

// }
//   getListofMyList(ListNotifier listNotifier)
//    async{
//      final CollectionReference lisCollection =
//          Firestore.instance.collection("list");

//      QuerySnapshot snapshot= await lisCollection.getDocuments();
//      List<MyList> _listOfArmut=[];
//      snapshot.documents.forEach((doc){
//        MyList armut=MyList.fromMap(doc.data,doc.documentID);
//        _listOfArmut.add(armut);
//      }); 
     
//      listNotifier.listofMyList=_listOfArmut;
//    }
   

 class OutgoingService with ChangeNotifier{
  static String  userUid;
  
  CollectionReference listref=Firestore.instance.collection("outgoings");

  // CollectionReference newList=  Firestore.instance.collection("list").document("userUid").collection('elements');
  //  Firestore.instance.collection('path').document("documentPath").collection('subCollectionPath').setData({});

  Outgoing _currentElement;
  List<Outgoing> listOfOutgoing;



  Future<List<Outgoing>> fetchOutgoing() async {
    var result = await listref.getDocuments();
    listOfOutgoing = result.documents
        .map((doc) => Outgoing.fromMap(doc.data, doc.documentID))
        .toList();
    return listOfOutgoing;
  }

  Stream<QuerySnapshot> fetchOutgoingAsStream() {
    return listref.orderBy('createdAt',descending:true)
    .snapshots();
  }

  Future<Outgoing> getDocumentById(String id) async {
    var doc = await listref.document(id).get();
    return  Outgoing.fromMap(doc.data, doc.documentID) ;
  }


  Future removeOutgoing(String id) async{
     await listref.document(id).delete() ;
     return ;
  }
  Future updateOutgoing(Outgoing data,String id) async{
    
     try{ await  listref.document(id).updateData(data.toJson());
    data.updatedAt=Timestamp.now();
    data.createdAt= data.updatedAt;
    return ;

     }catch(e){
       print(e.toString());
       return null;
     }
    
  }

  Future addOutgoing(Outgoing data) async{
    var result  = await listref.add(data.toJson()) ;
    return result;
  }

   UnmodifiableListView<Outgoing> get mylistOfOutgoing=>UnmodifiableListView(listOfOutgoing);
   Outgoing get currentOutgoing=>_currentElement;      

   set mylistOfOutgoing(List<Outgoing> listofMyList){
     listOfOutgoing=listofMyList;
     notifyListeners();
   } 

   set currentMyList(Outgoing artmut){
     _currentElement=artmut;
     notifyListeners();
   }

}
   
