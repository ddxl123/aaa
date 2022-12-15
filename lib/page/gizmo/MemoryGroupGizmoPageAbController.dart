import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupGizmoPageAbController extends AbController {
  MemoryGroupGizmoPageAbController({required this.memoryGroupGizmo});

  final Ab<MemoryGroup> memoryGroupGizmo;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final Ab<MemoryModel?> memoryModel = Ab(null);

  final fragments = <Ab<Fragment>>[].ab;

  Future<void> refreshPage() async {
    await refreshFragments();
    await refreshMemoryModels();
  }

  Future<void> refreshMemoryModels() async {
    final mg = await db.generalQueryDAO.queryMemoryModelInMemoryGroup(memoryGroup: memoryGroupGizmo());
    memoryModel.refreshEasy((oldValue) => mg);
  }

  Future<void> refreshFragments() async {
    final mgs = (await db.generalQueryDAO.queryFragmentsInMemoryGroup(memoryGroup: memoryGroupGizmo())).map((e) => e.ab);
    fragments().clearBroken(this);
    fragments.refreshInevitable((obj) => obj..addAll(mgs));
  }
}
