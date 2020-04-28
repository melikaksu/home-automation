import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/task.dart';
import 'package:homesweethome/services/firestore.dart';
import 'package:homesweethome/shared/my_drawer.dart';

class TaskScreen extends StatefulWidget {
  final Task task;
  TaskScreen(this.task);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  FirestoreService fireServ = new FirestoreService();
  
  // var _userUid;

  // //  _getUserName() async =>
  // //     await FirebaseAuth.instance.currentUser().then((user) {
  // //       setState(() => this._userUid = user.uid);
  // //     });


  


// getname(taskname)=>this.taskName=taskname;
// getdate(taskdate)=>this.taskDate=taskdate;
// gettime(tasktime)=>this.taskTime=tasktime;
// getdetails(taskdetails)=>this.taskDetails=taskdetails;

  TextEditingController _nameController;
  TextEditingController _quantityController;


  

  int _myTaskType = 0;
  String taskVal;
  void _handleTaskType(int value) {
    setState(() {
      _myTaskType = value;
      switch (_myTaskType) {
        case 1:
          taskVal = 'Seyahat';
          break;
        case 2:
          taskVal = 'Spor';
          break;
        case 3:
          taskVal = 'Alışveriş';
          break;
        case 4:
          taskVal = 'Eğitim';
          break;
        case 5:
          taskVal = 'Diğer';
          break;
      }
    });
  }
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

//   }

   @override
  void initState() {
    // _getUserName();
    super.initState();
     _nameController = new TextEditingController(text: widget.task.name);
     _quantityController = new TextEditingController(text: widget.task.quantity.toString());

  }

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
          )),
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
          child: ListView(
            children: <Widget>[
/////////////////////////////////////////////////////////////////////////

              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "İsim: "),
                
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
                padding: const EdgeInsets.only(left:40.0,right: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio( 

                          value: 1,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Seyahat',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Expanded(child:  ListTile(
                            trailing: Switch(
                            activeColor: Color(0xffff0863) ,
                            value: false, onChanged: (a){}),                               
                        )
)
                       
                        
                      ],
                    ),
/////////////////////////////////////////////////////////////////////////

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
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
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
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
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
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
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
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
                      )),
                  // This button results in adding the contact to the database
/////////////////////////////////////////////////////////////////////////

                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Color(0xffff0863))),
                      color: Color(0xffff0863),
                      onPressed: ()  {
                         fireServ
                            .createTaskList(
                        
                                name: _nameController.text,
                                quantity:   int.parse(_quantityController.text),
                                type: taskVal)
                            .then((_) => Navigator.of(context).pop());
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
  }
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

  // Widget _myAppBar() {
  //   return Container(
  //     height: 80.0,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //           colors: [
  //             const Color(0xFFFA7397),
  //             const Color(0xFFFDDE42),
  //           ],
  //           begin: const FractionalOffset(0.0, 0.0),
  //           end: const FractionalOffset(1.0, 0.0),
  //           stops: [0.0, 1.0],
  //           tileMode: TileMode.clamp),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.only(top: 16.0),
  //       child: Center(
  //           child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           Expanded(
  //             flex: 1,
  //             child: Container(
  //               child: IconButton(
  //                   icon: Icon(
  //                     FontAwesomeIcons.arrowLeft,
  //                     color: Colors.white,
  //                   ),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   }),
  //             ),
  //           ),
  //           Expanded(
  //             flex: 5,
  //             child: Container(
  //               child: Text(
  //                 'New Tasks',
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 20.0),
  //               ),
  //             ),
  //           ),
  //         ],
  //       )),
  //     ),
  //   );
  // }
}
