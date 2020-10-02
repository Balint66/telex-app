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
  );

  factory ArticleContent.fromJson(Map json) {
    int id = json['id'];
    String slug = json['slug'];
    String title = json['title'];
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(json['pubDate']).toLocal();
    List<Author> authors =
        json['authors'].map((Map a) => Author.fromJson(a)).toList();
    Tag tag = Tag.fromJson(json['mainSuperTag']);
    String lead = json['lead'];
    String content = json['content'];
    List<Tag> tags = json['tags'].map((Map t) => Tag.fromJson(t)).toList();
    String heroImage = json['heroImage'];
    String image = json['imageSrc'];
    String boxImage = json['boxImage'];
    String boxLead = json['boxLead'];
    String boxTitle = json['boxTitle'];
    DateTime updated =
        DateTime.fromMillisecondsSinceEpoch(json['updatedAt']).toLocal();

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
    );
  }
}
