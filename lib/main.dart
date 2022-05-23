import 'dart:developer';

import 'package:aaa/theme.dart';
import 'package:aaa/tool/CatchRollback.dart';
import 'package:catcher/catcher.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'Home.dart';
import 'drift/DriftDb.dart';
import 'fragmenthome/FragmentHome.dart';

import 'package:animations/animations.dart';

main() {
  final catcherOptions = CatcherOptions(
    PageReportMode(),
    [ConsoleHandler(enableDeviceParameters: false, enableApplicationParameters: false, enableCustomParameters: true)],
    localizationOptions: [LocalizationOptions.buildDefaultChineseOptions()],
    filterFunction: (report) {
      if (report.customParameters[CatchRollback.TEMPORARY_NULL_TAGS] is! List<String>) {
        report.customParameters[CatchRollback.TEMPORARY_NULL_TAGS] = <String>[];
      }
      final nullTags = (report.customParameters[CatchRollback.NULL_TAGS] as List<String>)..clear();
      final temporaryNullTags = report.customParameters[CatchRollback.TEMPORARY_NULL_TAGS];

      (temporaryNullTags is List<String>) ? (nullTags.addAll(temporaryNullTags)) : (nullTags..clear());

      report.customParameters.remove(CatchRollback.TEMPORARY_NULL_TAGS);
      return true;
    },
    customParameters: {
      CatchRollback.NULL_TAGS: <String>[],
    },
  );
  Catcher(
    debugConfig: catcherOptions,
    profileConfig: catcherOptions,
    releaseConfig: catcherOptions,
    runAppFunction: () => runApp(const MyApp()),
  );
  log(WidgetsBinding.instance.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 那种材料包需要本地化的支持
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // 支持哪种语言的切换
      supportedLocales: const [Locale('zh'), Locale('en')],
      // 默认使用哪种语言
      locale: const Locale('zh'),
      // catcher 相关
      navigatorKey: Catcher.navigatorKey,
      theme: themeLight(context),
      // pull_to_refresh 相关
      home: RefreshConfiguration(
        footerBuilder: () => const ClassicFooter(loadStyle: LoadStyle.ShowAlways),
        child: const Home(),
      ),
    );
  }
}
