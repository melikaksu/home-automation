import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Outgoing {
  String outgoingCategoryId;
  String outgoingId;
  String outgoingName;
  int outgoingQuan;
  String outgoingdType;
  Timestamp createdAt;
  Timestamp updatedAt;

  String get name => outgoingName;
  String get type => outgoingdType;
  Timestamp get timecreatedAt => createdAt;
  Timestamp get timeupdatedAt => updatedAt;
  int get quantity => outgoingQuan;

  Outgoing(
      {this.outgoingName,
      this.outgoingQuan,
      this.outgoingdType,
      this.createdAt,
      this.updatedAt,
      this.outgoingCategoryId,
      outgoingId})
      : this.outgoingId = outgoingId ?? Uuid().v4();

  Outgoing.fromMap(Map snapshot, String id)
      : createdAt = snapshot['createdAt'],
        outgoingCategoryId=snapshot["categoryId"],
        outgoingQuan = snapshot['outgoingQuan'],
        updatedAt = snapshot['updatedAt'],
        outgoingdType = snapshot['outgoingdType'],
        outgoingId = snapshot['outgoingId'],
        outgoingName = snapshot['outgoingName'] ?? '';

  toJson() {
    return {
      'outgoingId': outgoingId,
      "categoryId":outgoingCategoryId,
      "outgoingName": outgoingName,
      "createdAt": createdAt,
      'updatedAt': updatedAt,
      'outgoingQuan': outgoingQuan,
      'outgoingdType': outgoingdType,
    };
  }
}
