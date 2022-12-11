import 'package:flutter/material.dart';
import '../models/api_handler.dart';
import '../components/header_bar.dart';
import '../components/menu_bar.dart';
import '../components/section_title.dart';
import '../components/news_card_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map> newData, popData; //Initial variable to receive data from api

  @override
  void initState() {
    //Method that is called when an object for stateful widget
    super.initState();

    //Get news from apiHandler
    newData = ApiHandler.getNewsMethod(["country=th,gb,us", "language=en,th"]);
    popData = ApiHandler.getNewsMethod(
        ["country=th,gb,us", "language=en,th", "category=top"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            Headerbar(), //The AppBar displays the toolbar widgets, leading, title, and actions
        drawer:
            Menubar(), //A Material Design panel that slides in horizontally from the edge to show navigation links in an application
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
                listHeight: MediaQuery.of(context).size.height *
                    0.4, //responsive design from screen
                isBigCard: false,
              ),
            ],
          ),
        )));
  }
}
