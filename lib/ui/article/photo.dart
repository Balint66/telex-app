import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';
import 'package:telex/helpers/image_saver.dart';
import 'package:toast/toast.dart';

class Photo extends StatelessWidget {
  const Photo({Key key, this.image}) : super(key: key);
  
  final String image;

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
            onPressed: () {
              ImageSaver.save(image).then((file) {
                if (file != null) {
                  Toast.show(
                    file + " mentve",
                    context,
                    backgroundColor: Colors.grey[900],
                  );
                } else {
                  Toast.show(
                    "Sikertelen letöltés",
                    context,
                    backgroundColor: Colors.red,
                  );
                }
              });
            },
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
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
