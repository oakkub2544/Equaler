import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/components/news_card.dart';
import './components/header_bar.dart';
import '../api_handler.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewsListPage extends StatefulWidget {
  final String Header_Title;
  final List<String> Parameter;
  NewsListPage({this.Header_Title = "Equaler", required this.Parameter});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<Map> newsData;
  int pageNum = 0;
  final pageInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newsData = apiHandler.getNews(widget.Parameter);
    // TODO: implement initState
  }

  void changePage(int inputPage) {
    setState(() {
      widget.Parameter.last = "Page=$inputPage";
      newsData = apiHandler.getNews(widget.Parameter);
    });
  }

  Widget LeftButton(double boxWidthSize) {
    return pageNum == 0
        ? SizedBox(
            width: boxWidthSize,
          )
        : TextButton(
            onPressed: () {
              if (pageNum > 0) {
                setState(() {
                  pageNum--;
                  print(pageNum);
                  changePage(pageNum);
                });
              }
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromRGBO(50, 48, 45, 1),
              size: 20,
            ),
          );
  }

  Widget RightButton(int? nextPage, double boxWidthSize) {
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
            },
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
            future: newsData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                    child: LoadingAnimationWidget.inkDrop(
                  color: Color.fromRGBO(100, 93, 83, 1),
                  size: 50,
                ));
              } else if (snapshot.hasData &&
                  snapshot.data['results'].length != 0) {
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
                          );
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
                                  ),
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
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Icon(
                        Icons.local_shipping_rounded,
                        color: Color.fromRGBO(100, 93, 83, 1),
                        size: 50.0,
                      ),
                    ),
                    Text('News cannot pass in this page',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 2, fontSize: 14)),
                    Text('API Error',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20)),
                  ],
                );
              } else if (snapshot.data['results'].length == 0) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Icon(
                        Icons.local_play_outlined,
                        color: Color.fromRGBO(100, 93, 83, 1),
                        size: 50.0,
                      ),
                    ),
                    Text('No thai news of this category right now',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 2, fontSize: 16)),
                  ],
                );
              }
              return Expanded(
                  child: LoadingAnimationWidget.inkDrop(
                color: Color.fromRGBO(100, 93, 83, 1),
                size: 50,
              ));
              // By default, show a loading spinner.
            },
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
