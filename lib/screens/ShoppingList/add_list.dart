import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/services/firestore.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:provider/provider.dart';

class AddList extends StatefulWidget {
  final MyList mylist;
  AddList(this.mylist);

  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {


  TextEditingController _nameController;
  TextEditingController _quantityController;

  int _myOutgoingType = 0;
  String outgoingVal;
  void _handleOutgoingType(int value) {
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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.mylist.name);
    _quantityController =
        TextEditingController(text: widget.mylist.id.toString());
  }

  @override
  Widget build(BuildContext context) {

    final fireServ=Provider.of<FirestoreService>(context,listen: false);
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
}