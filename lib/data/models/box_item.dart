import 'package:telex/data/models/author.dart';
import 'package:telex/data/models/tag.dart';

class BoxItem {
  int id;
  String slug;
  String title;
  String lead;
  String image;
  DateTime date;
  Tag tag;
  List<Author> authors;

  BoxItem(
    this.id,
    this.slug,
    this.title,
    this.lead,
    this.image,
    this.date,
    this.tag,
    this.authors,
  );

  factory BoxItem.fromJson(Map json) {
    int id = json['id'];
    String slug = json['slug'];
    String title = json['title'];
    String lead = json['lead'];
    String image = json["imageSrc"];
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(json['pubDate'] * 1000).toLocal();
    Tag tag = Tag.fromJson(json['mainSuperTag']);
    List<Author> authors = [];
    json['authors'].forEach((a) => authors.add(Author.fromJson(a)));
    print(date);
    print(json['pubDate']);

    return BoxItem(
      id,
      slug,
      title,
      lead,
      image,
      date,
      tag,
      authors,
    );
  }
}
