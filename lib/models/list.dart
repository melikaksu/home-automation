import 'package:cloud_firestore/cloud_firestore.dart';

class Armut{
  String id;
  String name;
  Timestamp createdAt;
  List subList;

  Armut.fromMap(Map<String,dynamic> data,String id) {

    id=id?? '';
    name=data["name"];
    createdAt=data["createdAt"]?? '';
    subList=data["subList"]?? '';
  }
  Armut.toJson(data){

    data["id"]=this.id;
    



  }



}

class MyList {
  String id;
  String price;
  String name;
  Timestamp createdAt;
  List subList = [];


  MyList({this.id, this.price, this.name});

  MyList.fromMap(Map snapshot,String id) {
        createdAt = snapshot['createdAt'];
        id = id ?? '';
        price = snapshot['price'] ?? '';
        name = snapshot['name'] ?? '';
        subList=snapshot["subList"];
  }
     


  toJson() {
    return {
      "price": price,
      "name": name,
      "createdAt":createdAt,
      "subList":subList

    };
  }
}