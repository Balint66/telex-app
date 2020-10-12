import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 150.0),
      height: 1.0,
      color: Colors.grey[300],
    );
  }
}