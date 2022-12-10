import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({this.title = "This is title"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
      child: Container(
        margin: const EdgeInsets.only(top: 15, bottom: 10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(title,
              style: const TextStyle(
                color: Color.fromRGBO(50, 48, 45, 1),
                fontSize: 42,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
