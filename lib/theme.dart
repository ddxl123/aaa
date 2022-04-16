import 'package:flutter/material.dart';

ThemeData themeLight() {
  return ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      actionsIconTheme: IconThemeData(color: Colors.blue),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.blue),
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 240, 1),
  );
}
