import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 处理 当前将要登录的用户 与本 地已存在但已下线的用户 不一致的情况。
///
/// 这步操作前，会检查本地是否存在登录用户，存在则会抛出异常。
/// 因此，这里的 "本地原有的用户" 指的是本地被退出的用户（但是该用户的其他数据仍然存在）。
///
/// 若返回 true,则将清除数据库,并且继续执行登录成功；
/// 若返回 false,则不清除数据库,并且执行登录失败。
Future<bool> showExistClientLoggedInHandleDialog() async {
  var isContinue = false;
  await showCustomDialog(
    builder: (_) {
      return OkAndCancelDialogWidget(
        text: "本地原有的用户与将要登录的用户不是同一个用户,登录新用户需要清空旧用户全部本地数据,是否要清空?",
        okText: "清空并登录",
        cancelText: "暂不登录",
        onOk: () async {
          // 会在上一层函数内清空数据库。
          isContinue = true;
          SmartDialog.dismiss(status: SmartStatus.dialog);
        },
        onCancel: () {
          isContinue = false;
          SmartDialog.dismiss(status: SmartStatus.dialog);
        },
      );
    },
  );
  return isContinue;
}
