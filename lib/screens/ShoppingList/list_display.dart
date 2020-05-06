import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/CRUDModel.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
    List<MyList> myList;

  @override
  void initState() {

   
        super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
      final productProvider = Provider.of<CRUDModel>(context);



    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.playlist_add,
          size: 30,
        ),
        onPressed: () {

        },
        elevation: 5,
        highlightElevation: 3,
      ),
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
            'GİDER LİSTESİ',
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
      body: StreamBuilder<QuerySnapshot>(
         stream: productProvider.fetchProductsAsStream(),
         builder: (BuildContext context, AsyncSnapshot snapshot) {     
           if(snapshot.hasData){
                   myList = snapshot.data.documents
                    .map((doc) => MyList.fromMap(doc.data, doc.documentID))
                    .toList();
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
  
                          title: Text(myList[index].name),
                          subtitle: Text(
                           myList[index].createdAt.toDate().day.toString()+"/"+

                           myList[index].createdAt.toDate().month.toString()+"/"+

                            myList[index].createdAt.toDate().year.toString()+"/"



                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: myList.length);
           }
           
           else if(snapshot.hasError){
             return Container();

           }
           else{
                    return CircularProgressIndicator();                 
           }
          
  
        
        }
      ),
    );
  }
}
