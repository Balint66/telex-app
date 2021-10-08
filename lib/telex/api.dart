import 'dart:convert';
import 'dart:typed_data';

import 'package:telex/data/models/article.dart';
import 'package:telex/data/models/article_content.dart';
import 'package:http/http.dart' as http;
import 'package:telex/data/context/app.dart';
import 'package:telex/data/models/exchange.dart';
import 'package:telex/data/models/search_response.dart';
import 'package:telex/data/models/weather.dart';

class TelexApi {
  static const TELEX_API = "https://telex.hu/api";
  static const TELEX = "https://telex.hu";

  Uri articleContent(String slug) => Uri.parse(TELEX_API + "/articles/" + slug);
  Uri indexPageContent() => Uri.parse(TELEX_API + "/index/boxes");
  Uri articlesAll(int limit, {List<int> excludes, int perPage, int page}) =>
      Uri.parse(TELEX_API +
      "/articles?limit=" +
      limit.toString() +
      (excludes != null ? "&excludes=[${excludes.join(', ')}]" : "") +
      (perPage != null ? "&perPage=$perPage" : "") +
      (page != null ? "&page=$page" : ""));
  Uri exchangeRate() => Uri.parse(TELEX_API + "/exchangerate");
  Uri weatherInfo() => Uri.parse(TELEX_API + "/weather/Budapest");
  Uri imageUpload(String src) => Uri.parse(TELEX + src);
  Uri search(String term) => Uri.parse(TELEX_API + "/search?term=" + term);
  Uri tag(List<String> slugs) => Uri.parse(TELEX_API + '/search?filters={"superTagSlugs":['+ slugs.join(', ') + "]}");
  http.Client client;
  String userAgent;

  TelexApi() {
    client = http.Client();
    userAgent = "telex/" + app.version;
  }

  Future<List<Article>> getArticles({
    List<Article> excluded = const <Article>[],
    int page,
  }) async {
    try {
      List<int> excludes = (excluded ?? <Article>[]).map((e) => e.id).toList();

      var response = await client.get(
        articlesAll(
          10,
          excludes: excludes.length == 0 ? null : excludes,
          perPage: 10,
          page: page,
        ),
        headers: {"User-Agent": userAgent},
      );

      if (response.statusCode != 200) throw "Invalid response";

      List json = jsonDecode(response.body)["items"];
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

  Future<SearchResponse> getSearchResult({String term}) async {
    try{
      var response = await client.get(
        search(term),
        headers: {"User-Agent": userAgent}
      );

      if (response.statusCode != 200) throw "Invalid response";

      Map json = jsonDecode(response.body);

      return SearchResponse.fromJson(json);

    }
    catch(error)
    {
      print("ERROR: TelexApi.search: " + error.toString());
      return null;
    }
  }

  Future<SearchResponse> getArticlesInTag({String tagSlug}) async {
    try{
      var response = await client.get(
        tag([tagSlug]),
        headers: {"User-Agent": userAgent}
      );

      if (response.statusCode != 200) throw "Invalid response";

      Map json = jsonDecode(response.body);

      return SearchResponse.fromJson(json);

    }
    catch(error)
    {
      print("ERROR: TelexApi.search: " + error.toString());
      return null;
    }
  }

}
