import 'package:cloud_firestore/cloud_firestore.dart';

class MyList {
  String id;
  String name;
  Timestamp createdAt;
  Timestamp updatedAt;
  List subList = [];

  MyList({this.name, this.createdAt, this.id, this.subList, this.updatedAt});
  
  MyList.fromMap(Map snapshot, String id)
      : createdAt = snapshot['createdAt'],
        updatedAt = snapshot['updatedAt'],
        id = id ?? '',
        name = snapshot['name'] ?? '',
        subList = snapshot["subList"];

  toJson() {
    return {
      "name": name,
      "createdAt": createdAt,
      "subList": subList,
      'updatedAt': updatedAt
    };
  }
}
