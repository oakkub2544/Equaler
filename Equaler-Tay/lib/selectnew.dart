import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/NewsCard.dart';
import 'package:flutter_application_3/components/SectionTitle.dart';
import './components/header_bar.dart';
import './components/CategoryItem.dart';

class selectnew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: 'Select Category',
        ),
        body: Center(
            child: Column(children: [
          SectionTitle(title: "Thai News"),
          NewsCard(),
          SectionTitle(title: "English News"),
          NewsCard()
        ])));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
