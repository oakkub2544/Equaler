import 'package:flutter/material.dart';
import '../select_news.dart';

class CategoryItem extends StatelessWidget {
//Gets data from CategoryItem and goes to SelectNews page by category
//========================= Initial Constructor ================================

  final String categoryTitle;
  final IconData iconTitle;

  CategoryItem(
      {this.categoryTitle = 'Top', this.iconTitle = Icons.chevron_left});
//==============================================================================

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => { //Go to selectnews SelectNews by category
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectNews(category: categoryTitle), //send constructor to selectnews page
          ),
        )
      },
      borderRadius: BorderRadius.circular(15),
      splashColor: const Color.fromRGBO(246, 240, 235, 1),
      child: Container(
        //Format the category box
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(100, 93, 83, 1),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Icon(iconTitle,
                    size: 30, color: const Color.fromRGBO(246, 240, 235, 1)),
              ),
              Text(
                categoryTitle,
                style: const TextStyle(color: Color.fromRGBO(246, 240, 235, 1)),
              ),
            ],
          )),
    );
  }
}
