import 'package:flutter/material.dart';
import '../components/menu.dart';

class Menubar extends StatelessWidget {
  //Create a CustomSidebar on top left that will trigger a navigation operation when tapped
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //Display list Items available in the menu
      child: Container(
        color: const Color.fromRGBO(246, 240, 235, 1),
        child: ListView(
          children: [
            SizedBox(
              height: 190.0,
              child: DrawerHeader( //header's menu bar
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(246, 240, 235, 1),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      ('asset/logo/logoapp.png'), //Logo app
                      height: 40,
                      width: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Equaler News'.toUpperCase(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color.fromRGBO(50, 48, 45, 1),
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Menu(menuTitle: 'Category', isCategoryPage: true),
            Menu( //Send constructor to Menu class for get only Thai news data
                menuTitle: 'Thai News',
                parameter: ["country=th", "language=th", "Page=0"],
                isCategoryPage: false),
            Menu( //Send constructor to Menu class for get only English news data
                menuTitle: 'English News',
                parameter: ["country=gb,us", "language=en", "Page=0"],
                isCategoryPage: false),
          ],
        ),
      ),
    );
  }
}
