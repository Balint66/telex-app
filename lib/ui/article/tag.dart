import 'package:flutter/material.dart';
import 'package:telex/utils/colors.dart';
import 'package:tinycolor/tinycolor.dart';

class ArticleTag extends StatelessWidget {
  final String text;
  const ArticleTag({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = TinyColor(stringToColor(text))
        .desaturate(20)
        .brighten(5)
        .lighten(25)
        .spin(64)
        .color;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99.0),
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        child: Text(text,
            style: TextStyle(
              color:
                  color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            )),
      ),
    );
  }
}
