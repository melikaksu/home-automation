import 'package:flutter/material.dart';
import 'package:homesweethome/notifiers/category_notifier.dart';
import 'package:homesweethome/theme/palette.dart';
import 'package:provider/provider.dart';

class ColorGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoryNotifier model = Provider.of<CategoryNotifier>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Scrollbar(
        child: GridView.count(
          shrinkWrap: true,
          primary: true,
          physics: BouncingScrollPhysics(),
          crossAxisCount: 5,
          children: materialColors.map((color) {
            return Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: GestureDetector(
                  child: Container(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(
                          color.red,
                          color.green,
                          color.blue,
                          1.0,
                        ),
                      ),
                      child: model.isSelected ? Icon(Icons.check) : null,
                    ),
                  ),
                  onTap: () {
                    model.selectedColor(color);
                    model.isSelected = !model.isSelected;
                  },
                ));
          }).toList(),
        ),
      ),
    );
  }
}

// class ColorButton extends StatelessWidget {
//   final Color _color;

//   ColorButton(this._color,);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         child: DecoratedBox(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color.fromRGBO(
//               _color.red,
//               _color.green,
//               _color.blue,
//               1.0,
//             ),
//           ),
//           child: model.isSelected ? Icon(Icons.check) : null,
//         ),
//       ),
//       onTap: () {
//       model.selectedColor(_color);
//       model.isSelected=!model.isSelected;
//       },
//     );
//   }
// }
