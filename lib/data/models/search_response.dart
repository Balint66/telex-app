import 'package:telex/data/models/article.dart';

class SearchResponse
{
  int totalItems;
  int totalPages;
  int perPage;
  int page;
  int itemsReturned;
  String slug;
  String title;
  List<Article> items;

  SearchResponse(
    this.totalItems,
    this.totalPages,
    this.perPage,
    this.page,
    this.itemsReturned,
    this.slug,
    this.title,
    this.items
  );

  factory SearchResponse.fromJson(Map json) {
    int totalItems = json["totalItems"];
    int totalPages = json["totalPages"];
    int perPage = json["perPage"];
    int page = json["page"];
    int itemsReturned = json["itemsReturned"];
    String slug = json["slug"];
    String title = json["title"];
    List<Article> items = (json["items"] as List<dynamic>).cast<Map<String, String>>()
      .map((item)=> Article.fromJson(item));


    return SearchResponse(
      totalItems,
      totalPages,
      perPage,
      page,
      itemsReturned,
      slug,
      title,
      items
      );

  }


}