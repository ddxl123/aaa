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

  Future<void> getLoggedInUser() async {
    final result = await DriftDb.instance.generalQueryDAO.queryUserOrNull();
    if (result == null) {
      loggedInUser.refreshEasy((oldValue) => null);
      SmartDialog.showToast("请先登录！");
    } else {
      loggedInUser.refreshEasy((oldValue) => result);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // getLoggedInUser();
  }
}
