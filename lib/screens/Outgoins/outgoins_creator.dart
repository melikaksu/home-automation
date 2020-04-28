import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/services/firestore.dart';
import 'package:homesweethome/shared/my_drawer.dart';

<<<<<<< HEAD
class OutgoingScreen extends StatefulWidget {
  final Outgoing outgoings;

  OutgoingScreen(this.outgoings);

  @override
  _OutgoingScreenState createState() => _OutgoingScreenState();
}

class _OutgoingScreenState extends State<OutgoingScreen> {
  FirestoreService fireServ = new FirestoreService();

  var _userUid;
  _getUserUid() async =>
      await FirebaseAuth.instance.currentUser().then((user) {
        setState(() => this._userUid = user.uid);
      });

  TextEditingController _nameController;
  TextEditingController _quantityController;

  int _myOutgoingType = 0;
  String outgoingVal;
  void _handleOutgoingType(int value) {
=======
class OutgoingsCreatorPage extends StatefulWidget {
  final Task task;
  OutgoingsCreatorPage(this.task);

  @override
  _OutgoingsCreatorPageState createState() => _OutgoingsCreatorPageState();
}

class _OutgoingsCreatorPageState extends State<OutgoingsCreatorPage> {
//   createData(){
// DocumentReference ds=Firestore.instance.collection('liste').document(taskName);
// Map<String,dynamic> tasks={
//   "taskname":taskName,
//   "taskdate":taskDate,
//   "tasktime":taskTime,
//   "taskdetails":taskDetails,
//   "tasktype":taskVal

// };
// ds.setData(tasks).whenComplete((){
//   print("Task Created");
// });

//   }// getname(taskname)=>this.taskName=taskname;
// getdate(taskdate)=>this.taskDate=taskdate;
// gettime(tasktime)=>this.taskTime=tasktime;
// getdetails(taskdetails)=>this.taskDetails=taskdetails;

  FirestoreService fireServ = new FirestoreService();
  TextEditingController _nameController;
  TextEditingController _quantityController;
  
     var _userUid;
     _getUserName() async =>
      await FirebaseAuth.instance.currentUser().then((user) {
        setState(() => this._userUid = user.uid);
      });

  int _myTaskType = 0;
  String taskVal;
  void _handleTaskType(int value) {
>>>>>>> 5fb2400eafcc5814c7f1d8d6fecfdfbafcf8bc81
    setState(() {
      _myOutgoingType = value;
      switch (_myOutgoingType) {
        case 1:
          outgoingVal = 'Seyahat';
          break;
        case 2:
          outgoingVal = 'Spor';
          break;
        case 3:
          outgoingVal = 'Alışveriş';
          break;
        case 4:
          outgoingVal = 'Eğitim';
          break;
        case 5:
          outgoingVal = 'Diğer';
          break;
      }
    });
  }
<<<<<<< HEAD

 
=======
>>>>>>> 5fb2400eafcc5814c7f1d8d6fecfdfbafcf8bc81



<<<<<<< HEAD
  @override
  void initState() {
    _getUserUid();
    super.initState();
    _nameController =    TextEditingController(text: widget.outgoings.name);
    _quantityController =TextEditingController(text: widget.outgoings.quantity.toString());
  }
=======
  }
  
>>>>>>> 5fb2400eafcc5814c7f1d8d6fecfdfbafcf8bc81

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                icon: Icon(
                  FontAwesomeIcons.bars,
                  color: Color(0xff2d386b),
                ),
                onPressed: () => Scaffold.of(context).openDrawer());
          }),
          title: Center(
            child: Text(
              'AppBar',
              style: TextStyle(
                  fontFamily: "Lobster",
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                  color: Color(0xff2d386b)),
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.shareAlt,
                  color: Color(0xff2d386b),
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.cogs,
                  color: Color(0xff2d386b),
                ),
                onPressed: () {})
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height - 80,

/////////////////////////////////////////////////////////////////////////

          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Açıklama: "),
                ),
              ),
/////////////////////////////////////////////////////////////////////////

              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: "Tutar: "),
                ),
              ),
////////////////////////////////////////////////////////////////////////
              SizedBox(
                height: 10.0,
              ),
/////////////////////////////////////////////////////////////////////////

              Center(
                child: Text(
                  'Kategori seçiniz:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
/////////////////////////////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _myOutgoingType,
                          onChanged: _handleOutgoingType,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Seyahat',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Expanded(
                          child: ListTile(
                            trailing: Switch(
                                activeColor: Color(0xffff0863),
                                value: false,
                                onChanged: (a) {}),
                          ),
                        ),
                      ],
                    ),
/////////////////////////////////////////////////////////////////////////

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _myOutgoingType,
                          onChanged: _handleOutgoingType,
                          activeColor: Color(0xfffb537f),
                        ),
                        Text(
                          'Spor',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
/////////////////////////////////////////////////////////////////////////

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 3,
                          groupValue: _myOutgoingType,
                          onChanged: _handleOutgoingType,
                          activeColor: Color(0xff4caf50),
                        ),
                        Text(
                          'Alışveriş',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
/////////////////////////////////////////////////////////////////////////

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 4,
                          groupValue: _myOutgoingType,
                          onChanged: _handleOutgoingType,
                          activeColor: Color(0xff9962d0),
                        ),
                        Text(
                          'Eğitim',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
/////////////////////////////////////////////////////////////////////////

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 5,
                          groupValue: _myOutgoingType,
                          onChanged: _handleOutgoingType,
                          activeColor: Color(0xff0dc8f5),
                        ),
                        Text(
                          'Diğer',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
/////////////////////////////////////////////////////////////////////////

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Color(0xffff0863))),
                    color: Color(0xffff0863),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "İPTAL",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // This button results in adding the contact to the database
/////////////////////////////////////////////////////////////////////////

                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xffff0863))),
                      color: Color(0xffff0863),
                      onPressed: () {
                        fireServ
                            .createOutgoingList(
                                name: _nameController.text,
                                quantity: int.parse(_quantityController.text),
                                type: outgoingVal)
                            .then((_) => Navigator.of(context).pop());
                            setState(() {
      fireServ.name = _userUid; 
    });
                      
                      },
                      child: const Text(
                        "ONAYLA",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        ));
<<<<<<< HEAD
  }
}
=======
  }}
>>>>>>> 5fb2400eafcc5814c7f1d8d6fecfdfbafcf8bc81
