import 'package:flutter/material.dart';

const List<Color> _colorThemes = [
  Colors.red,
  Colors.blue,
];

class AppTheme {

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: _colorThemes[ 0 ],
  );

}