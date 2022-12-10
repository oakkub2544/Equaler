import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/news_card_list.dart';
import './api_handler.dart';
import './components/header_bar.dart';
import './components/more_news_section_title.dart';

class SelectNews extends StatefulWidget {
  final String category;
  @override
  SelectNews({this.category = "top"});

  @override
  State<SelectNews> createState() => _SelectNewsState();
}

class _SelectNewsState extends State<SelectNews> {
  late Future<Map> thaiNews, engNews;

  @override
  void initState() {
    super.initState();
    thaiNews = apiHandler
        .getNews(["country=th", "language=th", "category=${widget.category}"]);
    engNews = apiHandler.getNews(
        ["country=us,gb", "language=en", "category=${widget.category}"]);
    // TODO: implement initState
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: widget.category,
        ),
        body: Center(
            child: Column(children: [
          MoreNewsSectionTitle(title: "Thai News", parameter: [
            "country=th",
            "language=th",
            "category= ${widget.category}",
            "Page=0"
          ]),
          NewsCardList(
            newsData: thaiNews,
            listHeight: MediaQuery.of(context).size.height * 0.325,
            isBigCard: false,
          ),
          MoreNewsSectionTitle(title: "English News", parameter: [
            "country=gb,us",
            "language=en",
            "category=${widget.category}",
            "Page=0"
          ]),
          NewsCardList(
            newsData: engNews,
            listHeight: MediaQuery.of(context).size.height * 0.325,
            isBigCard: false,
          )
        ])));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
