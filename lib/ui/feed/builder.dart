import 'package:flutter/material.dart';
import 'package:telex/data/context/app.dart';
import 'package:telex/data/models/article.dart';
import 'package:telex/ui/article/tile.dart';
import 'package:telex/ui/info/tile.dart';

class FeedBuilder {
  List<Widget> tiles = [];

  Future<bool> build() async {
    List<Article> boxes = await api.getIndexPage();
    boxes.addAll(await api.getArticles(excluded: boxes));
    tiles = [];
    boxes.forEach((box) => tiles.add(ArticleTile(article: box)));

    var weather = await api.getWeatherInformation();
    var exchanges = await api.getExhangeRate();

    tiles.insert(0, InfoTile(weather: weather, exchanges: exchanges));

    return true;
  }
}
