import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:telex/data/context/settings.dart';

class ThemeProvider extends StatefulWidget {
  final SettingsContext baseSettings;
  final Widget child;

  ThemeProvider({@required this.child, @required this.baseSettings, Key key})
      : super(key: key);

  @override
  _ThemeProviderState createState() => _ThemeProviderState();

  static SettingsContext of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ThemeProviderInherited>()
      ?.data;

  static void updateBrightness(BuildContext context, ThemeMode brightness) {
    context.findAncestorStateOfType<_ThemeProviderState>()
    .updateBrightness(brightness);
  }

  static void updateColor(BuildContext context, Color color) {
    context
        .findAncestorStateOfType<_ThemeProviderState>()
        ?.updatePrimaryColor(color);
  }
}

class _ThemeProviderInherited extends InheritedWidget {
  final SettingsContext data;
  _ThemeProviderInherited(Widget child, this.data) : super(child: child);
  bool updateShouldNotify(InheritedWidget widget) => true;
}

class _ThemeProviderState extends State<ThemeProvider> {
  SettingsContext themeData;

  @override
  initState() {
    super.initState();
    themeData = widget.baseSettings;
  }

  void updateBrightness(ThemeMode themeMode) => setState(() {
        themeData = SettingsContext(mode:themeMode, light:themeData.light, dark:themeData.dark);
      });

  void updatePrimaryColor(Color color) => setState(() {
        themeData = SettingsContext(mode:themeData.mode, 
        light: ThemeData(), dark: ThemeData.dark());
      });

  @override
  Widget build(BuildContext context) =>
      _ThemeProviderInherited(widget.child, themeData);
}

class ThemeColor {
  static String _fillUpHex(String hex) {
    if (!hex.startsWith('#')) {
      hex = '#' + hex;
    }

    if (hex.length == 7) {
      return hex;
    }

    var filledUp = '';
    hex.runes.forEach((r) {
      var char = String.fromCharCode(r);
      if (char == '#') {
        filledUp = filledUp + char;
      } else {
        filledUp = filledUp + char + char;
      }
    });
    return filledUp;
  }

  ///
  /// Converts the given [hex] color string to the corresponding int
  ///
  static int _hexToInt(String hex) {
    if (hex.startsWith('#')) {
      hex = hex.replaceFirst('#', 'FF');
      return int.parse(hex, radix: 16);
    } else {
      if (hex.length == 6) {
        hex = 'FF' + hex;
      }
      return int.parse(hex, radix: 16);
    }
  }

  ///
  /// Converts the given integer [i] to a hex string with a leading #.
  ///
  static String _intToHex(int i) {
    var s = i.toRadixString(16);
    if (s.length == 8) {
      return '#' + s.substring(2).toUpperCase();
    } else {
      return '#' + s.toUpperCase();
    }
  }

  static const String BASIC_COLOR_RED = 'red';
  static const String BASIC_COLOR_GREEN = 'green';
  static const String BASIC_COLOR_BLUE = 'blue';
  static const String HEX_BLACK = '#000000';
  static const String HEX_WHITE = '#FFFFFF';

  static Map<String, int> _basicColorsFromHex(String hex) {
    hex = _fillUpHex(hex);

    if (!hex.startsWith('#')) {
      hex = '#' + hex;
    }

    var R = int.parse(hex.substring(1, 3), radix: 16);
    var G = int.parse(hex.substring(3, 5), radix: 16);
    var B = int.parse(hex.substring(5, 7), radix: 16);
    return {BASIC_COLOR_RED: R, BASIC_COLOR_GREEN: G, BASIC_COLOR_BLUE: B};
  }

  static String _shadeColor(String hex, double percent) {
    var bC = _basicColorsFromHex(hex);

    var R = (bC[BASIC_COLOR_RED] * (100 + percent) / 100).round();
    var G = (bC[BASIC_COLOR_GREEN] * (100 + percent) / 100).round();
    var B = (bC[BASIC_COLOR_BLUE] * (100 + percent) / 100).round();

    if (R > 255) {
      R = 255;
    } else if (R < 0) {
      R = 0;
    }

    if (G > 255) {
      G = 255;
    } else if (G < 0) {
      G = 0;
    }

    if (B > 255) {
      B = 255;
    } else if (B < 0) {
      B = 0;
    }

    // ignore: non_constant_identifier_names
    var RR = ((R.toRadixString(16).length == 1)
        ? '0' + R.toRadixString(16)
        : R.toRadixString(16));
    // ignore: non_constant_identifier_names
    var GG = ((G.toRadixString(16).length == 1)
        ? '0' + G.toRadixString(16)
        : G.toRadixString(16));
    // ignore: non_constant_identifier_names
    var BB = ((B.toRadixString(16).length == 1)
        ? '0' + B.toRadixString(16)
        : B.toRadixString(16));

    return '#' + RR + GG + BB;
  }

  static List<String> _swatchColor(String hex,
      {double percentage = 15, int amount = 5}) {
    hex = _fillUpHex(hex);

    var colors = <String>[];
    for (var i = 1; i <= amount; i++) {
      colors.add(_shadeColor(hex, (6 - i) * percentage));
    }
    colors.add(hex);
    for (var i = 1; i <= amount; i++) {
      colors.add(_shadeColor(hex, (0 - i) * percentage));
    }
    return colors;
  }

  static Map<int, Color> genSwatch(Color color) {
    var stringSwatch = _swatchColor(_intToHex(color.value));

    var map = <int, Color>{};

    for (var i = 0; i < stringSwatch.length; i++) {
      if (i == 0) {
        map.putIfAbsent(50, () => Color(_hexToInt(stringSwatch[i])));
      } else {
        map.putIfAbsent(100 * i, () => Color(_hexToInt(stringSwatch[i])));
      }
    }
    return map;
  }
}
