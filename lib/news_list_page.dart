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

  Widget LeftButton() {
    return pageNum == 0
        ? const SizedBox.shrink()
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

  Widget RightButton(int? nextPage) {
    return nextPage == null
        ? const SizedBox.shrink()
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
              if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LeftButton(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextField(
                                  controller: pageInputController,
                                  decoration: InputDecoration(
                                      label: Center(
                                    child: Text("${pageNum + 1}"),
                                  )),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^[1-9][0-9]*'))
                                  ],
                                  onSubmitted: (_) => setState(() {
                                    pageNum =
                                        int.parse(pageInputController.text) - 1;
                                    if (pageNum >
                                        (snapshot.data['totalResults'] / 10)
                                            .floor()) {
                                      pageNum =
                                          (snapshot.data['totalResults'] / 10)
                                              .floor();
                                    }
                                    pageInputController.clear();
                                    changePage(pageNum);
                                  }),
                                ),
                              ),
                              RightButton(snapshot.data['nextPage']),
                            ],
                          );
                        },
                        childCount: 1,
                      ),
                    )
                  ],
                );
              }
              return const CircularProgressIndicator();
              // By default, show a loading spinner.
            },
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
