import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/news_card.dart';
import 'package:flutter_application_3/components/section_title.dart';
import './components/header_bar.dart';
import 'api_handler.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dio/dio.dart';
import 'news_list_page.dart';

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
        ["country=us,gb", "language=en", "category= ${widget.category}"]);
    // TODO: implement initState
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: 'Select News',
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
                        "Page=0",
                        "category= ${widget.category} "
                      ],
                    ),
                  ),
                );
              },
              child: Container(child: SectionTitle(title: "Thai News"))),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            child: FutureBuilder<dynamic>(
              future: thaiNews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                      child: LoadingAnimationWidget.inkDrop(
                    color: Color.fromRGBO(100, 93, 83, 1),
                    size: 50,
                  ));
                } else if (snapshot.hasData && snapshot.data.length != 0) {
                  print(snapshot.data.length);
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
                } else if (!snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Icon(
                          Icons.local_shipping_rounded,
                          color: Color.fromRGBO(100, 93, 83, 1),
                          size: 50.0,
                        ),
                      ),
                      Text('News cannot pass in this page',
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 2, fontSize: 14)),
                      Text('API Error',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)),
                    ],
                  );
                } else if (snapshot.data.length == 0) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Icon(
                          Icons.local_play_outlined,
                          color: Color.fromRGBO(100, 93, 83, 1),
                          size: 50.0,
                        ),
                      ),
                      Text('No thai news of this category right now',
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 2, fontSize: 16)),
                    ],
                  );
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
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
                        "Page=0",
                        "category= ${widget.category} "
                      ],
                    ),
                  ),
                );
              },
              child: Container(child: SectionTitle(title: "English News"))),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            child: FutureBuilder<dynamic>(
              future: engNews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                      child: LoadingAnimationWidget.inkDrop(
                    color: Color.fromRGBO(100, 93, 83, 1),
                    size: 50,
                  ));
                } else if (snapshot.hasData) {
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
                } else if (!snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Icon(
                          Icons.local_shipping_rounded,
                          color: Color.fromRGBO(100, 93, 83, 1),
                          size: 50.0,
                        ),
                      ),
                      Text('News cannot pass in this page',
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 2, fontSize: 14)),
                      Text('API Error',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)),
                    ],
                  );
                } else if (snapshot.data.length == 0) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Icon(
                          Icons.local_play_outlined,
                          color: Color.fromRGBO(100, 93, 83, 1),
                          size: 50.0,
                        ),
                      ),
                      Text('No thai news of this category right now',
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 2, fontSize: 16)),
                    ],
                  );
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          )
        ])));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
