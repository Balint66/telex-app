import 'package:telex/data/models/article.dart';
import 'package:telex/data/models/author.dart';
import "package:telex/data/models/tag.dart";

class ArticleContent {
  int id;
  String slug;
  String title;
  DateTime date;
  List<Author> authors;
  Tag tag;
  String lead;
  String content;
  List<Tag> tags;
  String heroImage;
  String image;
  String boxImage;
  String boxLead;
  String boxTitle;
  DateTime updated;
  List<Article> recommended;

  ArticleContent(
    this.id,
    this.slug,
    this.title,
    this.date,
    this.authors,
    this.tag,
    this.lead,
    this.content,
    this.tags,
    this.heroImage,
    this.image,
    this.boxImage,
    this.boxLead,
    this.boxTitle,
    this.updated,
    this.recommended,
  );

  factory ArticleContent.fromJson(Map json) {
    int id = json['id'];
    String slug = json['slug'];
    String title = json['title'];
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(json['pubDate'] * 1000).toLocal();
    List<Author> authors = [];
    json['authors'].forEach((a) => authors.add(Author.fromJson(a)));
    Tag tag = Tag.fromJson(json['mainSuperTag']);
    String lead = json['lead'];
    String content = json['content']
        .replaceAll(
            "<p><strong>(</strong><a href=\"https://telex.hu/list/newest\" "
                "target=\"_blank\" rel=\"noopener noreferrer\">"
                "<strong>További friss híreinket ide kattintva olvashatják.</strong>"
                "</a><strong>)</strong></p>",
            "")
        .replaceAll("oembed url=\"https://www.youtube.com/watch?v=", "YTVID>")
        .replaceAll("\"></oembed>", "</YTVID>");

    content.split("<YTVID>").forEach((vid) {
      String ctx = vid.split("</YTVID>").first;
      String id = ctx.replaceFirst("&amp;feature=emb_title", "");
      if (id.contains(';')) return;
      content = content.replaceFirst(
        "<YTVID>$ctx</YTVID>",
        '<a href="https://youtu.be/$id">'
            '<img src="https://i.ytimg.com/vi/$id/maxresdefault.jpg">'
            '<figcaption>YouTube</figcaption>'
            '</a>',
      );
    });

    List<Tag> tags = [];
    if (json['tags'] != "")
      json['tags'].forEach((t) => tags.add(Tag.fromJson(t)));
    String heroImage = json['heroImage'];
    String image = json['imageSrc'];
    String boxImage = json['boxImage'];
    String boxLead = json['boxLead'];
    String boxTitle = json['boxTitle'];
    DateTime updated =
        DateTime.fromMillisecondsSinceEpoch(json['updatedAt'] * 1000).toLocal();
    List<Article> recommended = [];
    json['moreFromAuthors']
        .forEach((a) => recommended.add(Article.fromJson(a)));

    return ArticleContent(
      id,
      slug,
      title,
      date,
      authors,
      tag,
      lead,
      content,
      tags,
      heroImage,
      image,
      boxImage,
      boxLead,
      boxTitle,
      updated,
      recommended,
    );
  }
}
