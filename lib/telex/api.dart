import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:telex/data/models/article.dart';
import 'package:telex/data/models/article_content.dart';
import 'package:http/http.dart' as http;
import 'package:telex/data/context/app.dart';
import 'package:telex/data/models/exchange.dart';
import 'package:telex/data/models/weather.dart';
import 'package:telex/ui/image.dart';

class TelexApi {
  static const TELEX_API = "https://telex.hu/api";
  static const TELEX = "https://telex.hu";

  String articleContent(String slug) => TELEX_API + "/articles/" + slug;
  String indexPageContent() => TELEX_API + "/index/boxes";
  String articlesAll(int limit, {List<int> excludes}) =>
      TELEX_API +
      "/articles?limit=" +
      limit.toString() +
      (excludes != null ? "&excludes=[${excludes.join(', ')}]" : "");
  String exchangeRate() => TELEX_API + "/exchangerate";
  String weatherInfo() => TELEX_API + "/weather/Budapest";
  String imageUpload(String src) => TELEX + src;
  http.Client client;
  String userAgent;

  TelexApi() {
    client = http.Client();
    userAgent = "telex/" + app.version;
  }

  Future<List<Article>> getArticles({
    List<Article> excluded = const <Article>[],
  }) async {
    try {
      List<int> excludes = (excluded ?? <Article>[]).map((e) => e.id).toList();

      var response = await client.get(
        articlesAll(10, excludes: excludes.length == 0 ? null : excludes),
        headers: {"User-Agent": userAgent},
      );

      if (response.statusCode != 200) throw "Invalid response";

      List json = jsonDecode(response.body);
      List<Article> articles = [];

      json.forEach((e) => articles.add(Article.fromJson(e)));

      return articles;
    } catch (error) {
      print("ERROR: TelexApi.getArticles: " + error.toString());
      return null;
    }
  }

  Future<List<Article>> getIndexPage() async {
    try {
      var response = await client.get(
        indexPageContent(),
        headers: {"User-Agent": userAgent},
      );

      if (response.statusCode != 200) throw "Invalid response";

      Map json = jsonDecode(response.body);
      List<Article> boxes = [];

      json['topBoxItems'].forEach((box) => boxes.add(Article.fromJson(box)));
      boxes.insert(0, boxes[2]);
      boxes.removeAt(3);
      json['middle1BoxItems']
          .forEach((box) => boxes.add(Article.fromJson(box)));

      return boxes;
    } catch (error) {
      print("ERROR: TelexApi.getIndexPage: " + error.toString());
      return null;
    }
  }

  Future<List<Exchange>> getExhangeRate() async {
    try {
      var response = await client.get(
        exchangeRate(),
        headers: {"User-Agent": userAgent},
      );

      if (response.statusCode != 200) throw "Invalid response";

      List json = jsonDecode(response.body);
      List<Exchange> exchanges = [];

      json.forEach((e) => exchanges.add(Exchange.fromJson(e)));

      return exchanges;
    } catch (error) {
      print("ERROR: TelexApi.getExhangeRate: " + error.toString());
      return null;
    }
  }

  Future<WeatherInfo> getWeatherInformation() async {
    try {
      var response = await client.get(
        weatherInfo(),
        headers: {"User-Agent": userAgent},
      );

      if (response.statusCode != 200) throw "Invalid response";

      Map json = jsonDecode(response.body);
      WeatherInfo weather = WeatherInfo.fromJson(json);

      return weather;
    } catch (error) {
      print("ERROR: TelexApi.getWeatherInformation: " + error.toString());
      return null;
    }
  }

  Future<ArticleContent> getArticleContent(String slug) async {
    try {
      var response = await client.get(
        articleContent(slug),
        headers: {"User-Agent": userAgent},
      );

      if (response.statusCode != 200) throw "Invalid response";

      Map json = jsonDecode(response.body);
      return ArticleContent.fromJson(json);
    } catch (error) {
      print("ERROR: TelexApi.getArticleContent: " + error.toString());
      return null;
    }
  }

  Future<Uint8List> image({String src}) async {
    try {
      var response = await client.get(
        imageUpload(src),
        headers: {"User-Agent": userAgent},
      );

      if (response.statusCode != 200) throw "Invalid response";

      return response.bodyBytes;
    } catch (error) {
      print("ERROR: TelexApi.getArticleContent: " + error.toString());
      return null;
    }
  }
}
