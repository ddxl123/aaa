import 'package:flutter/material.dart';

ThemeData themeLight(BuildContext context) {
  return ThemeData.light().copyWith(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      actionsIconTheme: const IconThemeData(color: Colors.blue),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.blue),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
    ),
    tabBarTheme: TabBarTheme.of(context).copyWith(
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      labelColor: Colors.black,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: const UnderlineTabIndicator(borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 5), insets: EdgeInsets.fromLTRB(10, 0, 10, 8)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: const BorderSide(color: Colors.black)),
    ),
    iconTheme: const IconThemeData(color: Colors.blue),
  );
}
