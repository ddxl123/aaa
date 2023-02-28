import 'package:drift_main/drift/DriftDb.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class ShorthandListPageAbController extends AbController {
  final refreshController = RefreshController(initialRefresh: true);
  final shorthandsAb = <Ab<Shorthand>>[].ab;

  Future<void> refreshPage() async {
    final result = await db.generalQueryDAO.queryAllShorthands();
    shorthandsAb.clearBroken(this);
    shorthandsAb.refreshInevitable((obj) => obj..addAll(result.map((e) => e.ab)));
  }
}
