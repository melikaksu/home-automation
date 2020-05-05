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

class Product {
  String id;
  String price;
  String name;
  String img;

  Product({this.id, this.price, this.name,this.img});

  Product.fromMap(Map snapshot,String id) :
        id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        img = snapshot['img'] ?? '';

  toJson() {
    return {
      "price": price,
      "name": name,
      "img": img,
    };
  }
}