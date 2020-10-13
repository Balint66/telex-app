import 'package:flutter/material.dart';
import 'package:telex/ui/feed/tile.dart';

class Section extends Tile {
  const Section({Key key}) : super(key: key);

  final String type = "section";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 150.0),
      height: 2.0,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.grey[300]
          : Colors.grey[700],
    );
  }
}
