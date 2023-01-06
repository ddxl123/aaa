import 'package:aaa/push_page/push_page.dart';
import 'package:aaa/single_dialog/register_or_login/showAskLoginDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

enum Status {
  normal,
  select,
  memory,
}

class GlobalAbController extends AbController {
  final loggedInUser = Ab<User?>(null);
  final status = Status.normal.ab;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await checkIsLoggedIn();
  }

  /// 检查是否已登录，未登录则弹出登录框。
  Future<void> checkIsLoggedIn() async {
    final result = await DriftDb.instance.generalQueryDAO.queryUserOrNull();
    if (result == null) {
      loggedInUser.refreshEasy((oldValue) => null);
    } else {
      loggedInUser.refreshEasy((oldValue) => result);
    }
    if (loggedInUser.isEmpty()) {
      SmartDialog.showToast('请先登录哦~');
      await showAskLoginDialog();
    }
  }
}
