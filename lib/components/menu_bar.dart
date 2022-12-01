import 'package:flutter/material.dart';
import 'package:flutter_application_3/select_category.dart';
import '../news_list_page.dart';

class Sidemenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(246, 240, 235, 1),
            ),
            child: Text(
              'Menu Bar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(50, 48, 45, 1),
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Category'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => selectcategory(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Thai News'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsListPage(
                    Header_Title: "Thai News",
                    Parameter: ["country=th", "language=th", "Page=0"],
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('English News'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsListPage(
                      Header_Title: "English News",
                      Parameter: ["country=gb,us", "language=en", "Page=0"]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
