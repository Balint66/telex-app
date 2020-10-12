import 'package:flutter/material.dart';
import 'package:telex/data/models/article.dart';
import 'package:telex/data/models/weather.dart';

class Tile extends StatelessWidget {
  const Tile({Key key, this.article, this.weather, this.type}) : super(key: key);
  final Article article;
  final WeatherInfo weather;
  final String type;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
