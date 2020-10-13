import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:telex/ui/feed/tile.dart';

class LoadingTile extends Tile {
  const LoadingTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12.0),
      child: SpinKitThreeBounce(
        size: 42.0,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey[300]
            : Colors.grey[700],
      ),
    );
  }
}
