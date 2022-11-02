import 'package:flutter/material.dart';

class Headerbar extends StatelessWidget with PreferredSizeWidget {
  final String headerTitle;
  Headerbar({this.headerTitle = 'Equaler'});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Center(
            child: Container(
          child: Text(headerTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(50, 48, 45, 1),
              )),
          width: 378,
        )),
        actions: [
          Transform.scale(
              scale: 1,
              child: IconButton(
                icon: Image.asset('asset/logo/logoapp.png'),
                iconSize: 30,
                onPressed: () {},
              ))
        ],
        iconTheme: IconThemeData(color: Color.fromRGBO(50, 48, 45, 1)),
        backgroundColor: Color.fromRGBO(246, 240, 235, 1));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
