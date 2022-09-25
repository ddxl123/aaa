import 'package:aaa/GlobalAbController.dart';
import 'package:aaa/home/Home.dart';
import 'package:aaa/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

void main() {
  // flutter_smart_dialog 相关
  SmartDialog.config
    ..toast = SmartConfigToast(
        displayTime: const Duration(milliseconds: 1000),
        displayType: SmartToastType.last)
    ..custom = SmartConfigCustom(
        animationType: SmartAnimationType.centerScale_otherSlide,
        animationTime: const Duration(milliseconds: 100));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<GlobalAbController>(
      putController: GlobalAbController(),
      builder: (controller, abw) {
        return MaterialApp(
          // 那种材料包需要本地化的支持
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          // 支持哪种语言的切换
          supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
          // 默认使用哪种语言
          locale: const Locale('zh', 'CN'),
          theme: themeLight(context),
          // flutter_smart_dialog 相关
          navigatorObservers: [FlutterSmartDialog.observer],
          // flutter_smart_dialog 相关
          builder: FlutterSmartDialog.init(),
          // pull_to_refresh 相关
          home: RefreshConfiguration(
            footerBuilder: () =>
                const ClassicFooter(loadStyle: LoadStyle.ShowAlways),
            child: const Home(),
            // child: const FlutterTest(),
          ),
        );
      },
    );
  }
}
