import 'package:flutter/material.dart';
import '../components/menu.dart';

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
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(246, 240, 235, 1),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      ('asset/logo/logoapp.png'),
                      height: 40,
                      width: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Equaler'.toUpperCase(),
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
            Menu(
                menuTitle: 'Thai News',
                parameter: const ["country=th", "language=th", "Page=0"],
                isCategoryPage: false),
            Menu(
                menuTitle: 'English News',
                parameter: const ["country=gb,us", "language=en", "Page=0"],
                isCategoryPage: false),
          ],
        ),
      ),
    );
  }
}
