import 'package:flutter/material.dart';
import './components/header_bar.dart';
import 'components/category_item.dart';

class selectcategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headerbar(
        headerTitle: 'Select Category',
      ),
      body: GridView(
          padding: EdgeInsets.all(25),
          children: [
            CategoryItem(
                categoryTitle: 'Business',
                iconTitle: Icons.business_center_rounded),
            CategoryItem(
                categoryTitle: 'Entertainment',
                iconTitle: Icons.auto_awesome_rounded),
            CategoryItem(
                categoryTitle: 'Environment',
                iconTitle: Icons.brightness_7_rounded),
            CategoryItem(
                categoryTitle: 'Food', iconTitle: Icons.fastfood_rounded),
            CategoryItem(
                categoryTitle: 'Health',
                iconTitle: Icons.local_hospital_rounded),
            CategoryItem(
                categoryTitle: 'Politics',
                iconTitle: Icons.local_police_rounded),
            CategoryItem(
                categoryTitle: 'Science', iconTitle: Icons.science_rounded),
            CategoryItem(
                categoryTitle: 'Sports',
                iconTitle: Icons.sports_soccer_rounded),
            CategoryItem(
                categoryTitle: 'Technology', iconTitle: Icons.computer_rounded),
            CategoryItem(
                categoryTitle: 'Top', iconTitle: Icons.military_tech_rounded),
            CategoryItem(
                categoryTitle: 'World', iconTitle: Icons.language_rounded)
          ],
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
