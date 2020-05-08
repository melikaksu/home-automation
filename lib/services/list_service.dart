import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:homesweethome/models/list.dart';

 class ListService with ChangeNotifier{

  CollectionReference listref=Firestore.instance.collection("products");
  MyList _currentElement;
  List<MyList> myList;



  // Future<QuerySnapshot> getDataCollection() {
  //   return listref.getDocuments() ;
  // }
  // Stream<QuerySnapshot> streamDataCollection() {
  //   return listref.snapshots() ;
  // }
  // Future<DocumentSnapshot> getDocumentById(String id) {
  //   return listref.document(id).get();
  // }
  // Future<void> removeDocument(String id){
  //   return listref.document(id).delete();
  // }

  Future<DocumentReference> addDocument(Map data) {
    return listref.add(data);
  }

  Future<void> updateDocument(Map data , String id) {
    return listref.document(id).updateData(data) ;
  }


  Future<List<MyList>> fetchProducts() async {
    var result = await listref.getDocuments();
    myList = result.documents
        .map((doc) => MyList.fromMap(doc.data, doc.documentID))
        .toList();
    return myList;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return listref.snapshots();
  }

  Future<MyList> getProductById(String id) async {
    var doc = await listref.document(id).get();
    return  MyList.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
     await listref.document(id).delete() ;
     return ;
  }
  Future updateProduct(MyList data,String id) async{
    await  listref.document(id).updateData(data.toJson());
    return ;
  }

  Future addProduct(MyList data) async{
    var result  = await listref.add(data.toJson()) ;
    return result;
  }


 
   
   UnmodifiableListView<MyList> get listofMyList=>UnmodifiableListView(myList);
   MyList get currentMyList=>_currentElement;     
    
   set listofMyList(List<MyList> listofMyList){
     myList=listofMyList;
     notifyListeners();
   } 

   set currentMyList(MyList artmut){
     _currentElement=artmut;
     notifyListeners();
   }

}