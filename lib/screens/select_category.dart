import 'package:flutter/material.dart';
import '../components/header_bar.dart';
import '../components/category_item.dart';
import '../models/category_info.dart';

//page that let user choose news category
class SelectCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headerbar(
        headerTitle: 'Select Category',
      ),
      body: GridView.builder(
        //creates grid layouts with tiles that each have a maximum cross-axis extent
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: const EdgeInsets.all(25),
        itemCount: 11,
        itemBuilder: (context, index) {
          //call CategoryItem class then go to select news page by sending the news category
          return CategoryItem(
            categoryTitle: CategoryInfo.allCategoryName[index],
            iconTitle: CategoryInfo.allCategoryIcon[index],
          );
        },
      ),
    );
  }

  //custom appbar with the same height
  @override
  Size get preferredSize => Size.fromHeight(60);
}
