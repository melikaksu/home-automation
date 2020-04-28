
class Task{
  String _outgoinName;
  int    _outgoingQuan;
  String _outgoindtype;

  Task([this._outgoinName,this._outgoindtype,this._outgoingQuan]);

  Task.map(dynamic obj) {
    this._outgoinName = obj['name'];
    this._outgoindtype = obj['type'];
    this._outgoingQuan = obj['quantity'];
    
  }

  String get  name => _outgoinName;
  String get  type => _outgoindtype;
    int    get  quantity => _outgoingQuan;



  Map<String,dynamic> toMap() {
    var map=new Map<String,dynamic>();
    map['name']=_outgoinName;
    map['type'] = _outgoindtype;
    map['quantity'] = _outgoingQuan;
    return map;
  }

  Task.fromMap(Map<String,dynamic> map){
    this._outgoinName= map['name'];
    this._outgoindtype= map['type'];
    this._outgoingQuan = map['quantity'];
   
  }
}