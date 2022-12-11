import 'package:flutter/material.dart';
import '../models/api_handler.dart';
import '../components/header_bar.dart';
import '../components/menu_bar.dart';
import '../components/section_title.dart';
import '../components/news_card_list.dart';

//homepage is the first page in application
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //initial variable to receive data from api
  late Future<Map> suggestNew, popNews;

  //method that is called when object is created
  @override
  void initState() {
    super.initState();

    //get news from ApiHandler
    suggestNew =
        ApiHandler.getNewsMethod(["country=th,gb,us", "language=en,th"]);
    popNews = ApiHandler.getNewsMethod(
        ["country=th,gb,us", "language=en,th", "category=top"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            Headerbar(), //the appBar displays the toolbar widgets, leading, title, and actions
        drawer:
            Menubar(), //a material design panel that slides in horizontally from the edge to show navigation links in an application
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              //display suggestion news by sending parameter via constructor and build NewsCardList
              SectionTitle(title: "Suggestion"),
              NewsCardList(
                newsData: suggestNew,
                listHeight: MediaQuery.of(context).size.height * 0.23,
                isBigCard: true,
              ),
              //display popular news by sending parameter via constructor and build NewsCardList
              SectionTitle(title: "Popular Today"),
              NewsCardList(
                newsData: popNews,
                listHeight: MediaQuery.of(context).size.height * 0.4,
                isBigCard: false,
              ),
            ],
          ),
        )));
  }
}
