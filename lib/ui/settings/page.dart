import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:telex/data/context/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                      DropdownMenuItem(
                        child: Text('cursive'),
                        value: 'cursive',
                      ),
                      DropdownMenuItem(
                        child: Text('monospace'),
                        value: 'monospace',
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

class SettingsPage1 extends StatelessWidget {
  //const SettingsPage1({Key key}) : super(key: key);

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
                      DropdownMenuItem(
                        child: Text('cursive'),
                        value: 'cursive',
                      ),
                      DropdownMenuItem(
                        child: Text('monospace'),
                        value: 'monospace',
                      ),
                    ],
                    onChanged: (value) async {
                      
                      var prefs = await SharedPreferences.getInstance();
                      await prefs.setString('fontFamily', value);
                      app.fontFamily = value;
                      
                    })),
            Spacer(),
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
