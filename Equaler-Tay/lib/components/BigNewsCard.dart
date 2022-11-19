import 'package:flutter/material.dart';

class BigNewsCard extends StatelessWidget {
  final String imgUrl;

  final String newsTitle;

  final String newsDate;

  BigNewsCard(
      {this.imgUrl = "https://picsum.photos/seed/137/600",
      this.newsTitle = "This is news title",
      this.newsDate = "This is news date"});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Color.fromRGBO(246, 240, 235, 1),
          child: LayoutBuilder(builder: (ctx, constraints) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      imgUrl,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.436,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7, top: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(newsDate),
                            Text(
                              newsTitle,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
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
