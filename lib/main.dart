import 'package:flutter/material.dart';
import 'header_bar.dart';
import 'menubar.dart';

void main() {
  var app = MaterialApp(
      title: "My App",
      home: Scaffold(
        appBar: Headerbar(),
        drawer: Sidemenu(),
      ));
  runApp(app);
}
