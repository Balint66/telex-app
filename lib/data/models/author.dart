class Author {
  int id;
  String name;
  String slug;
  String avatar;

  Author(
    this.id,
    this.name,
    this.slug,
    this.avatar,
  );

  factory Author.fromJson(Map json) {
    int id = json['id'];
    String name = json['name'];
    String slug = json['slug'];
    String avatar = json['avatarSrc'];

    return Author(
      id,
      name,
      slug,
      avatar,
    );
  }
}
