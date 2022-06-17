import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum MemoryRuleModelType {
  home,
  select,
}

class MemoryRuleModelAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryRules = <Ab<MemoryRule>>[].ab;

  final selected = Ab<MemoryRule?>(null);

  Future<void> addMemoryRule(MemoryRulesCompanion willEntity) async {
    final newEntity = await DriftDb.instance.singleDAO.insertMemoryRule(willEntity);
    memoryRules.refreshInevitable((obj) => obj..add(newEntity.ab));
  }

  Future<void> refreshMemoryRules() async {
    final mgs = (await DriftDb.instance.singleDAO.queryMemoryRules()).map((e) => e.ab);
    memoryRules().clear_(this);
    memoryRules.refreshInevitable((obj) => obj..addAll(mgs));
  }

  void selectMemoryRule(MemoryRule memoryRule) {
    if (selected() == memoryRule) {
      selected.refreshInevitable((obj) => null);
    } else {
      selected.refreshInevitable((obj) => memoryRule);
    }
  }
}
