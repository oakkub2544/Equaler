import 'package:flutter/material.dart';

class EmptyNewsListMessage extends StatelessWidget {
//Return errorText if api has a news content length 0
//=================== Initial Constructor ======================

  final String errorText;

  EmptyNewsListMessage(this.errorText);
//==============================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 60),
          child: Icon(
            Icons.local_play_outlined, //Icons for empty content
            color: Color.fromRGBO(100, 93, 83, 1),
            size: 50.0,
          ),
        ),
        Text(errorText, //Display error text
            textAlign: TextAlign.center,
            style: const TextStyle(height: 2, fontSize: 16)),
      ],
    );
  }
}
