import 'package:drift_main/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupGizmoPageAbController extends AbController {
  MemoryGroupGizmoPageAbController({required this.memoryGroupGizmo});

  final Ab<MemoryGroup> memoryGroupGizmo;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final Ab<MemoryModel?> memoryRule = Ab(null);

  final fragments = <Ab<Fragment>>[].ab;

  Future<void> refreshPage() async {
    await refreshFragments();
    await refreshMemoryRule();
  }

  Future<void> refreshMemoryRule() async {
    final mg = (await DriftDb.instance.singleDAO.queryMemoryModelInsideMemoryGroup(memoryModelId: memoryGroupGizmo().memoryModelId));
    memoryRule.refreshEasy((oldValue) => mg);
  }

  Future<void> refreshFragments() async {
    final mgs = (await DriftDb.instance.singleDAO.queryFragmentInMemoryGroup(memoryGroupGizmo().id)).map((e) => e.ab);
    fragments().clear_(this);
    fragments.refreshInevitable((obj) => obj..addAll(mgs));
  }
}
