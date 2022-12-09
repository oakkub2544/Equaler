import 'dart:core';
import 'package:flutter/material.dart';
import './api_handler.dart';
import './components/header_bar.dart';
import './components/menu_bar.dart';
import './components/news_card_list.dart';
import './components/section_title.dart';

void main() => runApp(MyApp());

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
  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  late Future<Map> newsData,
      popData; //Initial variable to receive data from api

  @override
  void initState() {
    //Method that is called when an object for stateful widget
    super.initState();
    newsData = apiHandler.getNews(
        ["country=th,gb,us", "language=en,th"]); //Get news to suggestion
    popData = apiHandler //Get news to popular
        .getNews(["country=th,gb,us", "language=en,th", "category=top"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            Headerbar(), //The AppBar displays the toolbar widgets, leading, title, and actions,
        drawer:
            Sidemenu(), //A Material Design panel that slides in horizontally from the edge to show navigation links in an application.
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              SectionTitle(title: "Suggestion"),
              NewsCardList(
                newsData: popData,
                listHeight: MediaQuery.of(context).size.height * 0.23,
                isBigCard: true,
              ),
              SectionTitle(title: "Popular Today"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.9,
                child: FutureBuilder<dynamic>(
                  future: popData,
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
