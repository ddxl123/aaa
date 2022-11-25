import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

enum Status {
  normal,
  select,
  memory,
}

class GlobalAbController extends AbController {
  final status = Status.normal.ab;

  Future<User?> getLoggedUser() async {
    final result = await DriftDb.instance.generalQueryDAO.queryUserOrNull();
    if (result == null) {
      SmartDialog.showToast("请先登录！");
      return null;
    }
    return result;
  }
}
