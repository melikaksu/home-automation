import 'package:cloud_firestore/cloud_firestore.dart';

// class Outgoing{
//   String _outgoingName;
//   int    _outgoingQuan;
//   String _outgoingdtype;

//   Outgoing([this._outgoingName,this._outgoingdtype,this._outgoingQuan]);

//   Outgoing.map(dynamic obj) {
//     this._outgoingName = obj['name'];
//     this._outgoingdtype = obj['type'];
//     this._outgoingQuan = obj['quantity'];
    
//   }

//   String get  name => _outgoingName;
//   String get  type => _outgoingdtype;
//   int    get  quantity => _outgoingQuan;



//   Map<String,dynamic> toMap() {
//     var map=new Map<String,dynamic>();
//     map['name']=_outgoingName;
//     map['type'] = _outgoingdtype;
//     map['quantity'] = _outgoingQuan;
//     return map;
//   }

//   Outgoing.fromMap(Map<String,dynamic> map){
//     this._outgoingName= map['name'];
//     this._outgoingdtype= map['type'];
//     this._outgoingQuan = map['quantity'];
   
//   }
// }

class Outgoing {
  String   outgoingId;
  String outgoingName;
  int    outgoingQuan;
  String outgoingdType;
  Timestamp createdAt;
  Timestamp updatedAt;

  String get  name => outgoingName;
  String get  type => outgoingdType;
  Timestamp get  timecreatedAt => createdAt;
  Timestamp get  timeupdatedAt => updatedAt;
  int    get  quantity => outgoingQuan;


  Outgoing({this.outgoingName,this.outgoingId,this.outgoingQuan,this.outgoingdType,this.createdAt,this.updatedAt});  
  Outgoing.fromMap(Map snapshot, String id)
      : createdAt = snapshot['createdAt'],
        outgoingQuan = snapshot['outgoingQuan'],
        updatedAt = snapshot['updatedAt'],
        outgoingdType = snapshot['outgoingdType'],
        outgoingId = id ?? '',
        outgoingName = snapshot['outgoingName'] ?? '';

    toJson() {
    return {
      "outgoingName": outgoingName,
      "createdAt": createdAt,
      'updatedAt': updatedAt,
      'outgoingQuan':outgoingQuan,
      'outgoingdType':outgoingdType,    

    };
  }
}
