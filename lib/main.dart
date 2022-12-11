import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/home_page.dart';

void main() {
// This section is for running apps only on vertical pages
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(Equaler()));
}

class Equaler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Equaler",
      home: HomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(246, 240, 235, 1),
      ),
    );
  }
}
