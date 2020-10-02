import 'package:flutter/material.dart';

class SettingsContext {
  final ThemeMode mode;
  final ThemeData light;
  final ThemeData dark;

  SettingsContext({
    @required this.mode,
    @required this.light,
    @required this.dark,
  });
}
//f
