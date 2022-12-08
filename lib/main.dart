import 'package:flutter/material.dart';
import 'components/header_bar.dart';
import 'components/menu_bar.dart';
import 'components/news_card.dart';
import 'components/big_news_card.dart';
import 'components/section_title.dart';
import 'dart:core';
import 'api_handler.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(MyApp());
}
// ===========================================================================

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: Myhomepage(),
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromRGBO(246, 240, 235, 1)),
    );
  }
}

class Myhomepage extends StatefulWidget {
  const Myhomepage({Key? key}) : super(key: key);

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  late Future<Map> newsData;

  @override
  void initState() {
    super.initState();
    newsData = apiHandler.getNews(["country=th,gb,us", "language=en,th"]);
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(),
        drawer: Sidemenu(),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              SectionTitle(title: "Suggestion"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.width * 0.9,
                child: FutureBuilder<dynamic>(
                  future: newsData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                          child: LoadingAnimationWidget.inkDrop(
                        color: Color.fromRGBO(100, 93, 83, 1),
                        size: 50,
                      ));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data['results'].length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                BigNewsCard(
                                    imgUrl: snapshot.data['results'][index]
                                        ['image_url'],
                                    newsTitle: snapshot.data['results'][index]
                                        ['title'],
                                    newsDate: snapshot.data['results'][index]
                                        ['pubDate'],
                                    newsContent: snapshot.data['results'][index]
                                        ['content'],
                                    newsDesc: snapshot.data['results'][index]
                                        ['description'])
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
              SectionTitle(title: "Popular Today"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.9,
                child: FutureBuilder<dynamic>(
                  future: newsData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                          child: LoadingAnimationWidget.inkDrop(
                        color: Color.fromRGBO(100, 93, 83, 1),
                        size: 50,
                      ));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data['results'].length,
                          itemBuilder: (context, index) {
                            return NewsCard(
                                imgUrl: snapshot.data['results'][index]
                                    ['image_url'],
                                newsTitle: snapshot.data['results'][index]
                                    ['title'],
                                newsDate: snapshot.data['results'][index]
                                    ['pubDate'],
                                newsContent: snapshot.data['results'][index]
                                    ['content'],
                                newsDesc: snapshot.data['results'][index]
                                    ['description']);
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
            ],
          ),
        )));
  }
}
