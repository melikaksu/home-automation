import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Catagory {
  final String sport = "Spor";
  final String travel = "Seyahat";
  final String shpping = "Alışveriş";
  final String aduqation = "Eğitim";
  final String health = "Sağlık";
  final String others = "Diğer";
}


class Category {
  final String id;
  final String name;
  final String icon;
  final Color color;

  Category({
    @required this.id,
    @required this.name,
    @required this.icon,
    @required this.color,
  });

   Category.fromMap(Map snapshot, String id, )
      : id= snapshot['id'],
      name= snapshot['name'],
      icon= snapshot['icon'],
      color= Color(snapshot['color']);


  static fromSnapshot(DocumentSnapshot document) {
    return Category(
      id: document['id'],
      name: document['name'],
      icon: document['icon'],
      color: Color(document['color']),
      
    );
  }

  // @override
  // String toString() {
  //   return 'Category{id: $id, name: $name, icon: $icon, color: $color, type: $type}';
  // }

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Category &&
  //         runtimeType == other.runtimeType &&
  //         id == other.id &&
  //         name == other.name &&
  //         icon == other.icon &&
  //         color == other.color &&
  //         type == other.type;

  // @override
  // int get hashCode =>
  //     id.hashCode ^
  //     name.hashCode ^
  //     icon.hashCode ^
  //     color.hashCode ^
  //     type.hashCode;
}

