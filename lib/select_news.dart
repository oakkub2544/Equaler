import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/news_card_list.dart';
import './api_handler.dart';
import './news_list_page.dart';
import './components/section_title.dart';
import './components/header_bar.dart';

class selectnew extends StatefulWidget {
  final String category;
  @override
  selectnew({this.category = "top"});

  @override
  State<selectnew> createState() => _selectnewState();
}

class _selectnewState extends State<selectnew> {
  late Future<Map> thaiNews, engNews;
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
          headerTitle: '${widget.category}',
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                },
                child: Container(child: SectionTitle(title: "Thai News"))),
            NewsCardList(
              newsData: thaiNews,
              listHeight: MediaQuery.of(context).size.height * 0.325,
              isBigCard: false,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: InkWell(
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
                  },
                  child: Container(child: SectionTitle(title: "English News"))),
            ),
            NewsCardList(
              newsData: engNews,
              listHeight: MediaQuery.of(context).size.height * 0.325,
              isBigCard: false,
            )
          ]),
        )));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
