import 'dart:ui';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/theme/theme.dart';
import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

import 'algorithm_parser/AlgorithmKeyboard.dart';
import 'home/Home.dart';

void main() {
  // 自定义键盘 相关
  AlgorithmKeyboard.register();

  // flutter_smart_dialog 相关
  SmartDialog.config
    ..toast = SmartConfigToast(
      displayTime: const Duration(milliseconds: 2000),
      displayType: SmartToastType.multi,
      animationType: SmartAnimationType.centerFade_otherSlide,
      alignment: Alignment.bottomCenter,
    )
    ..custom = SmartConfigCustom(animationType: SmartAnimationType.centerScale_otherSlide, animationTime: const Duration(milliseconds: 100));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 哪种材料包需要本地化的支持
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // 支持哪种语言的切换
      supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
      // 默认使用哪种语言
      locale: const Locale('zh', 'CN'),
      theme: themeLight(context),
      // flutter_easyloading、flutter_smart_dialog 相关
      navigatorObservers: [FlutterSmartDialog.observer],
      // flutter_smart_dialog 相关
      builder: EasyLoading.init(builder: FlutterSmartDialog.init()),
      // pull_to_refresh 相关
      home: RefreshConfiguration(
        footerBuilder: () => const ClassicFooter(loadStyle: LoadStyle.ShowAlways),
        child: const Main(),
        // child: const FlutterTest(),
      ),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<GlobalAbController>(
      putController: GlobalAbController(),
      builder: (controller, abw) {
        return const Home();
      },
    );
  }
}
