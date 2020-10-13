import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:telex/data/context/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            AppBar(
              leading: BackButton(
                color: Theme.of(context).textTheme.headline5.color,
              ),
              centerTitle: true,
              title: Text(
                "Beállítások",
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline5.color,
                ),
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            SwitchListTile(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) => DynamicTheme.of(context)
                  .setBrightness(value ? Brightness.dark : Brightness.light),
              title: Text('Sötét téma'),
            ),
            ListTile(
                leading: Text('Cikkek betűtípusa'),
                trailing: DropdownButton(
                    value: app.fontFamily,
                    items: [
                      DropdownMenuItem(
                        child: Text('sans-serif'),
                        value: 'sans-serif',
                      ),
                      DropdownMenuItem(
                        child: Text('serif'),
                        value: 'serif',
                      ),
                    ],
                    onChanged: (value) async {
                      var prefs = await SharedPreferences.getInstance();
                      await prefs.setString('fontFamily', value);
                      app.fontFamily = value;
                      setState(() {});
                    })),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(
                    icon: FeatherIcons.facebook,
                    link: "https://www.facebook.com/telexhu",
                  ),
                  SocialButton(
                    icon: FeatherIcons.instagram,
                    link: "https://www.instagram.com/telexponthu",
                  ),
                  SocialButton(
                    icon: FeatherIcons.youtube,
                    link:
                        "https://www.youtube.com/channel/UCM-1sd-cXSuCsfWp8QMY_OQ",
                  ),
                  SocialButton(
                    icon: FeatherIcons.twitter,
                    link: "https://twitter.com/Telexhu",
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Telex ${app.version}",
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({Key key, this.icon, this.link}) : super(key: key);

  final String link;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        icon: Icon(icon),
        onPressed: () => launch(link),
      ),
    );
  }
}
