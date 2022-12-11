import 'package:flutter/material.dart';
import '../screens/select_news.dart';

//category button in SelectCategory page
class CategoryItem extends StatelessWidget {
//========================= Initial Constructor ================================

  final String categoryTitle;
  final IconData iconTitle;

  CategoryItem(
      {this.categoryTitle = 'Top', this.iconTitle = Icons.chevron_left});

//==============================================================================

  @override
  Widget build(BuildContext context) {
    //go to SelectNews by category
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            //send constructor to SelectNews page
            builder: (context) => SelectNews(category: categoryTitle),
          ),
        )
      },
      borderRadius: BorderRadius.circular(15),
      splashColor: const Color.fromRGBO(246, 240, 235, 1),
      child: Container(
          //format the category box
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(100, 93, 83, 1),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //category icon
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Icon(iconTitle,
                    size: 30, color: const Color.fromRGBO(246, 240, 235, 1)),
              ),
              //category title
              Text(
                categoryTitle,
                style: const TextStyle(color: Color.fromRGBO(246, 240, 235, 1)),
              ),
            ],
          )),
    );
  }
}
