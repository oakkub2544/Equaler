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
  late Future<dynamic> newsData;

  @override
  void initState() {
    super.initState();
    newsData = apiHandler.getNews(["country=th", "language=th"]);
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
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          NewsCard(
                              imgUrl: snapshot.data[index]['image_url'],
                              newsTitle: snapshot.data[index]['title'],
                              newsDate: snapshot.data[index]['pubDate'],
                              newsDesc: snapshot.data[index]['description'])
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
