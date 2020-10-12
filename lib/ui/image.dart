import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:telex/data/context/app.dart';

class TelexImage extends StatefulWidget {
  final String src;
  final Widget Function(BuildContext) loadingBuilder;

  TelexImage(this.src, {Key key, this.loadingBuilder}) : super(key: key);

  @override
  _TelexImageState createState() => _TelexImageState();
}

class _TelexImageState extends State<TelexImage> {
  Uint8List imgData;
  bool animate = true;

  @override
  Widget build(BuildContext context) {
    if (imgData == null)
      WidgetsBinding.instance
          .addPostFrameCallback((_) => api.image(src: widget.src).then((data) {
                imgData = data;
                if (mounted) setState(() {});
              }));

    Widget img = imgData != null
        ? animate
            ? FadeInImage(
                placeholder: MemoryImage(placeholder),
                image: MemoryImage(imgData),
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 300),
              )
            : Image.memory(
                imgData,
                fit: BoxFit.cover,
              )
        : widget.loadingBuilder != null
            ? widget.loadingBuilder(context)
            : Container();

    if (imgData != null) animate = false;

    return img;
  }

  final Uint8List placeholder = Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE
  ]);
}
