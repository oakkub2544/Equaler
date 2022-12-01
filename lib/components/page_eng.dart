import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/news_card.dart';
import 'package:flutter_application_3/components/section_title.dart';
import 'header_bar.dart';
import 'category_item.dart';
import '../api_handler.dart';

class PageEng extends StatefulWidget {
  const PageEng({Key? key}) : super(key: key);

  @override
  State<PageEng> createState() => _PageEngState();
}

class _PageEngState extends State<PageEng> {
  late Future<dynamic> newsData;

  @override
  void initState() {
    super.initState();
    newsData = apiHandler.getNews(["country=gb,us", "language=en"]);
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: 'English News',
        ),
        body: Center(
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
                            newsContent: snapshot.data[index]['content'],
                          )
                        ],
                      );
                    });
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
