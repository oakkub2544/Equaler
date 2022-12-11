import 'package:flutter/material.dart';
import './section_title.dart';
import '../screens/news_list_page.dart';

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
            //Go to NewsListPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsListPage(
                  //Send constructor to NewsListPage
                  headerTitle: title,
                  parameter: parameter,
                ),
              ),
            );
          },
          child: SectionTitle(title: title)),
    );
  }
}
