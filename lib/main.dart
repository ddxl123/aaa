import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'Home.dart';
import 'drift/DriftDb.dart';
import 'fragmenthome/FragmentHome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(color: Colors.blue),
          elevation: 0,
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      ),
      home: RefreshConfiguration(
        footerBuilder: () => const ClassicFooter(loadStyle: LoadStyle.ShowAlways),
        child: const Home(),
      ),
      builder: EasyLoading.init(),
    );
  }
}
