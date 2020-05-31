import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:homesweethome/theme/icons.dart';
import 'package:homesweethome/theme/palette.dart' as Palette;

class IconGrid extends StatefulWidget {
  final Color selectedColor;
  final String selectedCategory;
  final Function(String) onTap;
  final LinkedHashMap<String, IconData> assignableIcons;
  IconGrid({
    @required this.selectedColor,
    // @required 
    this.onTap,this.selectedCategory,}) : this.assignableIcons = LinkedHashMap.from(icons)
          ..removeWhere((key, value) => key == 'add');


  @override
  State<StatefulWidget> createState() => IconGridState(onTap, selectedCategory);
}

class IconGridState extends State<IconGrid> {
  String _selectedCategory;
  Function(String) _onTap;

  IconGridState(this._onTap, this._selectedCategory);

  void _handleTap(String newCategory) {
    _onTap(newCategory);

    setState(() {
      _selectedCategory = newCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Scrollbar(
        child: GridView.count(
          shrinkWrap: true,
          primary: true,
          physics: BouncingScrollPhysics(),
          crossAxisCount: 5,
          children: widget.assignableIcons.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: SelectableIconButton(  
                _selectedCategory == entry.key,
                _handleTap,
                name:entry.key,
                iconData:entry.value,
                color:widget.selectedColor,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class SelectableIconButton extends StatelessWidget {
  final String name;
  final IconData iconData;
  final Color color;
  final bool _isSelected;
  final Function(String) _onTap;

  SelectableIconButton(
    this._isSelected,
    this._onTap,

    {this.name,
    this.iconData,
    this.color}
   
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: DecoratedBox(
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isSelected ? color : Palette.lightGrey,
          ),
          child: Icon(
            iconData,
            color: _isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
      onTap: () => _onTap(name),
    );
  }
}
