import 'package:flutter/material.dart';
import 'components/header_bar.dart';
import 'components/menubar.dart';
import 'components/NewsCard.dart';
import 'components/BigNewsCard.dart';
import 'components/SectionTitle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import './apiHandler.dart';

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
  late Future<dynamic> newsData;

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
            child: Column(
          children: [
            SectionTitle(title: "Suggestion"),
            BigNewsCard(),
            SectionTitle(title: "Popular Today"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              child: FutureBuilder<dynamic>(
                future: newsData,
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

                              )
                            ],
                          );
                        });
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        )));
  }
}
