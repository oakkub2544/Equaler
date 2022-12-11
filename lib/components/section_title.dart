import 'package:flutter/material.dart';

//component for display title text
class SectionTitle extends StatelessWidget {
//================== Initial Constructor =======================

  final String title;
  SectionTitle({this.title = "This is title"});

  //==============================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      //create and formate section title
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
      child: Container(
        margin: const EdgeInsets.only(top: 15, bottom: 10),
        child: Align(
          alignment: Alignment.topLeft,
          child:
              //display title
              Text(title,
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
