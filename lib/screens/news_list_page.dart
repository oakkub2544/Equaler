import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/api_handler.dart';
import '../components/news_card.dart';
import '../components/header_bar.dart';
import '../components/loading_indicator.dart';
import '../components/api_error_message.dart';
import '../components/empty_news_list_message.dart';

//page that display news list and can go to the next or previous page
class NewsListPage extends StatefulWidget {
//========================= Initial Constructor ===========================

  final String headerTitle;
  final List<String> parameter;
  NewsListPage({this.headerTitle = "Equaler", required this.parameter});

//=========================================================================
  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<Map> newsData;
  int pageNum = 0;
  //for getting input of the page number that the user wants to go to
  final pageInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newsData = ApiHandler.getNewsMethod(widget.parameter);
  }

  //function for change page in news list
  void changePageMethod(int inputPage) {
    setState(() {
      //set page that user want to go to
      widget.parameter.last = "Page=$inputPage";
      //get news from ApiHandler
      newsData = ApiHandler.getNewsMethod(widget.parameter);
    });
  }

  //widget to go to previous page
  Widget LeftButton(double boxWidthSize) {
    return pageNum == 0
        ? SizedBox(
            width: boxWidthSize,
          )
        : Semantics(
            label: "Previous page button",
            child: TextButton(
              onPressed: () {
                //minus page number and going to previous page
                if (pageNum > 0) {
                  setState(() {
                    pageNum--;
                    changePageMethod(pageNum);
                  });
                }
              },
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color.fromRGBO(50, 48, 45, 1),
                size: 20,
              ),
            ),
          );
  }

  //widget to go to next page
  Widget RightButton(int? nextPage, double boxWidthSize) {
    return nextPage == null
        ? SizedBox(
            width: boxWidthSize,
          )
        : Semantics(
            label: "Next page button",
            child: TextButton(
              onPressed: () {
                //plus page number and going to next page
                setState(() {
                  pageNum++;
                  changePageMethod(pageNum);
                });
              },
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color.fromRGBO(50, 48, 45, 1),
                size: 20,
              ),
            ),
          );
  }

  //input field to get page number from user
  Widget PageInputField(int totalResults, double boxWidthSize) {
    return Semantics(
      label: "Select Page",
      child: SizedBox(
        width: boxWidthSize,
        child: TextField(
          textAlign: TextAlign.center,
          controller: pageInputController,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "${pageNum + 1}"),
          keyboardType: TextInputType.number,
          //filter only a positive integer from user
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))
          ],
          onSubmitted: (_) => setState(() {
            pageNum = int.parse(pageInputController.text) - 1;
            int totalPage = (totalResults / 10).floor();
            if (pageNum > totalPage) {
              pageNum = totalPage;
            }
            pageInputController.clear();
            changePageMethod(pageNum);
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: widget.headerTitle,
        ),
        body: Center(
          child: FutureBuilder<dynamic>(
            future: newsData, //use newsData as future to build list
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                //waiting for api and display loading animation
                return LoadingIndicator();
              } //if api has data
              else if (snapshot.hasData &&
                  snapshot.data['results'].length != 0) {
                return CustomScrollView(
                  slivers: [
                    //display list of News card
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
                          );
                        },
                        childCount: snapshot.data['results'].length,
                      ),
                    ),
                    //display navigator to navigate through page
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
                                PageInputField(snapshot.data['totalResults'],
                                    MediaQuery.of(context).size.width * 0.5),
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
                //api has no data, display ApiErrorMessage
                return ApiErrorMessage();
              } else if (snapshot.data['results'].length == 0) {
                //data from the api has a length 0, display EmptyNewsListMessage
                return EmptyNewsListMessage('No news right now');
              }
              // by default, show a loading spinner
              return LoadingIndicator();
            },
          ),
        ));
  }

  //custom appbar with the same height
  @override
  Size get preferredSize => Size.fromHeight(60);
}
