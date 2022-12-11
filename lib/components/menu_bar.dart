import 'package:flutter/material.dart';
import '../components/menu.dart';

//a material design panel that slides in horizontally from the edge to show navigation links in an application
class Menubar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromRGBO(246, 240, 235, 1),
        child: ListView(
          children: [
            SizedBox(
              height: 190.0,
              child:
                  //Menubar's header
                  DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(246, 240, 235, 1),
                ),
                child: Row(
                  children: [
                    //header's logo app
                    Image.asset(
                      ('asset/logo/logoapp.png'),
                      height: 40,
                      width: 40,
                    ),
                    //header's title
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
            //menu in Menubar that navigate to SelectCategory page
            Menu(menuTitle: 'Category', isCategoryPage: true),
            //menu in Menubar that navigate to NewsListPage page with only thai news
            Menu(
                //send constructor to Menu class to get only Thai news data
                menuTitle: 'Thai News',
                parameter: ["country=th", "language=th", "Page=0"],
                isCategoryPage: false),
            //menu in Menubar that navigate to NewsListPage page with only english news
            Menu(
                //send constructor to Menu class to get only English news data
                menuTitle: 'English News',
                parameter: ["country=gb,us", "language=en", "Page=0"],
                isCategoryPage: false),
          ],
        ),
      ),
    );
  }
}
