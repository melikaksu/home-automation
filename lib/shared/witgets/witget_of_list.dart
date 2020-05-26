import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/screens/ShoppingList/list_details.dart';
import 'package:homesweethome/services/firestore_service.dart';
import 'package:provider/provider.dart';

Widget witgetofList({BuildContext context, List list}) {
  var listProvider = Provider.of<FirestoreDatabase>(context);
  // int _itemCount;

  return SingleChildScrollView 
  (
      child: Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Stack(children: <Widget>[
                  // The containers in the background
                  Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 6.0, right: 6.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
                            child: Material(
                              color: Colors.grey[300],
                              elevation: 20.0,
                              shadowColor: Colors.grey,
                              child: Center(
                                child: GestureDetector(
                                   onTap: () {
                                    listProvider.currentMyList = list[index];
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return ListDetails();
                                    }));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(list[index].name),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            list[index]
                                                    .createdAt
                                                    .toDate()
                                                    .day
                                                    .toString() +
                                                "/" +
                                                list[index]
                                                    .createdAt
                                                    .toDate()
                                                    .month
                                                    .toString() +
                                                "/" +
                                                list[index]
                                                    .createdAt
                                                    .toDate()
                                                    .year
                                                    .toString(),
                                            style: TextStyle(),
                                          ),
                                          Text(
                                            list[index]
                                                    .createdAt
                                                    .toDate()
                                                    .hour
                                                    .toString() +
                                                ":" +
                                                list[index]
                                                    .createdAt
                                                    .toDate()
                                                    .second
                                                    .toString() +
                                                ":" +
                                                list[index]
                                                    .createdAt
                                                    .toDate()
                                                    .minute
                                                    .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ]);
              }),
        ),
      ],
    ),
  );
}

Widget todoType(String icontype) {
  IconData iconval;
  Color colorval;
  switch (icontype) {
    case 'Seyahat':
      iconval = FontAwesomeIcons.mapMarkerAlt;
      colorval = Color(0xff4158ba);
      break;
    case 'Alışveriş':
      iconval = FontAwesomeIcons.shoppingCart;
      colorval = Color(0xfffb537f);
      break;
    case 'Eğitim':
      iconval = FontAwesomeIcons.graduationCap;
      colorval = Color(0xff4caf50);
      break;
    case 'Diğer':
      iconval = FontAwesomeIcons.glassCheers;
      colorval = Color(0xff9962d0);
      break;
    default:
      iconval = FontAwesomeIcons.tasks;
      colorval = Color(0xff0dc8f5);
    //
  }
  return CircleAvatar(
    backgroundColor: colorval,
    child: Icon(iconval, color: Colors.white, size: 20.0),
  );
}
