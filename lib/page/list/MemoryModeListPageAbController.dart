import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryModeListPageAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryModels = <Ab<MemoryModel>>[].ab;

  @override
  void onDispose() {
    refreshController.dispose();
    super.onDispose();
  }

  Future<void> refreshMemoryModels() async {
    throw "TODO";
    // final mgs = (await DriftDb.instance.generalQueryDAO.queryMemoryModels()).map((e) => e.ab);
    // memoryModels().clearBroken(this);
    // memoryModels.refreshInevitable((obj) => obj..addAll(mgs));
  }
}
