import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:telex/data/context/app.dart';
import 'package:package_info/package_info.dart';
import 'package:telex/ui/feed/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  app.version = packageInfo.version;
  void initDb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fontFamily = prefs.getString('fontFamily');
    if (fontFamily == null || fontFamily.isEmpty) {
      await prefs.setString('fontFamily', 'sans-serif');
    }
    app.fontFamily = prefs.get('fontFamily');
  }

  initDb();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primarySwatch: Colors.indigo,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) => MaterialApp(
        title: 'Telex',
        debugShowCheckedModeBanner: false,
        home: HomeFeed(),
        theme: theme,
      ),
    );
  }
}
