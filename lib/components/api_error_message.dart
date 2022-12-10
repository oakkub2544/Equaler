import 'package:flutter/material.dart';

class ApiErrorMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Icon(
            Icons.local_shipping_rounded,
            color: Color.fromRGBO(100, 93, 83, 1),
            size: 50.0,
          ),
        ),
        Text('News cannot pass in this page',
            textAlign: TextAlign.center,
            style: TextStyle(height: 2, fontSize: 14)),
        Text('API Error',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
