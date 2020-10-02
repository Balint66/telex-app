import 'package:flutter/material.dart';
import 'package:telex/data/context/app.dart';
import 'package:telex/data/models/box_item.dart';
import 'package:telex/ui/article/tile.dart';

class FeedBuilder {
  List<Widget> tiles = [];

  Future<bool> build() async {
    List<BoxItem> boxes = await api.getIndexPage();
    tiles = [];
    boxes.forEach((box) => tiles.add(ArticleTile(article: box)));
    return true;
  }
}
