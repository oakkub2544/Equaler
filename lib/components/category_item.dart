import 'package:flutter/material.dart';
import 'package:flutter_application_3/select_news.dart';

class CategoryItem extends StatelessWidget {
  final String categoryTitle;

  CategoryItem({this.categoryTitle = 'Natural'});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => selectnew(),
          ),
        )
      },
      borderRadius: BorderRadius.circular(15),
      splashColor: Color.fromRGBO(246, 240, 235, 1),
      child: Container(
        child: Center(
          child: Text(
            categoryTitle,
            style: TextStyle(color: Color.fromRGBO(246, 240, 235, 1)),
          ),
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color.fromRGBO(100, 93, 83, 1),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
