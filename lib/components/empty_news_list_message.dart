import 'package:flutter/material.dart';

class EmptyNewsListMessage extends StatelessWidget {
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
        Text(errorText,
            textAlign: TextAlign.center,
            style: const TextStyle(height: 2, fontSize: 16)),
      ],
    );
  }
}
