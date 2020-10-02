import 'package:flutter/material.dart';
import 'package:telex/ui/theme/theme_provider.dart';

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
                "Settings",
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline5.color,
                ),
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            CheckboxListTile(
              value: ThemeProvider.of(context).mode == ThemeMode.dark,
              onChanged: (value) => ThemeProvider.updateBrightness(
                  context, value ? ThemeMode.dark : ThemeMode.light),
              title: Text('Dark theme'),
            )
          ],
        ),
      ),
    );
  }
}
