import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/list.dart';
import 'package:homesweethome/screens/ShoppingList/list_details.dart';
import 'package:homesweethome/services/list_service.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:provider/provider.dart';

import 'add_list.dart';

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
  
      final listProvider = Provider.of<ListService>(context);



    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.playlist_add,
          size: 30,
        ),
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AddList()));
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
         stream: listProvider.fetchProductsAsStream(),
         builder: (BuildContext context, AsyncSnapshot snapshot) { 
          //  var  at=listNotifier.currentMyList.subList.length; 
           if(snapshot.connectionState==ConnectionState.active){
           if(snapshot.hasData!=null){
                     myList =  snapshot.data.documents
                    .map <MyList> ((doc) => MyList.fromMap ( doc.data, doc.documentID))
                    .toList();
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          onTap: (){
                            listProvider.currentMyList=myList[index];
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return ListDetails();
                            }));

                          },
                      
  
                           title: Text(myList[index].name,style: TextStyle(

                             fontSize: 20
                           ),),
                           subtitle: Row(
                             children: <Widget>[
                               Text(myList[index].id),
                               Expanded(
                                                                child: Text(
                           myList[index].createdAt.toDate().toString()+"/"+
                           myList[index].createdAt.toDate().month.toString()+"/"+
                           myList[index].createdAt.toDate().year.toString(),style: TextStyle(

                             fontSize: 20
                           ),
                          ),
                               ),
                             ],
                           )
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: myList.length);
           }
           else{
             return 
             Container(child: Center(child: Text("There is no data"),));

           }

           }   
           return Container();
      
           
          //  else if(snapshot.hasError){
          //    return Container();

          //  }
          //  else{
          //           return CircularProgressIndicator();                 
          //  }
          
  
        
        }
      ),
    );
  }
}
