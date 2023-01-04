import 'package:tools/tools.dart';

/// 返回当前是否继续执行登录操作。
Future<bool> showExistOtherPlaceLoggedInDialog() async {
  await showCustomDialog(
    builder: (_) => DialogWidget(
      mainVerticalWidgets: [],
      bottomHorizontalButtonWidgets: [],
    ),
  );
  return false;
}
