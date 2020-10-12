import 'package:flutter/material.dart';

class ArticleTag extends StatelessWidget {
  const ArticleTag({Key key, this.text}) : super(key: key);
  
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 4.0, top: 4.0, right: 12.0),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: Color(0xFF00916B), letterSpacing: .8),
      ),
    );
  }
}
