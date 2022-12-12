import 'package:flutter/material.dart';

//component that display news info in ReadNews page
class NewsInfo extends StatelessWidget {
  final String info;
  final bool isNewsDate;

  NewsInfo({required this.info, required this.isNewsDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding base on if this is newsDate or not
      padding: isNewsDate
          ?
          //if this is newsDate
          const EdgeInsets.only(left: 20, right: 20, top: 20)
          //if this is not newsDate
          : const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: const Color.fromRGBO(246, 240, 235, 1),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              //text style base on if this is newsDate or not
              child: isNewsDate
                  ?
                  //if this is newsDate
                  Text(info, style: const TextStyle(fontSize: 15))
                  :
                  //if this is not newsDate
                  Text(
                      textAlign: TextAlign.justify,
                      info,
                      style: const TextStyle(fontSize: 18),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
