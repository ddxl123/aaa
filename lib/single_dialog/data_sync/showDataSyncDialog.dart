import 'package:tools/tools.dart';

/// 处理初始化数据,同步数据等.
Future<void> showDataSyncDialog() async {
  await showCustomDialog(
    builder: (_) => DialogWidget(
      title: "未完善",
      mainVerticalWidgets: [],
      bottomHorizontalButtonWidgets: [],
    ),
  );
}
