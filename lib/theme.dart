import 'package:flutter/material.dart';

ThemeData themeLight(BuildContext context) {
  return ThemeData.light().copyWith(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      actionsIconTheme: const IconThemeData(color: Colors.blue),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.blue),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
    ),
    scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 240, 1),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: const BorderSide(color: Colors.black)),
    ),
  );
}
