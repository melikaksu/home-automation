import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/models/user.dart';
import 'package:homesweethome/services/list_service.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:provider/provider.dart';

class AddList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    List<MyList> myList;
    final listProvider = Provider.of<ListService>(context);

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController _nameController;
    TextEditingController _quantityController;

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
            'Add Item To List',
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
      body: StreamBuilder(
        stream: listProvider.fetchProductsAsStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            myList = snapshot.data.documents
                .map<MyList>((doc) => MyList.fromMap(doc.data, doc.documentID))
                .toList();
            return SingleChildScrollView(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.height,
                    height: MediaQuery.of(context).size.height,
                
                    color: Colors.pinkAccent,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height-80,
                          child: Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, int index) => Divider(),
                              itemCount: 20,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: CircleAvatar(child:Text("${index+1}")),
                                  subtitle: Text(user.userUid),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                            color: Colors.orangeAccent,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: TextFormField(
                                      validator: (value) => value.isEmpty
                                          ? 'Eleman eklemediniz!'
                                          : null,
                                      controller: _nameController,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        prefixIcon:
                                            Icon(FontAwesomeIcons.listAlt),
                                        hintText: 'Aklınızda ne var? ',
                                        // focusedBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(20.0),
                                        //   borderSide: BorderSide(
                                        //       color: Colors.cyan, width: 2),
                                        // ),
                                        // border: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(20.0),
                                        //   borderSide:
                                        //       BorderSide(color: Colors.cyan),
                                        // ),
                                      ),
                                      onChanged: (a) {},
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  colorBrightness: Brightness.dark,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.cyan),
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  color: Colors.greenAccent,
                                  child: Text(
                                    'Ekle',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.0),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                    
                      ],
                    ),
                  ),
                ),
              ),
            );

            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     SingleChildScrollView(
            //       child: ListView.separated(
            //         shrinkWrap: true,
            //         separatorBuilder: (context, int index) => Divider(),
            //         itemCount: 20,
            //         itemBuilder: (BuildContext context, int index) {
            //           return ListTile(
            //             subtitle: Text(user.userUid),
            //             title: Text(""),
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // );
          }
          return Container(
            child: Center(child: Text("No data")),
          );
        },
      ),
    );
  }
}
