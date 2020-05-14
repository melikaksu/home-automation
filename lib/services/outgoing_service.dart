import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'dart:async';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:homesweethome/shared/funtions/get_days.dart';
import 'package:intl/intl.dart';

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

class OutgoingService with ChangeNotifier {
  static String userUid;

  CollectionReference listref = Firestore.instance.collection("outgoings");

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
    return listref.orderBy('createdAt', descending: true).snapshots();
  }

  // Stream<QuerySnapshot> fetchDailyOutgoingAsStream() {
  //   return listref.orderBy('createdAt',descending:true)
  //   .snapshots();
  // }
  Stream<List<Outgoing>> dailyOutgoingAsStream() {
    return listref
        .where("createdAt",
            isGreaterThanOrEqualTo:
                DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now())))
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map<Outgoing>((doc) => Outgoing.fromMap(doc.data, doc.documentID))
          .toList();
    });
  }

  Stream<List<Outgoing>> weeklyOutgoingAsStream() {
   var sunday=DateTime.now();
   var monday=DateTime.now();
   while(sunday.weekday!=7){
     sunday=sunday.add(Duration(days: 1));
   }   while(monday.weekday!=1){
     monday=monday.subtract(Duration(days: 1));
   }
   

    return listref
        .where(
          "createdAt",
          isGreaterThan: DateTime.parse(
            DateFormat('yyyyMMdd').format(
             monday,
            ),
          ),
        )
        .where(
          "createdAt",
          isLessThan: DateTime.parse(
            DateFormat('yyyyMMdd').format(
              sunday,
            ),
          ),
        )
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map<Outgoing>((doc) => Outgoing.fromMap(doc.data, doc.documentID))
          .toList();
    });
  }

  Stream<List<Outgoing>> mounthlyOutgoingAsStream() {
    return listref
        .where("createdAt",
            isGreaterThanOrEqualTo:
                DateTime.parse(DateFormat('yyyyMM01').format(DateTime.now())))
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map<Outgoing>((doc) => Outgoing.fromMap(doc.data, doc.documentID))
          .toList();
    });
  }

  // @override
  // Stream<List<SmokeEntity>> monthlySmokes() {
  //   return getCurrentUserSmokesCollection()
  //       .where("date", isGreaterThanOrEqualTo: DateTime.parse(new DateFormat('yyyyMM01').format(new DateTime.now())))
  //       .orderBy("date", descending: true)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.documents.map((doc) {
  //       return SmokeEntity(
  //         doc.documentID,
  //         (doc['date'] as Timestamp).toDate(),
  //       );
  //     }).toList();
  //   });
  // }

  Future<Outgoing> getDocumentById(String id) async {
    var doc = await listref.document(id).get();
    return Outgoing.fromMap(doc.data, doc.documentID);
  }

  Future removeOutgoing(String id) async {
    await listref.document(id).delete();
    return;
  }

  Future updateOutgoing(Outgoing data, String id) async {
    try {
      await listref.document(id).updateData(data.toJson());
      data.updatedAt = Timestamp.now();
      data.createdAt = data.updatedAt;
      return;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future addOutgoing(Outgoing data) async {
    var result = await listref.add(data.toJson());
    return result;
  }

  UnmodifiableListView<Outgoing> get mylistOfOutgoing =>
      UnmodifiableListView(listOfOutgoing);
  Outgoing get currentOutgoing => _currentElement;

  set mylistOfOutgoing(List<Outgoing> listofMyList) {
    listOfOutgoing = listofMyList;
    notifyListeners();
  }

  set currentMyList(Outgoing artmut) {
    _currentElement = artmut;
    notifyListeners();
  }
}
