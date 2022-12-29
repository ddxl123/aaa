import 'package:aaa/push_page/push_page.dart';
import 'package:aaa/single_dialog/showAskLoginDialog.dart';
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
    await getLoggedInUser();
    if (loggedInUser.isEmpty()) {
      SmartDialog.showToast('请先登录哦~');
      showAskLoginDialog();
    }
  }

  Future<void> getLoggedInUser() async {
    final result = await DriftDb.instance.generalQueryDAO.queryUserOrNull();
    if (result == null) {
      loggedInUser.refreshEasy((oldValue) => null);
    } else {
      loggedInUser.refreshEasy((oldValue) => result);
    }
  }
}
