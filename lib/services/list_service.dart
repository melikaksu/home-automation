import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:homesweethome/models/list.dart';

 class ListService with ChangeNotifier{
  static String  userUid;
  CollectionReference listref=Firestore.instance.collection("list");

  // CollectionReference newList=  Firestore.instance.collection("list").document("userUid").collection('elements');
  //  Firestore.instance.collection('path').document("documentPath").collection('subCollectionPath').setData({});

  MyList _currentElement;
  List<MyList> myList;



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

  Future<MyList> getDocumentById(String id) async {
    var doc = await listref.document(id).get();
    return  MyList.fromMap(doc.data, doc.documentID) ;
  }


  Future removeList(String id) async{
     await listref.document(id).delete() ;
     return ;
  }
  Future updateList(MyList data,String id) async{
    
     try{ await  listref.document(id).updateData(data.toJson());
    data.updatedAt=Timestamp.now();
    data.createdAt= data.updatedAt;
    return ;

     }catch(e){
       print(e.toString());
       return null;
     }
    
  }

  Future addList(MyList data) async{
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