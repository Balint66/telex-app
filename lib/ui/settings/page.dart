import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
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
            )
          ],
        ),
      ),
    );
  }
}
