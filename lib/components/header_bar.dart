import 'package:flutter/material.dart';
import '../main.dart';

class Headerbar extends StatelessWidget with PreferredSizeWidget {
//Displays the toolbar widgets, leading, title, and actions above 
//=================== Initial Constructor ======================

  final String headerTitle;
  Headerbar({this.headerTitle = 'Equaler'});
//==============================================================

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Menu Bar",
      child: AppBar(
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
                child: Semantics(
                  label: "Back to Home Page",
                  child: IconButton(
                    icon: Image.asset('asset/logo/logoapp.png'),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    }, //Pressed icon to go main page
                  ),
                )),
          ],
          iconTheme: const IconThemeData(color: Color.fromRGBO(50, 48, 45, 1)),
          backgroundColor: const Color.fromRGBO(246, 240, 235, 1)),
    );
  }

  @override
  //Custom appbar with the same height, width
  Size get preferredSize => Size.fromHeight(60);
}
