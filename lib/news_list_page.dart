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
  final pageInputController =
      TextEditingController(); //For getting input of the page number that the user wants to go to

  @override
  void initState() {
    super.initState();
    newsData = apiHandler.getNews(widget.Parameter);
  }

  void changePage(int inputPage) {
    //Function for change page in list news
    setState(() {
      widget.Parameter.last =
          "Page=$inputPage"; //Variable to getting inputPage from user
      newsData = apiHandler
          .getNews(widget.Parameter); //Get data from $inputPage passed to api
    });
  }

  Widget LeftButton(double boxWidthSize) {
    //Going to previous page
    return pageNum == 0
        ? SizedBox(
            width: boxWidthSize,
          )
        : TextButton(
            onPressed: () {
              //Minus page number and going to previous page
              if (pageNum > 0) {
                setState(() {
                  pageNum--;
                  changePage(pageNum);
                });
              }
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromRGBO(50, 48, 45, 1),
              size: 20,
            ),
          );
  }

  Widget RightButton(int? nextPage, double boxWidthSize) {
    //Going to next page
    return nextPage == null
        ? SizedBox(
            width: boxWidthSize,
          )
        : TextButton(
            onPressed: () {
              //Plus page number and going to next page
              setState(() {
                pageNum++;
                changePage(pageNum);
              });
            },
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color.fromRGBO(50, 48, 45, 1),
              size: 20,
            ),
          );
  }

  Widget PageInputField(int totalResults, double boxWidthSize) {
    //Filter for accepting input from the user is a positive integer
    return SizedBox(
      width: boxWidthSize,
      child: TextField(
        textAlign: TextAlign.center,
        controller: pageInputController,
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: "${pageNum + 1}"),
        keyboardType: TextInputType.number,
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
          changePage(pageNum);
        }),
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
                //waiting api and display loading animation
                return LoadingIndicator();
              } else if (snapshot.hasData &&
                  snapshot.data['results'].length != 0) {
                //If api has data, display News card
                return CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return NewsCard(
                            //Send constructor and display Newscard
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
                    SliverList(
                      //Display navigator page
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
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
                //api has no data, display error
                return ApiErrorMessage();
              } else if (snapshot.data['results'].length == 0) {
                //data from the api has a length 0, display No News Right Now
                return EmptyNewsListMessage('No news right now');
              }
              // By default, show a loading spinner.
              return LoadingIndicator();
            },
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
  //Custom appbar with the same height, width
}
