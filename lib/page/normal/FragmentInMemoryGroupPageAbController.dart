import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FragmentInMemoryGroupPageAbController extends AbController {
  FragmentInMemoryGroupPageAbController(this.memoryGroupAb);

  final Ab<MemoryGroup> memoryGroupAb;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final Ab<MemoryModel?> memoryRule = Ab(null);

  final fragments = <Ab<Fragment>>[].ab;

  Future<void> refreshPage() async {
    await refreshFragments();
    await refreshMemoryRule();
  }

  Future<void> refreshMemoryRule() async {
    final mg = (await DriftDb.instance.singleDAO.queryMemoryRuleInMemoryGroup(memoryGroupAb().id));
    memoryRule.refreshEasy((oldValue) => mg);
  }

  Future<void> refreshFragments() async {
    final mgs = (await DriftDb.instance.singleDAO.queryFragmentInMemoryGroup(memoryGroupAb().id)).map((e) => e.ab);
    fragments().clear_(this);
    fragments.refreshInevitable((obj) => obj..addAll(mgs));
  }
}
