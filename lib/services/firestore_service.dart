import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homesweethome/models/category.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'dart:async';
import 'dart:collection';
import 'package:flutter/cupertino.dart';


class FirestoreDatabase with ChangeNotifier {
  static String userUid;
  final String userId;
  final CollectionReference categories;
  final CollectionReference entries;

  
   

        FirestoreDatabase(this.userId)
        : this.entries =
            Firestore.instance.collection("users").document(userId).collection("entry"),  
        this.categories =
             Firestore.instance.collection("users").document(userId).collection("category");
  
  Future<QuerySnapshot> getCategories() async {
    return categories.orderBy('name', descending: false).getDocuments();
  }
   void createCategory(Category category) {
    categories.reference().document(category.id).setData({
      'id': category.id,
      'name': category.name,
      'icon': category.icon,
      'color': category.color.value,
      'type': category.type.index,
    });
  }
  CollectionReference listref=Firestore.instance.collection("list");
  CollectionReference expenseRef = Firestore.instance.collection("outgoings");

  // CollectionReference newList=  Firestore.instance.collection("list").document("userUid").collection('elements');
  //  Firestore.instance.collection('path').document("documentPath").collection('subCollectionPath').setData({});



///////////////////////////////////////////////////////////////////////////////
  Outgoing _currentOutgoingElement;
  List<Outgoing> listOfOutgoing;

  
  // Stream<QuerySnapshot> fetchOutgoingAsStream() {
  //   return expenseRef.orderBy('createdAt', descending: true).snapshots();
  // } 
   Stream<List<Outgoing>> fetchOutgoingAsStream() {
    return entries.orderBy('createdAt', descending: true).snapshots().map((snapshot) {
      return snapshot.documents
          .map<Outgoing>((doc) => Outgoing.fromMap(doc.data, doc.documentID))
          .toList();
    });
  }

 
  Future<Outgoing> getDocumentById(String id) async {
    var doc = await entries.document(id).get();
    return Outgoing.fromMap(doc.data, doc.documentID);
  }

  Future removeOutgoing(String id) async {
    await entries.document(id).delete();
        notifyListeners();

    return;
  }

  Future updateOutgoing(Outgoing data, String id) async {
    try {
      await entries.document(id).updateData(data.toJson());
      data.updatedAt = Timestamp.now();
      data.createdAt = data.updatedAt;
      return;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future addOutgoing(Outgoing data) async {
    var result = await entries.add(data.toJson());
        notifyListeners();
    return result;
  }

  UnmodifiableListView<Outgoing> get mylistOfOutgoing =>
      UnmodifiableListView(listOfOutgoing);
  Outgoing get currentOutgoing => _currentOutgoingElement;

  set mylistOfOutgoing(List<Outgoing> listofMyList) {
    listOfOutgoing = listofMyList;
    notifyListeners();
  }

  set currentMyOutgoing(Outgoing artmut) {
    _currentOutgoingElement = artmut;
    notifyListeners();
  }

 ///////////////////////////////////////////////////////////////////////////////
 MyList _currentListElement= MyList();
 List<MyList> myList=[];



  Future<List<MyList>> fetchList() async {
    var result = await listref.getDocuments();
    myList = result.documents
        .map((doc) => MyList.fromMap(doc.data, doc.documentID))
        .toList();
    return myList;
  }

  Stream<QuerySnapshot> fetchListAsStream() {
    return listref.orderBy('createdAt',descending:true)
    .snapshots();
  }

  // Future<MyList> getDocumentById(String id) async {
  //   var doc = await listref.document(id).get();
  //   return  MyList.fromMap(doc.data, doc.documentID) ;
  // }


  Future removeList(String id) async{
     await listref.document(id).delete() ;
     return ;
  }
  Future updateList(MyList data,String id) async{
     try{ await  listref.document(id).updateData(data.toJson());
    data.updatedAt=Timestamp.now();
    data.createdAt= data.updatedAt;
    return ;

     }
     catch(e){
       print(e.toString());
       return null;
     }
    
  }

  Future addList(MyList data) async{
    var result  = await listref.add(data.toJson()) ;
    return result;
  }

   UnmodifiableListView<MyList> get listofMyList=>UnmodifiableListView(myList);
   
   MyList get currentMyList=>_currentListElement;      

   set listofMyList(List<MyList> listofMyList){
     myList=listofMyList;
     notifyListeners();
   } 

   set currentMyList(MyList artmut){
     _currentListElement=artmut;
     notifyListeners();
   }


  // Future<List<Outgoing>> fetchOutgoing() async {
  //   var result = await expenseRef.getDocuments();
  //   listOfOutgoing = result.documents
  //       .map((doc) => Outgoing.fromMap(doc.data, doc.documentID))
  //       .toList();
  //   notifyListeners();
  //   return listOfOutgoing;
  // }

  // Stream<List<Outgoing>> dailyOutgoingAsStream() {
  //   return expenseRef
  //       .where("createdAt",isGreaterThanOrEqualTo:DateTime.parse(DateFormat('yyyyMMdd').format(DateTime.now())))
  //       // .where("outgoingdType",isEqualTo: "Seyahat")
  //       .orderBy("createdAt", descending: true)
  //       .snapshots()
  //       .map((snapshot) {
  //        return snapshot.documents
  //         .map<Outgoing>((doc) => Outgoing.fromMap(doc.data, doc.documentID))
  //         .toList();
  //   });
  // }

  // Stream<List<Outgoing>> weeklyOutgoingAsStream( ) {
  //   return expenseRef
  //       .where("createdAt",isGreaterThanOrEqualTo: DateTime.parse(DateFormat('yyyyMMdd').format(getMonday())))
  //       .where("createdAt",isLessThan:    DateTime.parse(getSunday().toString()))
  //       .orderBy("createdAt", descending: true)
  //       .snapshots()
  //       .map((snapshot) {
  //       return snapshot.documents
  //         .map<Outgoing>((doc) => Outgoing.fromMap(doc.data, doc.documentID))
  //         .toList();
  //   });
  // }

  // Stream<List<Outgoing>> monthlyOutgoingAsStream() {
  //   return expenseRef
  //       .where("createdAt",isGreaterThanOrEqualTo: DateTime.parse(DateFormat('yyyyMM01').format(DateTime.now())))
  //       .orderBy("createdAt", descending: true)
  //       .snapshots()
  //       .map((snapshot) {
  //       return snapshot.documents
  //         .map<Outgoing>((doc) => Outgoing.fromMap(doc.data, doc.documentID))
  //         .toList();
  //   });
  // }
  
}
