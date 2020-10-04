import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:tinycolor/tinycolor.dart';

Color stringToColor(String str) {
  str = md5.convert(utf8.encode(str)).toString();

  if (str == null) return null;
  int hash = 0;

  for (int i = 0; i < str.length; i++) {
    hash = str.codeUnitAt(i) + ((hash << 5) - hash);
  }

  String color = '#';

  for (int i = 0; i < 3; i++) {
    var value = (hash >> (i * 8)) & 0xFF;
    color += value.toRadixString(16);
  }

  color += "000000";
  color = color.substring(0, 7);

  return TinyColor.fromString(color).color;
}