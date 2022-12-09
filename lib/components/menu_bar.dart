import 'package:flutter/material.dart';
import '../select_category.dart';
import '../news_list_page.dart';

class Sidemenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //Create a CustomSidebar on top left that will trigger a navigation operation when tapped
      child: Container(
        color: Color.fromRGBO(246, 240, 235, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 130.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 240, 235, 1),
                ),
                child: Text(
                  'Menu Bar'.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(50, 48, 45, 1),
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Category'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
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
              title: Text('Thai News'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
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
              title: Text('English News'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
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
      ),
    );
  }
}
