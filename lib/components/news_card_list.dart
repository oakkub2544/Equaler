import 'package:flutter/material.dart';
import './news_card.dart';
import './big_news_card.dart';
import './loading_indicator.dart';
import './api_error_message.dart';
import './empty_news_list_message.dart';

class NewsCardList extends StatelessWidget {
  final Future<Map> newsData;
  final double listHeight;
  final bool isBigCard;
  NewsCardList(
      {required this.newsData,
      required this.listHeight,
      required this.isBigCard});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeight,
      width: MediaQuery.of(context).size.width * 0.9,
      child: FutureBuilder<dynamic>(
        future: newsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          } else if (snapshot.hasData && snapshot.data['results'].length != 0) {
            return isBigCard
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data['results'].length,
                    itemBuilder: (context, index) {
                      return BigNewsCard(
                          imgUrl: snapshot.data['results'][index]['image_url'],
                          newsTitle: snapshot.data['results'][index]['title'],
                          newsDate: snapshot.data['results'][index]['pubDate'],
                          newsContent: snapshot.data['results'][index]
                              ['content'],
                          newsDesc: snapshot.data['results'][index]
                              ['description']);
                    })
                : ListView.builder(
                    itemCount: snapshot.data['results'].length,
                    itemBuilder: (context, index) {
                      return NewsCard(
                          imgUrl: snapshot.data['results'][index]['image_url'],
                          newsTitle: snapshot.data['results'][index]['title'],
                          newsDate: snapshot.data['results'][index]['pubDate'],
                          newsContent: snapshot.data['results'][index]
                              ['content'],
                          newsDesc: snapshot.data['results'][index]
                              ['description']);
                    });
          } else if (!snapshot.hasData) {
            return ApiErrorMessage();
          } else if (snapshot.data['results'].length == 0) {
            return EmptyNewsListMessage("No News Right Now");
          }
          // By default, show a loading spinner.
          return LoadingIndicator();
        },
      ),
    );
  }
}
