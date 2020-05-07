import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:homesweethome/models/list.dart';

class ListNotifier with ChangeNotifier{
  List<MyList> _listofMyList=[];
  MyList _currentMyList;
   
   UnmodifiableListView<MyList> get listofMyList=>UnmodifiableListView(_listofMyList);
   MyList get currentMyList=>_currentMyList;     
    
   set listofMyList(List<MyList> listofMyList){
     _listofMyList=listofMyList;
     notifyListeners();
   } 

   set currentMyList(MyList artmut){
     _currentMyList=artmut;
     notifyListeners();

   }


}