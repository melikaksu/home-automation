
import 'package:flutter/material.dart';

class CategoryNotifier with ChangeNotifier{

Color _selectedColor=Colors.black;
bool _isSelected=false;
get isSelected=>_isSelected;
get selectedColor =>_selectedColor;
set selectedColor(value){
  _selectedColor=value;
  notifyListeners();
}
set isSelected(value){
  _isSelected=value;
  notifyListeners();
}

}