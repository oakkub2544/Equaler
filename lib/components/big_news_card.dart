import 'package:flutter/material.dart';
import '../screens/read_news.dart';

//card for suggestion news
class BigNewsCard extends StatelessWidget {
//========================= Initial Constructor ============================

  final String imgUrl;
  final String newsTitle;
  final String newsDate;
  final String newsDesc;
  final String newsContent;

  BigNewsCard(
      {this.imgUrl = "https://comnplayscience.eu/app/images/notfound.png",
      this.newsTitle = "This is news title",
      this.newsDate = "This is news date",
      this.newsContent = "This is news content",
      this.newsDesc = "This is news description"});

//==========================================================================

  @override
  Widget build(BuildContext context) {
    //go to ReadNews page and send information via constructor function
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReadNews(
                imgUrl: imgUrl,
                newsTitle: newsTitle,
                newsDate: newsDate,
                newsContent: newsContent,
                newsDesc: newsDesc),
          ),
        )
      },
      child:
          //create and formate Big news card
          Container(
        //responsive design from screen size
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.21,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: const Color.fromRGBO(246, 240, 235, 1),
          child: LayoutBuilder(builder: (ctx, constraints) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //news image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imgUrl,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.436,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  //info
                  Padding(
                    padding: const EdgeInsets.only(left: 7, top: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //display news date
                        Text(newsDate),
                        //display news title
                        Text(
                          newsTitle,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          children: const [
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
