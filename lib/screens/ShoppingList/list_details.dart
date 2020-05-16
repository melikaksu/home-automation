import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/services/list_service.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:provider/provider.dart';

class ListDetails extends StatefulWidget {
  @override
  _ListDetailsState createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController subListController = TextEditingController();
  bool isDone = false;
  List subList = [];
  Color clr;
  MyList currentMyList;
  var curentIndex;

  _addToSubList(String text) {
    if (text.isNotEmpty) {
      setState(() {
        subList.add(text);
      });
      subListController.clear();
    }
  }

  _buildSubListField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: subListController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: 'Subingredient'),
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  void initState() {
    final listProvider = Provider.of<ListService>(context, listen: false);
    if (listProvider.currentMyList != null) {
      currentMyList = listProvider.currentMyList;
          // subList=currentMyList.subList;

     

    } else {
      currentMyList = MyList();
    }
  
      subList.addAll(listProvider.currentMyList.subList);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final listProvider = Provider.of<ListService>(context);
    // currentMyList=listProvider.currentMyList;

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
              currentMyList.name,
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
            backgroundColor: Colors.white),
        body:
            //  var  at=listNotifier.currentMyList.subList.length;
            SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: IconButton(
                              icon: Icon(isDone
                                  ? FontAwesomeIcons.checkCircle
                                  : FontAwesomeIcons.circle),
                              onPressed: () {
                                setState(() {
                                  curentIndex = index;
                                });
                                print(curentIndex.toString());
                              },
                              color: clr,
                            ),
                            title: Text(
                              subList[index],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                          height: 6,
                        ),
                    itemCount: subList.length),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildSubListField(),
                    ButtonTheme(
                      child: RaisedButton(
                        child:
                            Text('Add', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          print('saveFood Called');

                          // if (!_formKey.currentState.validate()) {
                          //   return;
                          // }
                         
                        _formKey.currentState.save();
                          _addToSubList(subListController.text);
                          print("Element Added");
                          print(subList);
                          currentMyList.subList = subList;

                      
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )

        //  else if(snapshot.hasError){
        //    return Container();

        //  }
        //  else{
        //           return CircularProgressIndicator();
        //  }

        );
  }
}
