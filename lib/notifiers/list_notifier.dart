import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:homesweethome/models/list.dart';

class ListNotifier with ChangeNotifier{
  List<Armut> _listofArmut=[];
  Armut _currentArmut;
   
   UnmodifiableListView<Armut> get listofArmut=>UnmodifiableListView(_listofArmut);
   Armut get currentArmut=>_currentArmut;     
    
   set listofArmut(List<Armut> listofArmut){
     _listofArmut=listofArmut;
     notifyListeners();
   } 

   set currentArmut(Armut artmut){
     _currentArmut=artmut;
     notifyListeners();

   }



}