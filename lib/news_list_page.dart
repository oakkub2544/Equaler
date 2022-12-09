import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './api_handler.dart';
import './components/news_card.dart';
import './components/header_bar.dart';
import './components/loading_indicator.dart';
import './components/api_error_message.dart';
import './components/empty_news_list_message.dart';

class NewsListPage extends StatefulWidget {
//========================= Initial Constructor ===========================
  final String Header_Title;
  final List<String> Parameter;
  NewsListPage({this.Header_Title = "Equaler", required this.Parameter});
//=========================================================================

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<Map> newsData;
  int pageNum = 0;
  final pageInputController = TextEditingController();

  @override
  void initState() {
    //Method that is called when an object for stateful widget
    super.initState();
    newsData = apiHandler.getNews(widget.Parameter);
  }

  void changePage(int inputPage) {
    //Function for change page in list news
    setState(() {
      widget.Parameter.last = "Page=$inputPage";
      //Variable to receive inputPage from user
      newsData = apiHandler.getNews(widget.Parameter);
      //Get data from $inputPage sent to api
    });
  }

  Widget LeftButton(double boxWidthSize) {
    //If user return to previous page
    return pageNum == 0
        ? SizedBox(
            width: boxWidthSize,
          )
        : TextButton(
            onPressed: () {
              if (pageNum > 0) {
                setState(() {
                  pageNum--;
                  changePage(pageNum);
                });
              }
            }, //minus page number
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromRGBO(50, 48, 45, 1),
              size: 20,
            ),
          );
  }

  Widget RightButton(int? nextPage, double boxWidthSize) {
    //If user going to next page
    return nextPage == null
        ? SizedBox(
            width: boxWidthSize,
          )
        : TextButton(
            onPressed: () {
              setState(() {
                pageNum++;
                changePage(pageNum);
              });
            }, //plus page number
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color.fromRGBO(50, 48, 45, 1),
              size: 20,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: widget.Header_Title,
        ),
        body: Center(
          child: FutureBuilder<dynamic>(
            future: newsData, //Set newsData to future type
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                //waiting api, display loading animation
                return LoadingIndicator();
              } else if (snapshot.hasData && snapshot.data['results'].length != 0) {
                //api has data
                return CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return NewsCard(
                            imgUrl: snapshot.data['results'][index]
                                ['image_url'],
                            newsTitle: snapshot.data['results'][index]['title'],
                            newsDate: snapshot.data['results'][index]
                                ['pubDate'],
                            newsContent: snapshot.data['results'][index]
                                ['content'],
                          ); //Send constructor to Newscard
                        },
                        childCount: snapshot.data['results'].length,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LeftButton(
                                    MediaQuery.of(context).size.width * 0.165),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: pageInputController,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: "${pageNum + 1}"),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^[1-9][0-9]*'))
                                    ],
                                    onSubmitted: (_) => setState(() {
                                      pageNum =
                                          int.parse(pageInputController.text) -
                                              1;
                                      int totalPage =
                                          (snapshot.data['totalResults'] / 10)
                                              .floor();
                                      if (pageNum > totalPage) {
                                        pageNum = totalPage;
                                      }
                                      pageInputController.clear();
                                      changePage(pageNum);
                                    }),
                                  ), //Filters for accepting input from the user is a positive integer
                                ),
                                RightButton(snapshot.data['nextPage'],
                                    MediaQuery.of(context).size.width * 0.165),
                              ],
                            ),
                          );
                        },
                        childCount: 1,
                      ),
                    )
                  ],
                );
              } else if (!snapshot.hasData) {
                return ApiErrorMessage();
              } else if (snapshot.data['results'].length == 0) {
                return EmptyNewsListMessage('No news right now');
              }
              return LoadingIndicator();
            },
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
  //Custom appbar with the same height, width
}
