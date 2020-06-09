import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homesweethome/models/category.dart';
import 'package:homesweethome/notifiers/category_notifier.dart';
import 'package:homesweethome/services/firestore_service.dart';
import 'package:homesweethome/shared/my_drawer.dart';
import 'package:homesweethome/theme/icon_grid.dart';
import 'package:homesweethome/theme/icons.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateCategory extends StatefulWidget {
  final LinkedHashMap<String, IconData> assignableIcons;
  CreateCategory()
      : this.assignableIcons = LinkedHashMap.from(icons)
          ..removeWhere((key, value) => key == 'add');

  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  String _iconName;
  Color color;
  int selected;
  MapEntry<String, IconData> selectedIcon;
  Timestamp createdAt = Timestamp.now();
  String name;
  TextEditingController _nameController = TextEditingController();
  ColorSwatch _mainColor = Colors.blue;
  ColorSwatch _tempMainColor;

  @override
  Widget build(BuildContext context) {
    final fireServ = Provider.of<FirestoreDatabase>(context, listen: false);
    CategoryNotifier model = Provider.of<CategoryNotifier>(context);

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
              'Add Category',
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
                  FontAwesomeIcons.solidSave,
                  color: Color(0xff2d386b),
                ),
                onPressed: () {
                  fireServ.createCategory(Category(
                    id: Uuid().v4(),
                    name: name,
                    icon: _iconName,
                    color: _mainColor,
                  ));
                })
          ],
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextFormField(
                onChanged: (a) => this.name = a,
                keyboardType: TextInputType.number,
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name: "),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: IconGrid(
                  selectedCategory: name,
                  onTap: (String newCategory) => setState(() {
                    _iconName = newCategory;
                    print(_iconName);
                  }),
                  selectedColor: _mainColor,
                ),
              ),
            ),
            Expanded(
              child: MaterialColorPicker(
                circleSize: 50.0,
                colors: fullMaterialColors,
                selectedColor: _mainColor,
                onMainColorChange: (color) =>
                    setState(() { _tempMainColor = color;
                                  _mainColor=_tempMainColor;
                    }),
              ),
            ),
          ],
        ));
  }
}
