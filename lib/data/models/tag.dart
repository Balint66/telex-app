class Tag {
  int id;
  String slug;
  String name;

  Tag(
    this.id,
    this.slug,
    this.name,
  );

  factory Tag.fromJson(Map json) {
    int id = json['id'];
    String slug = json['slug'];
    String name = json['name'];

    return Tag(
      id,
      slug,
      name,
    );
  }
}
