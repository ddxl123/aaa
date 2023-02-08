import 'package:flutter/material.dart';

/// 整体的背景灰色.
const backgroundColor = Color.fromARGB(255, 245, 245, 245);

ThemeData themeLight(BuildContext context) {
  return ThemeData.light().copyWith(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      actionsIconTheme: const IconThemeData(color: Colors.blue),
      iconTheme: const IconThemeData(color: Colors.blue),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      color: backgroundColor,
      surfaceTintColor: backgroundColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    ),
    iconTheme: const IconThemeData(color: Colors.blue),
    cardTheme: const CardTheme(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      surfaceTintColor: Colors.white,
      color: Colors.white,
      shadowColor: Color.fromARGB(50, 0, 0, 0),
      elevation: 5,
      clipBehavior: Clip.hardEdge,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Colors.blue),
      trackColor: MaterialStatePropertyAll(Colors.black12),
    ),
  );
}
