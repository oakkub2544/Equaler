import 'package:flutter/material.dart';
import '../main.dart';

//displays the toolbar widgets, leading, title, and actions above
class Headerbar extends StatelessWidget with PreferredSizeWidget {
//=================== Initial Constructor ======================

  final String headerTitle;
  Headerbar({this.headerTitle = 'Equaler'});

//==============================================================

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: SizedBox(
            width: 378,
            child: Text(headerTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromRGBO(50, 48, 45, 1),
                ))),
        actions: [
          Transform.scale(
              scale: 1,
              //application logo
              child: IconButton(
                icon: Image.asset('asset/logo/logoapp.png'),
                iconSize: 30,
                onPressed: () {
                  //Navigate to HomePage when you pressed the logo
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Equaler()));
                },
              )),
        ],
        iconTheme: const IconThemeData(color: Color.fromRGBO(50, 48, 45, 1)),
        backgroundColor: const Color.fromRGBO(246, 240, 235, 1));
  }

  @override
  //custom appbar with the same height
  Size get preferredSize => Size.fromHeight(60);
}
