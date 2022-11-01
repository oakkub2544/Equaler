import 'package:flutter/material.dart';
import 'components/header_bar.dart';
import 'components/menubar.dart';
import 'components/NewsCard.dart';
import 'components/BigNewsCard.dart';
import 'components/SectionTitle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

getNews() async {
  final url = Uri.parse(
      "https://newsdata.io/api/1/news?apikey=pub_124249313445c3671fd4d175e97415511a437&language=en,th");
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    Map jsonResponse = jsonDecode(response.body);
    List resultsResponse = jsonResponse['results'];
    return resultsResponse;
  }
}
// ===========================================================================

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(),
        drawer: Sidemenu(),
        body: Center(
            child: Column(children: [
          SectionTitle("Suggestion"),
          BigNewsCard(),
          SectionTitle("Popular Today"),
          NewsCard(),
          NewsCard(),
        ])));
  }
}
