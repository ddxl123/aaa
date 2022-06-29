import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupVO {
  MemoryGroupVO({required this.memoryGroup, required this.memoryRule});

  final Ab<MemoryGroup> memoryGroup;
  final Ab<MemoryModel?> memoryRule;
}

class MemoryGroupModelAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryGroupVOs = <Ab<MemoryGroupVO>>[].ab;

  Future<void> refreshPage() async {
    final mgVOs = <Ab<MemoryGroupVO>>[];
    final mgs = await DriftDb.instance.singleDAO.queryMemoryGroups();
    await Future.forEach<MemoryGroup>(
      mgs,
      (element) async {
        final mr = await DriftDb.instance.singleDAO.queryMemoryRuleInMemoryGroup(element.id);
        final mgVO = Ab(MemoryGroupVO(memoryGroup: element.ab, memoryRule: mr.ab));
        mgVOs.add(mgVO);
      },
    );
    memoryGroupVOs().clear_(this);
    memoryGroupVOs.refreshInevitable((obj) => obj..addAll(mgVOs));
  }
}
