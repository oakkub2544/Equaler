import 'package:flutter/material.dart';
import '../screens/news_list_page.dart';
import '../screens/select_category.dart';

//menu component in MenuBar that can navigate to different page
class Menu extends StatelessWidget {
//================== Initial Constructor =======================

  final String menuTitle;
  final List<String> parameter;
  final bool isCategoryPage;

  Menu(
      {required this.menuTitle,
      this.parameter = const ["country=th,gb,us", "language=en,th"],
      required this.isCategoryPage});

//==============================================================

  @override
  Widget build(BuildContext context) {
    return isCategoryPage
        ? ListTile(
            //if this part is navigate to select category page
            title: Text(
                menuTitle
                    .toUpperCase(), //converts all characters in this string to upper case
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () {
              //go to SelectCategory page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectCategory(),
                ),
              );
            },
          )
        : ListTile(
            //if this part not navigate to SelectCategory page
            title: Text(
                menuTitle
                    .toUpperCase(), //converts all characters in this string to upper case
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () {
              //go to NewsListPage page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsListPage(
                      //send parameter via constructor function to NewsListPage
                      headerTitle: menuTitle,
                      parameter: parameter),
                ),
              );
            },
          );
  }
}
