import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './api_handler.dart';
import './components/header_bar.dart';
import './components/menu_bar.dart';
import './components/news_card_list.dart';
import './components/section_title.dart';
import 'package:flutter/services.dart';

void main() {

// This section is for running apps only on vertical pages
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My App",
      home: Myhomepage(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(246, 240, 235, 1),
      ),
    );
  }
}

class Myhomepage extends StatefulWidget {
  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  late Future<Map> newData, popData; //Initial variable to receive data from api

  @override
  void initState() { //Method that is called when an object for stateful widget
    super.initState();
    //Get news from apiHandler
    newData = apiHandler.getNews(["country=th,gb,us", "language=en,th"]);
    popData = apiHandler.getNews(["country=th,gb,us", "language=en,th", "category=top"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(), //The AppBar displays the menu bar, title, and actions
        drawer: Menubar(), //Apanel that slides in horizontally from the edge to show navigation links in an application
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              SectionTitle(title: "Suggestion"),
              NewsCardList(
                //Display Suggestion News by send constructor and call function NewsCardList
                newsData: newData,
                listHeight: MediaQuery.of(context).size.height * 0.23,
                isBigCard: true,
              ),
              SectionTitle(title: "Popular Today"),
              NewsCardList(
                //Display Popular News by send constructor and call function NewsCardList
                newsData: popData,
                listHeight: MediaQuery.of(context).size.height * 0.4, //responsive design from screen
                isBigCard: false,
              ),
            ],
          ),
        )));
  }
}
