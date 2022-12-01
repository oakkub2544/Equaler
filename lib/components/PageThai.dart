import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/NewsCard.dart';
import 'package:flutter_application_3/components/SectionTitle.dart';
import 'header_bar.dart';
import 'CategoryItem.dart';
import '../apiHandler.dart';

class PageThai extends StatefulWidget {
  const PageThai({Key? key}) : super(key: key);

  @override
  State<PageThai> createState() => _PageThaiState();
}

class _PageThaiState extends State<PageThai> {
  ScrollController scrollController = ScrollController();
  late Future<dynamic> newsData;
  int pageNum = 0;

  @override
  void initState() {
    super.initState();
    newsData = apiHandler
        .getNews(["country=th,gb,us", "language=en,th", "Page=$pageNum"]);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pageNum++;
        setState(() {
          newsData = apiHandler
              .getNews(["country=th,gb,us", "language=en,th", "Page=$pageNum"]);
        });
      }
    });
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: 'Thai News',
        ),
        body: Center(
          child: FutureBuilder<dynamic>(
            future: newsData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    controller: scrollController,
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
