import 'package:flutter/material.dart';
import './news_card.dart';
import './big_news_card.dart';
import './loading_indicator.dart';
import './api_error_message.dart';
import './empty_news_list_message.dart';

//list of News card
class NewsCardList extends StatelessWidget {
//========================= Initial Constructor ================================

  final Future<Map> newsData;
  final double listHeight;
  final bool isBigCard;
  NewsCardList(
      {required this.newsData,
      required this.listHeight,
      required this.isBigCard});

//==============================================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeight,
      width: MediaQuery.of(context).size.width * 0.9,
      child: FutureBuilder<dynamic>(
        future: newsData, //use newsData as future to build list
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          } else if (snapshot.hasData && snapshot.data['results'].length != 0) {
            //if api has data build card base on isBigCard variable
            return isBigCard
                ?
                //if isBigCard is true then build list of BigNewsCard
                ListView.builder(
                    scrollDirection: Axis
                        .horizontal, // Scroll direction of ListView is vertical
                    itemCount: snapshot.data['results'].length,
                    itemBuilder: (context, index) {
                      return BigNewsCard(
                          //send parameter via constructor function to build BigNewsCard
                          imgUrl: snapshot.data['results'][index]['image_url'],
                          newsTitle: snapshot.data['results'][index]['title'],
                          newsDate: snapshot.data['results'][index]['pubDate'],
                          newsContent: snapshot.data['results'][index]
                              ['content'],
                          newsDesc: snapshot.data['results'][index]
                              ['description']);
                    })
                ////if isBigCard is false then build list of NewsCard
                : ListView.builder(
                    itemCount: snapshot.data['results'].length,
                    itemBuilder: (context, index) {
                      return NewsCard(
                          //send parameter via constructor function to build NewsCard
                          imgUrl: snapshot.data['results'][index]['image_url'],
                          newsTitle: snapshot.data['results'][index]['title'],
                          newsDate: snapshot.data['results'][index]['pubDate'],
                          newsContent: snapshot.data['results'][index]
                              ['content'],
                          newsDesc: snapshot.data['results'][index]
                              ['description']);
                    });
          } else if (!snapshot.hasData) {
            //api has no data, display ApiErrorMessage
            return ApiErrorMessage();
          } else if (snapshot.data['results'].length == 0) {
            //data from the api has a length 0, display EmptyNewsListMessage
            return EmptyNewsListMessage("No News Right Now");
          }
          // by default, show a loading spinner
          return LoadingIndicator();
        },
      ),
    );
  }
}
