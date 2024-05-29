import 'package:flutter/material.dart';

class SAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    ),
  );
}
