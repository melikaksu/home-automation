import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'dart:async';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:homesweethome/shared/funtions/get_days.dart';
import 'package:intl/intl.dart';

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

 
  Stream<List<Outgoing>> dailyOutgoingAsStream() {
    return listref
        .where("createdAt",
            isGreaterThanOrEqualTo:
                DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now()))).where("outgoingdType",isEqualTo: "Seyahat")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map<Outgoing>((doc) => Outgoing.fromMap(doc.data, doc.documentID))
          .toList();
    });
  }

  Stream<List<Outgoing>> weeklyOutgoingAsStream( ) {
    return listref
        .where(
          "createdAt",
          isGreaterThan: DateTime.parse(
            DateFormat('yyyyMMdd').format(
             getMonday(),
            ),
          ),
        )
        .where(
          "createdAt",
          isLessThan: DateTime.parse(
            DateFormat('yyyyMMdd').format(
              getSunday(),
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
