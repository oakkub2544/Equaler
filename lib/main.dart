import 'package:flutter/material.dart';
import 'header_bar.dart';
import 'menubar.dart';
import 'newsCard.dart';

void main() {
  var app = MaterialApp(
      title: "My App",
      home: Scaffold(
        appBar: Headerbar(),
        drawer: Sidemenu(),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              NewsCard(),
              NewsCard(),
              NewsCard(),
              NewsCard(),
              NewsCard(),
            ])),
      ));
  runApp(app);
}
