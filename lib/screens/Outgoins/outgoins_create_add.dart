import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/category.dart';
import 'package:homesweethome/models/outgoing.dart';
import 'package:homesweethome/notifiers/category_notifier.dart';
import 'package:homesweethome/services/firestore_service.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:homesweethome/theme/category.dart';
import 'package:homesweethome/theme/create_category.dart';
import 'package:homesweethome/theme/icons.dart';
import 'package:provider/provider.dart';

class CreateAndAddOutgoing extends StatefulWidget {
  final Outgoing outgoings;
  final LinkedHashMap<String, IconData> assignableIcons;

  CreateAndAddOutgoing([this.outgoings])
      : this.assignableIcons = LinkedHashMap.from(icons)
          ..removeWhere((key, value) => key == 'add');

  @override
  _CreateAndAddOutgoingState createState() => _CreateAndAddOutgoingState();
}

class _CreateAndAddOutgoingState extends State<CreateAndAddOutgoing> {
  int selected;
  MapEntry<String, IconData> selectedIcon;
  Timestamp createdAt = Timestamp.now();
  String outgoingName;
  int outgoingQunatity;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

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
        case 6:
          outgoingVal = 'Diğer';
          break;
        case 5:
          outgoingVal = 'Sağlık';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LinkedHashMap<String, IconData> assignableIcons = LinkedHashMap.from(icons);
    List<Category> category = [];
    FirestoreDatabase fireServ =
        Provider.of<FirestoreDatabase>(context, listen: false);
    CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context);

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
                  FontAwesomeIcons.plusSquare,
                  color: Color(0xff2d386b),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return CreateCategory();
                  }));
                })
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            //     Expanded(
            //       child: Container(
            //         // width: MediaQuery.of(context).size.width,
            //         color: Colors.cyan,
            //         height: 80,
            //         child: ListView.builder(
            //           scrollDirection: Axis.horizontal,
            //           itemBuilder: (BuildContext context, int index) {
            //             return Padding(
            //               padding: const EdgeInsets.only(top: 20.0),
            //               child: GestureDetector(
            //                 onTap: () {

            //                   setState(() {
            //                     selected = index;
            //                     selectedIcon= widget.assignableIcons.entries
            //                             .toList()[selected];
            //                             print(selectedIcon);

            //                   });
            //                 },
            //                 child: Container(
            //                   width: 50,
            //                   child: Card(
            //                     color: Colors.blueGrey[200],
            //                     child: Center(
            //                       child: Icon(
            //                         widget.assignableIcons.entries
            //                             .toList()[index]
            //                             .value,
            //                         color: Colors.deepOrange,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //           itemCount: widget.assignableIcons.entries.toList().length,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 80,
            //       color: Colors.blue,
            //       child: Container(
            //         padding: const EdgeInsets.only(top: 20.0),
            //         width: 50,
            //         child: Card(
            //           color: Colors.blueGrey[200],
            //           child: Center(
            //             child: Icon(
            //               Icons.shopping_basket,
            //               color: Colors.deepOrange,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 16.0, right: 16.0),
                            child: TextFormField(
                              onSaved: (a) => outgoingName = a,
                              controller: _nameController,
                              decoration:
                                  InputDecoration(labelText: "Açıklama: "),
                            ),
                          ),
/////////////////////////////////////////////////////////////////////////

                          Padding(
                            padding: EdgeInsets.only(left: 16.0, right: 16.0),
                            child: TextFormField(
                              onSaved: (a) => outgoingQunatity = int.parse(a),
                              keyboardType: TextInputType.number,
                              controller: _quantityController,
                              decoration: InputDecoration(labelText: "Tutar: "),
                            ),
                          ),
////////////////////////////////////////////////////////////////////////
                          SizedBox(
                            height: 10.0,
                          ),

                          Center(
                            child: Text(
                              'Kategori seçiniz:',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        child: StreamBuilder(
                            stream: fireServ.fetchgetCategoriesAsStream(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (snapshot.hasData) {
                                  category = snapshot.data;
                                  return ListView.builder(
                                    itemCount: category.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        leading:Icon(icons[category[index].icon],color: category[index].color,),
                                        title: Text(category[index].name),
                                        subtitle: Text(category[index].id),
                                      );
                                    },
                                  );
                                }
                              }
                              return Container();
                            }),
                      ),
                    ),

/////////////////////////////////////////////////////////////////////////

                    // SizedBox(
                    //   height: 10.0,
                    // ),

                    // Expanded(
                    //                       child: GridView.count(
                    //     crossAxisCount: 4,
                    //     children: <Widget>[

                    //       ListView.builder(
                    //         itemCount: 20,
                    //         itemBuilder: (BuildContext context, int index) {
                    //           return Card(
                    //             child: Icon(Icons.add_to_home_screen),
                    //           );
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),

/////////////////////////////////////////////////////////////////////////

//                       Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.only(left: 40),
//                               width: MediaQuery.of(context).size.width * 0.5,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   Radio(
//                                     value: 1,
//                                     groupValue: _myOutgoingType,
//                                     onChanged: _handleOutgoingType,
//                                     activeColor: Color(0xff4158ba),
//                                   ),
//                                   Text(
//                                     'Seyahat',
//                                     style: TextStyle(fontSize: 16.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(left: 40),
//                               width: MediaQuery.of(context).size.width * 0.5,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   Radio(
//                                     value: 2,
//                                     groupValue: _myOutgoingType,
//                                     onChanged: _handleOutgoingType,
//                                     activeColor: Color(0xfffb537f),
//                                   ),
//                                   Text(
//                                     'Spor',
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),

// /////////////////////////////////////////////////////////////////////////

//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.only(left: 40),
//                               width: MediaQuery.of(context).size.width * 0.5,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   Radio(
//                                     value: 3,
//                                     groupValue: _myOutgoingType,
//                                     onChanged: _handleOutgoingType,
//                                     activeColor: Color(0xff4caf50),
//                                   ),
//                                   Text(
//                                     'Alışveriş',
//                                     style: TextStyle(fontSize: 16.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(left: 40),
//                               width: MediaQuery.of(context).size.width * 0.5,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   Radio(
//                                     value: 4,
//                                     groupValue: _myOutgoingType,
//                                     onChanged: _handleOutgoingType,
//                                     activeColor: Color(0xff9962d0),
//                                   ),
//                                   Text(
//                                     'Eğitim',
//                                     style: TextStyle(fontSize: 16.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),

// /////////////////////////////////////////////////////////////////////////

//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.only(left: 40),
//                               width: MediaQuery.of(context).size.width * 0.5,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   Radio(
//                                     value: 5,
//                                     groupValue: _myOutgoingType,
//                                     onChanged: _handleOutgoingType,
//                                     activeColor: Color(0xff0dc8f5),
//                                   ),
//                                   Text(
//                                     'Sağlık',
//                                     style: TextStyle(fontSize: 16.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(left: 40),
//                               width: MediaQuery.of(context).size.width * 0.5,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   Radio(
//                                     value: 6,
//                                     groupValue: _myOutgoingType,
//                                     onChanged: _handleOutgoingType,
//                                     activeColor: Color(0xff0dc8f5),
//                                   ),
//                                   Text(
//                                     'Diğer',
//                                     style: TextStyle(fontSize: 16.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
/////////////////////////////////////////////////////////////////////////

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10.0, right: 10),
                      child: Row(
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
                              onPressed: () async {
                                await fireServ
                                    .addOutgoing(Outgoing(
                                        outgoingCategoryId: selectedIcon.key,
                                        createdAt: createdAt,
                                        outgoingName: _nameController.text,
                                        outgoingQuan:
                                            int.parse(_quantityController.text),
                                        outgoingdType: outgoingVal))
                                    .then((_) => Navigator.of(context).pop());

                                // fireServ
                                //     .createOutgoingList(
                                //         name: _nameController.text,
                                //         quantity: int.parse(_quantityController.text),
                                //         type: outgoingVal)
                                //     .then((_) => Navigator.of(context).pop());
                              },
                              child: const Text(
                                "ONAYLA",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
