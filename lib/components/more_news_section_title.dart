import 'package:flutter/material.dart';
import './section_title.dart';
import '../screens/news_list_page.dart';

//get parameters from SelectNews page and go to NewsListPage
class MoreNewsSectionTitle extends StatelessWidget {
//================== Initial Constructor =======================

  final String title;
  final List<String> parameter;

  MoreNewsSectionTitle({this.title = "This is title", required this.parameter});

//==============================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
          onTap: () {
            //go to NewsListPage page with thai or english language
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsListPage(
                  //send parameter via constructor function to NewsListPage
                  headerTitle: title,
                  parameter: parameter,
                ),
              ),
            );
          },
          child: SectionTitle(title: title)), // use SectionTitle component
    );
  }
}
