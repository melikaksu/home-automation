import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget containerWitgetofOutgoing({BuildContext context, List list}) {
  // int _itemCount;

  return Column(
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: 480,
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
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Row(
                                  children: <Widget>[
                                    todoType('${list[index].outgoingType}'),
                                    Text(
                                      '${list[index].outgoingName}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20.0),
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
                                          '10/05/2020',
                                          style: TextStyle(
                                              color: Colors.black,
                                              // fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '21:31:26',
                                          style: TextStyle(
                                              color: Colors.black,
                                              // fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
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
