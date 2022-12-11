import 'package:flutter/material.dart';
import './api_handler.dart';
import './components/news_card_list.dart';
import './components/header_bar.dart';
import './components/more_news_section_title.dart';

class SelectNews extends StatefulWidget {
//Select a news from the news available in the list
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
    //Get data from apiHandler
    thaiNews = apiHandler
        .getNews(["country=th", "language=th", "category=${widget.category}"]);
    engNews = apiHandler.getNews(
        ["country=us,gb", "language=en", "category=${widget.category}"]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: widget.category,
        ),
        body: Center(
            child: Column(children: [
          MoreNewsSectionTitle(title: "Thai News", parameter: [ 
           //Send constructor in MoreNewsSectionTitle class and go to NewsListPage in Thai language
            "country=th",
            "language=th",
            "category= ${widget.category}",
            "Page=0"
          ]),
          NewsCardList( //Display Thai news
            newsData: thaiNews,
            listHeight: MediaQuery.of(context).size.height * 0.325,
            isBigCard: false,
          ),
          MoreNewsSectionTitle(title: "English News", parameter: [
            //Send constructor in MoreNewsSectionTitle class and go to NewsListPage in English language
            "country=gb,us",
            "language=en",
            "category=${widget.category}",
            "Page=0"
          ]),
          NewsCardList( //Display English news
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
