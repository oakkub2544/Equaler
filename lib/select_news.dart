import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/news_card_list.dart';
import './api_handler.dart';
import './news_list_page.dart';
import './components/section_title.dart';
import './components/header_bar.dart';

class selectnew extends StatefulWidget {
//================== Initial Constructor =======================
  final String category;
  @override
  selectnew({this.category = "top"});
//==============================================================

  @override
  State<selectnew> createState() => _selectnewState();
}

class _selectnewState extends State<selectnew> {
  late Future<Map> thaiNews, engNews;
  void initState() {
    super.initState();
    thaiNews = apiHandler.getNews([
      "country=th",
      "language=th",
      "category=${widget.category}"
    ]); //Get data from apiHandler
    engNews = apiHandler.getNews([
      "country=us,gb",
      "language=en",
      "category=${widget.category}"
    ]); //Get data from apiHandler
    // TODO: implement initState
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: 'category=${widget.category}',
        ),
        body: Center(
            child: Column(children: [
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsListPage(
                      Header_Title: "Thai News",
                      Parameter: [
                        "country=th",
                        "language=th",
                        "category= ${widget.category}",
                        "Page=0"
                      ],
                    ),
                  ),
                );
              }, //Send constructor and go to NewsListPage in Thai language
              child: Container(child: SectionTitle(title: "Thai News"))),
          NewsCardList(
            newsData: thaiNews,
            listHeight: MediaQuery.of(context).size.height * 0.3,
            isBigCard: false,
          ), //Display Thai news
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsListPage(
                      Header_Title: "English News",
                      Parameter: [
                        "country=gb,us",
                        "language=en",
                        "category=${widget.category}",
                        "Page=0"
                      ],
                    ),
                  ),
                );
              }, //Send constructor and go to NewsListPage in English language
              child: Container(child: SectionTitle(title: "English News"))),
          NewsCardList(
            newsData: engNews,
            listHeight: MediaQuery.of(context).size.height * 0.3,
            isBigCard: false,
          ) //Display English news
        ])));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
  //Custom appbar with the same height, width
}
