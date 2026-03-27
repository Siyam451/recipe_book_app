import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey.shade100,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    cardColor: Colors.grey.shade900,
    scaffoldBackgroundColor: Colors.black,
  );
}