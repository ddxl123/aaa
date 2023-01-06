import 'package:tools/tools.dart';

/// 返回当前是否继续执行发送验证码任务。
Future<bool> showExistClientLoggedInHandleDialog() async {
  await showCustomDialog(
    builder: (_) {
      return OkAndCancelDialogWidget(
        text: "本地原有的用户与将要登录的用户不是同一个用户,登录新用户需要清空旧用户全部本地数据,是否要清空?",
        okText: "清空并登录",
        cancelText: "暂不登录",
      );
    },
  );
  return false;
}
