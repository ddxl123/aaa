import 'package:tools/tools.dart';

/// 返回当前是否继续执行发送验证码任务。
Future<bool> showExistUserHandleDialog() async {
  await showCustomDialog(
    builder: (_) {
      return OkAndCancelDialogWidget(
        okText: "清除",
        cancelText: "取消",
      );
    },
  );
  return false;
}
