import 'dart:core';
import 'package:flutter/material.dart';
import '../read_news.dart';

class NewsCard extends StatelessWidget {
//================== Initial Constructor =======================================

  final String imgUrl;

  final String newsTitle;

  final String newsDate;

  final String newsDesc;

  final String newsContent;

  NewsCard(
      {this.imgUrl = "https://comnplayscience.eu/app/images/notfound.png",
      this.newsTitle = "This is news title",
      this.newsDate = "This is news date",
      this.newsContent = "This is news content",
      this.newsDesc = "This is news description"});
//==============================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => readnew(
                imgUrl1: imgUrl,
                newsTitle1: newsTitle,
                newsDate1: newsDate,
                newsContent1: newsContent,
                newsDesc1: newsDesc),
          ),
        );
      }, //Go to readnews and send constructor to readnews page
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.18,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Color.fromRGBO(246, 240, 235, 1),
          child: LayoutBuilder(builder: (ctx, constraints) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imgUrl,
                      width: constraints.maxWidth * 0.35,
                      height: constraints.maxHeight * 0.9,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(newsDate),
                          Text(
                            newsTitle,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "Read More",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 15,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
