import 'package:flutter/material.dart';
import './section_title.dart';
import '../news_list_page.dart';

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
          onTap: () { //Go to NewsListPage in Thai/Eng language
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsListPage(//Send constructor to NewsListPage
                  Header_Title: title,
                  Parameter: parameter,
                ),
              ),
            );
          },
          child: SectionTitle(title: title)), // call SectionTitle class
    );
  }
}
