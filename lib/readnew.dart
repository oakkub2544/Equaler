import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/NewsCard.dart';
import 'package:flutter_application_3/components/SectionTitle.dart';
import './components/header_bar.dart';
import './components/CategoryItem.dart';

class readnew extends StatelessWidget {
  final String imgUrl;

  final String newsTitle1;

  final String newsDate1;

  readnew(
      {this.imgUrl = "https://picsum.photos/seed/137/600",
      this.newsTitle1 = "This is news title",
      this.newsDate1 = "This is news date"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Headerbar(
          headerTitle: 'Read News',
        ),
        body: Container(child: LayoutBuilder(builder: (ctx, constraints) {
          return Column(children: [
            SectionTitle(title: newsTitle1),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imgUrl,
                width: constraints.maxWidth * 0.9,
                height: constraints.maxHeight * 0.35,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [Text(newsDate1)],
                ),
              ),
            ),
          ]);
        })));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
