import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String categoryTitle;

  CategoryItem({this.categoryTitle = 'Natural'});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      borderRadius: BorderRadius.circular(15),
      splashColor: Color.fromRGBO(246, 240, 235, 1),
      child: Container(
        child: Text(
          categoryTitle,
          style: TextStyle(color: Color.fromRGBO(246, 240, 235, 1)),
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color.fromRGBO(31, 27, 19, 1),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
