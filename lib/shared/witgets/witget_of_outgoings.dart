import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/outgoing.dart';

Widget containerWitgetofOutgoing({BuildContext context, List<Outgoing> list,int index}) {
  // int _itemCount;

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
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    48) *
                                                0.15,
                                        child: todoType(
                                            '${list[index].outgoingdType}')),
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            48) *
                                        0.85,
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '${list[index].outgoingName}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            '${list[index].outgoingQuan}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Text(
                                                formatDate(
                                                    list[index]
                                                        .createdAt
                                                        .toDate(),
                                                    [dd, '.', mm, '.', yyyy]),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    // fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                formatDate(
                                                    list[index]
                                                        .createdAt
                                                        .toDate(),
                                                    [HH, ':', nn, ':', ss]),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    // fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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
            ]);}

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
    case 'Sağlık':
      iconval = FontAwesomeIcons.hospitalAlt;
      colorval = Color(0xff9962d0);
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
