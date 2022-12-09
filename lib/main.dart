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
  late Future<Map> suggestData,
      popData; //Initial variable to receive data from api

  @override
  void initState() {
    //Method that is called when an object for stateful widget
    super.initState();
    suggestData = apiHandler.getNews(
        ["country=th,gb,us", "language=en,th"]); //Get news from apiHandler
    popData = apiHandler.getNews([
      "country=th,gb,us",
      "language=en,th",
      "category=top"
    ]); //Get news from apiHandler
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(),
        //The AppBar displays the toolbar widgets, leading, title, and actions
        drawer: Sidemenu(),
        //A Material Design panel that slides in horizontally from the edge to show navigation links in an application
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              SectionTitle(title: "Suggestion"),
              NewsCardList(
                newsData: suggestData,
                listHeight: MediaQuery.of(context).size.height * 0.23,
                isBigCard: true,
              ), //Display Suggestion News
              SectionTitle(title: "Popular Today"),
              NewsCardList(
                newsData: popData,
                listHeight: MediaQuery.of(context).size.height * 0.4,
                isBigCard: false,
              ), //Display Popular News
            ],
          ),
        )));
  }
}
