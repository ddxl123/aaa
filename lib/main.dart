import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/home/Home.dart';
import 'package:aaa/theme/theme.dart';
import 'package:catcher/catcher.dart';
import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

import 'algorithm_parser/AlgorithmKeyboard.dart';

void main() {
  // 全局异常捕获 相关
  CatcherOptions debugOptions = CatcherOptions(PageReportMode(), [ConsoleHandler()]);
  // Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.
  // CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
  //   EmailManualHandler(["support@email.com"])
  // ]);

  // flutter_smart_dialog 相关
  SmartDialog.config
    ..toast = SmartConfigToast(displayTime: const Duration(milliseconds: 2000), displayType: SmartToastType.normal)
    ..custom = SmartConfigCustom(animationType: SmartAnimationType.centerScale_otherSlide, animationTime: const Duration(milliseconds: 100));

  // 自定义键盘 相关
  AlgorithmKeyboard.register();

  Catcher(
    runAppFunction: _runMockApp,
    debugConfig: debugOptions,
  );
}

void _runMockApp() {
  runMockApp(const KeyboardRootWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Catcher.navigatorKey,
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
