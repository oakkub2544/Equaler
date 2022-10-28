import 'package:flutter/material.dart';

class Sidemenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
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
            title: Text('SubMenu#1'),
          ),
          ListTile(
            title: Text('SubMenu#1'),
          ),
          ListTile(
            title: Text('SubMenu#1'),
          ),
        ],
      ),
    );
  }
}
