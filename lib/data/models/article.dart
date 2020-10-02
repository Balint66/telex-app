import 'package:telex/data/models/author.dart';
import 'package:telex/data/models/tag.dart';

class Article {
  int id;
  String slug;
  String title;
  DateTime date;
  List<Author> authors;
  Tag mainSuperTag;
}
