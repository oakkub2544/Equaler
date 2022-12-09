import 'package:flutter/material.dart';
import 'package:flutter_application_3/select_news.dart';

class CategoryItem extends StatelessWidget {
//================== Initial Constructor =======================================
  final String categoryTitle;
  final IconData iconTitle;

  CategoryItem(
      {this.categoryTitle = 'Natural', this.iconTitle = Icons.chevron_left});
//==============================================================================

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => selectnew(category: categoryTitle),
          ),
        )
      }, //Go to selectnews and send constructor to selectnews page
      borderRadius: BorderRadius.circular(15),
      splashColor: Color.fromRGBO(246, 240, 235, 1),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Icon(iconTitle,
                    size: 30, color: Color.fromRGBO(246, 240, 235, 1)),
              ),
              Text(
                categoryTitle,
                style: TextStyle(color: Color.fromRGBO(246, 240, 235, 1)),
              ),
            ],
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
