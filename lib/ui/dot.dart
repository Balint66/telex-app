import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  const Dot({Key key, this.size, this.color}) : super(key: key);

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.0 * size,
      height: 16.0 * size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
