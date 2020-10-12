import 'package:telex/data/context/app.dart';
import 'package:telex/data/models/article.dart';
import 'package:telex/ui/article/tile.dart';
import 'package:telex/ui/feed/tile.dart';
import 'package:telex/ui/info/tile.dart';

class FeedBuilder {
  List<Tile> tiles = [];

  Future<bool> build() async {
    tiles = [];
    List<Article> boxes = [];
    boxes.addAll(await api.getIndexPage());
    boxes.forEach((box) => tiles.add(ArticleTile(article: box, type: "mainpage")));
    boxes.addAll(await api.getArticles(excluded: boxes));
    boxes.forEach((box) => tiles.add(ArticleTile(article: box, type: "article")));

    var weather = await api.getWeatherInformation();
    var exchanges = await api.getExhangeRate();

    tiles.insert(0, InfoTile(weather: weather, exchanges: exchanges));

    return true;
  }
}
