import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/news_card.dart';
import 'package:flutter_application_3/components/section_title.dart';
import 'package:flutter_application_3/read_news.dart';
import './components/header_bar.dart';
import 'api_handler.dart';
import '../news_list_page.dart';

class selectnew extends StatefulWidget {
  final String category;
  @override
  selectnew({this.category = "top"});

  @override
  State<selectnew> createState() => _selectnewState();
}

class _selectnewState extends State<selectnew> {
  late Future<dynamic> thaiNews, engNews;
  void initState() {
    super.initState();
    thaiNews = apiHandler.getNews(
        ["country=th", "language=th", "category= ${widget.category} "]);
    engNews = apiHandler.getNews(
        ["country=us,gb", "language=en", "category= ${widget.category} "]);
    // TODO: implement initState
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: 'Select News',
        ),
        body: Center(
            child: Column(children: [
          GestureDetector(
            child: SectionTitle(
              title: "Thai News",
            ),
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
                      "Page=0",
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.34,
            width: MediaQuery.of(context).size.width * 0.9,
            child: FutureBuilder<dynamic>(
              future: thaiNews,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            NewsCard(
                                imgUrl: snapshot.data[index]['image_url'],
                                newsTitle: snapshot.data[index]['title'],
                                newsDate: snapshot.data[index]['pubDate'],
                                newsContent: snapshot.data[index]['content'],
                                newsDesc: snapshot.data[index]['description'])
                          ],
                        );
                      });
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
          GestureDetector(
            child: SectionTitle(
              title: "English News",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsListPage(
                    Header_Title: "English News",
                    Parameter: [
                      "country=us",
                      "language=en",
                      "category= ${widget.category}",
                      "Page=0",
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.34,
            width: MediaQuery.of(context).size.width * 0.9,
            child: FutureBuilder<dynamic>(
              future: engNews,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            NewsCard(
                                imgUrl: snapshot.data[index]['image_url'],
                                newsTitle: snapshot.data[index]['title'],
                                newsDate: snapshot.data[index]['pubDate'],
                                newsContent: snapshot.data[index]['content'],
                                newsDesc: snapshot.data[index]['description'])
                          ],
                        );
                      });
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ])));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
