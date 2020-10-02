import 'package:flutter/material.dart';
import 'package:telex/data/context/app.dart';
import 'package:package_info/package_info.dart';
import 'package:telex/ui/feed/home.dart';
import 'package:telex/ui/theme/theme_provider.dart';
import 'package:telex/data/context/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  app.version = packageInfo.version;

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: MaterialApp(
        title: 'Telex',
        debugShowCheckedModeBanner: false,
        theme: ThemeProvider.of(context)?.light,
        darkTheme: ThemeProvider.of(context)?.dark,
        home: HomeFeed(),
        themeMode: ThemeProvider.of(context)?.mode ?? ThemeMode.light,
      ),
      baseSettings: SettingsContext(mode: ThemeMode.light, light: ThemeData(
        primarySwatch: MaterialColor(0xFF022A53, ThemeColor.genSwatch(Color(0xFF022A53))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      dark: ThemeData.dark())
    );
  }
}
