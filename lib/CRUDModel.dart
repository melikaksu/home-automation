import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homesweethome/locator.dart';
import 'package:homesweethome/models/list.dart';


class Api {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Api( this.path ) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments() ;
  }
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }
  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }
  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }
  Future<void> updateDocument(Map data , String id) {
    return ref.document(id).updateData(data) ;
  }


}

class CRUDModel extends ChangeNotifier {
    Api _api = locator<Api>();

  List<MyList> myList;

  Future<List<MyList>> fetchProducts() async {
    var result = await _api.getDataCollection();
    myList = result.documents
        .map((doc) => MyList.fromMap(doc.data, doc.documentID))
        .toList();
    return myList;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<MyList> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  MyList.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
     await _api.removeDocument(id) ;
     return ;
  }
  Future updateProduct(MyList data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(MyList data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;
  }


}