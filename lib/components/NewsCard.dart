import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  String imgUrl = "https://picsum.photos/seed/137/600";

  String newsTitle = "This is news title";

  String newsDate = "This is news date";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(5.0) //                 <--- border radius here
              ),
        ),
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imgUrl,
                  width: constraints.maxWidth * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(newsDate),
                      Text(
                        newsTitle,
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      Text("Read More")
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
