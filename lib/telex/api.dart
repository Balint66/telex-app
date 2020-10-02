import 'dart:convert';

import 'package:telex/data/models/article.dart';
import 'package:telex/data/models/article_content.dart';
import 'package:telex/data/models/box_item.dart';
import 'package:http/http.dart' as http;
import 'package:telex/data/context/app.dart';

class TelexApi {
  static const TELEX_API = "https://telex.hu/api/";

  String articleContent(String articleId) =>
      TELEX_API + "articles/" + articleId;
  String indexPageContent() => TELEX_API + "index/boxes";
  String articles(int limit) =>
      TELEX_API + "articles?limit=" + limit.toString();

  http.Client client;
  String userAgent;

  TelexApi() {
    client = http.Client();
    userAgent = "telex/" + app.version;
  }

  Future<List<Article>> getArticles() async {
    try {
      var response = await client.get(
        articles(10),
        headers: {"User-Agent": userAgent},
      );
    } catch (error) {
      print("ERROR: TelexApi.getArticles: " + error.toString());
      return null;
    }
  }

  Future<List<BoxItem>> getIndexPage() async {
    try {
      var response = await client.get(
        indexPageContent(),
        headers: {"User-Agent": userAgent},
      );

      if (response.statusCode != 200) throw "Invalid response";

      Map json = jsonDecode(response.body);
      List<BoxItem> boxes = [];

      json['topBoxItems'].forEach((box) => boxes.add(BoxItem.fromJson(box)));

      return boxes;
    } catch (error) {
      print("ERROR: TelexApi.getIndexPage: " + error.toString());
      return null;
    }
  }

  Future<ArticleContent> getArticleContent(String slug) async {
    try {
      var response = await client.get(
        articleContent(slug),
        headers: {"User-Agent": userAgent},
      );
    } catch (error) {
      print("ERROR: TelexApi.getArticleContent: " + error.toString());
      return null;
    }
  }
}
