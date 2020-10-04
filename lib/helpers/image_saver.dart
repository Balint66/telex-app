import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:telex/data/context/app.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSaver {
  static Future<String> save(String image) async {
    try {
      image = image.replaceFirst("https://telex.hu", "");

      Directory downloads = Directory("/storage/self/primary/Download/");
      String imageName = path.basename(image);
      String imagePath = path.join(downloads.path, imageName);

      var data = await api.image(src: image);

      if (await Permission.storage.request().isGranted) {
        await File(imagePath).writeAsBytes(data);
      } else {
        throw "Insufficient permissions";
      }

      return path.basename(image);
    } catch (error) {
      print("ERROR: ImageSaver.save: " + error.toString());
      return null;
    }
  }
}
