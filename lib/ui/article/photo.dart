import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';

class Photo extends StatelessWidget {
  final String image;
  const Photo({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(
              FeatherIcons.download,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              FeatherIcons.share2,
            ),
            onPressed: () {
              Share.share(image);
            },
          ),
        ],
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(image),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained,
          maxScale: 8.0,
          loadingBuilder: (context, event) => Padding(
            padding: EdgeInsets.all(12.0),
            child: LinearProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
