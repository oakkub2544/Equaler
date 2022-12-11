import 'package:flutter/material.dart';
import '../models/api_handler.dart';
import '../components/news_card_list.dart';
import '../components/header_bar.dart';
import '../components/more_news_section_title.dart';

//page that let user choose between thai news or english news of chosen category
class SelectNews extends StatefulWidget {
//================== Initial Constructor =======================

  final String category;
  @override
  SelectNews({this.category = "top"});

//==============================================================
  @override
  State<SelectNews> createState() => _SelectNewsState();
}

class _SelectNewsState extends State<SelectNews> {
  late Future<Map> thaiNews, engNews;

  @override
  void initState() {
    super.initState();
    //get data from apiHandler
    thaiNews = ApiHandler.getNewsMethod(
        ["country=th", "language=th", "category=${widget.category}"]);
    engNews = ApiHandler.getNewsMethod(
        ["country=us,gb", "language=en", "category=${widget.category}"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: widget.category,
        ),
        body: Center(
            child: Column(children: [
          //go to NewsListPage that show only thai news with this category
          MoreNewsSectionTitle(title: "Thai News", parameter: [
            "country=th",
            "language=th",
            "category= ${widget.category}",
            "Page=0"
          ]),
          //display thai news list
          NewsCardList(
            newsData: thaiNews,
            listHeight: MediaQuery.of(context).size.height * 0.325,
            isBigCard: false,
          ),
          //go to NewsListPage that show only english news with this category
          MoreNewsSectionTitle(title: "English News", parameter: [
            "country=gb,us",
            "language=en",
            "category=${widget.category}",
            "Page=0"
          ]),
          //display english news list
          NewsCardList(
            newsData: engNews,
            listHeight: MediaQuery.of(context).size.height * 0.325,
            isBigCard: false,
          )
        ])));
  }

  @override
  //Custom appbar with the same height, width
  Size get preferredSize => Size.fromHeight(60);
}
