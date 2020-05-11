import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/services/list_service.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:provider/provider.dart';

class AddList extends StatefulWidget {
  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  String name;

  Timestamp createdAt = Timestamp.now();
  

  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    List<MyList> myList;
    final listProvider = Provider.of<ListService>(context);

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController _nameController = TextEditingController();

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
        centerTitle: true,
        title: Text(
          '... LİSTESİ',
          style: TextStyle(
              fontFamily: "hadowsIntoLight",
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 25,
              color: Color(0xff2d386b)),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.shareAlt,
                color: Color(0xff2d386b),
              ),
              onPressed: () {}),
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: listProvider.fetchListAsStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            myList = snapshot.data.documents
                .map<MyList>((doc) => MyList.fromMap(doc.data, doc.documentID))
                .toList();
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // separatorBuilder: (context, int index) => Divider(),
                    itemCount: myList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onLongPress: () async {
                          await listProvider.updateList(
                              MyList(name: "_nameController.text"),
                              myList[index].id);
                         
                        },
                        trailing: IconButton(
                          onPressed: () {
                            listProvider.removeList(myList[index].id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                        // leading: CircleAvatar(child: Text("${index + 1}")),
                        leading: Icon(FontAwesomeIcons.circle),
                        title: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(myList[index].name),
                              // Column(
                              //   children: <Widget>[
                              //     Text(myList[index]
                              //             .createdAt
                              //             .toDate()
                              //             .day
                              //             .toString() +
                              //         '/' +
                              //         myList[index]
                              //             .createdAt
                              //             .toDate()
                              //             .month
                              //             .toString() +
                              //         '/' +
                              //         myList[index]
                              //             .createdAt
                              //             .toDate()
                              //             .year
                              //             .toString(),style: TextStyle(fontSize: 10,

                              //             ),),
                              //     Text(myList[index]
                              //             .createdAt
                              //             .toDate()
                              //             .hour
                              //             .toString() +
                              //         ':' +
                              //         myList[index]
                              //             .createdAt
                              //             .toDate()
                              //             .minute
                              //             .toString() +
                              //         ':' +
                              //         myList[index]
                              //             .createdAt
                              //             .toDate()
                              //             .second
                              //             .toString(),style: TextStyle(fontSize: 10,

                              //             )),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Form(
                      key: _formKey,
                      child: Row(
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
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        await listProvider.addList(MyList(
                                            name: name, createdAt: createdAt));
                                        _nameController.clear();
                                      }
                                    },
                                    icon: Icon(Icons.clear),
                                  ),
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  prefixIcon: Icon(FontAwesomeIcons.listAlt),
                                  hintText: 'Aklınızda ne var? ',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                        color: Colors.cyan, width: 2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(color: Colors.cyan),
                                  ),
                                ),
                                onSaved: (a) {
                                  setState(() {
                                    name = a;
                                    _nameController.clear();
                                  });
                                },
                              ),
                            ),
                          ),
                          RaisedButton(
                            colorBrightness: Brightness.dark,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.cyan),
                                borderRadius: new BorderRadius.circular(20.0)),
                            color: Colors.greenAccent,
                            child: Text(
                              'Ekle',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                await listProvider.addList(
                                    MyList(name: name, createdAt: createdAt));
                                _nameController.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
