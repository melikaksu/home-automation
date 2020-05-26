import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/category.dart';
import 'package:homesweethome/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

   AppBar myAppbar () {
    
     return  AppBar(
                    leading: Builder(builder: (BuildContext context){
                      return IconButton(
                          icon: Icon(
                            FontAwesomeIcons.bars,
                            color: Color(0xff2d386b),
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer());
                    }), 
                    centerTitle: true,
                    title: Text(
                      'GİDER LİSTESİ',
                      style: TextStyle(
                          fontFamily: "hadowsIntoLight",
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                          color: Color(0xff2d386b)),
                    ),
                    actions: <Widget>[ Builder(builder: (BuildContext context) {
                      var dat=Provider.of<FirestoreDatabase>(context);  
                      return IconButton(
                          icon: Icon(
                            FontAwesomeIcons.shareAlt,
                            color: Color(0xff2d386b),
                          ),
                          onPressed: () {
                            dat.createCategory( Category(
              id: Uuid().v4(),
              name: "first",
              icon: "iconName",
              color:  Colors.black12, 
              type:   CategoryType.EXPENSE
            ),);
                                         });
                    },)
                      
                    
                    ],
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    bottom: 
                    PreferredSize(
                          preferredSize: Size.fromHeight(60),
                          child: Container(
                            color: Colors.transparent,
                            child: SafeArea(
                              child: Column(
                                children: <Widget>[
                        TabBar(
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                color: Color(0xffff0863),
                                width: 3.0,
                              ),
                              // insets: EdgeInsets.fromLTRB(
                              //     40.0, 20.0, 40.0, 0)
                            ),
                            //  indicatorWeight: 20,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: Color(0xff2d386b),
                            labelStyle: TextStyle(
                              // fontFamily: "Lobster",
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                            unselectedLabelColor: Colors.black26,
                            tabs: [
                          Tab(
                            child: Text("GÜNLÜK"),

                            // icon: Icon(FontAwesomeIcons.clock,
                            //     size: 20),
                          ),
                          Tab(
                            text: "HAFTALIK",
                            // icon: Icon(FontAwesomeIcons.clock,
                            //     size: 20),
                          ),
                          Tab(
                            text: "AYLIK",
                            // icon: Icon(FontAwesomeIcons.recordVinyl,
                            //     size: 20),
                          ),
                          Tab(
                            text: "TÜMÜ",
                            // icon: Icon(Icons.supervised_user_circle,
                            //     size: 20),
                          ),
                        ])
                  ]
                            
                      ),
                    ),
                  ),
                )
                );

 }