import 'package:flutter/material.dart';
import 'components/header_bar.dart';
import 'components/menubar.dart';
import 'components/NewsCard.dart';
import 'components/BigNewsCard.dart';
import 'components/SectionTitle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
            child: Column(
            SectionTitle(title: "Suggestion"),
            BigNewsCard(),
            SectionTitle(title: "Popular Today"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              child: FutureBuilder<dynamic>(
                future: newsData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              NewsCard(

                                imgUrl: snapshot.data[index]['image_url'],
                                newsTitle: snapshot.data[index]['title'],
                                newsDate: snapshot.data[index]['pubDate'],

                              )
                            ],
                          );
                        });
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        )));
  }
}
