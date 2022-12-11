import 'package:flutter/material.dart';
import '../components/header_bar.dart';
import '../components/category_item.dart';
import '../models/category_info.dart';

class SelectCategory extends StatelessWidget {
  //Seperate news content by category
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headerbar(
        headerTitle: 'Select Category',
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: const EdgeInsets.all(25),
        itemCount: 11,
        itemBuilder: (context, index) {
          return CategoryItem(
            categoryTitle: CategoryInfo.allCategoryName[index],
            iconTitle: CategoryInfo.allCategoryIcon[index],
          );
        },
      ),
    );
  }

  @override
  //Custom appbar with the same height, width
  Size get preferredSize => Size.fromHeight(60);
}
