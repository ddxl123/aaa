import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PartListForFragmentHome {
  PartListForFragmentHome(this.fatherFragmentGroup);

  final Ab<FragmentGroup>? fatherFragmentGroup;

  final fragmentGroups = <Ab<FragmentGroup>>[].ab;
  final fragments = <Ab<Fragment>>[].ab;

  void dispose<C extends AbController>(C controller) {
    for (var value in fragmentGroups()) {
      value.broken(controller);
    }
    for (var value1 in fragments()) {
      value1.broken(controller);
    }
    fragmentGroups.broken(controller);
    fragments.broken(controller);
  }
}

class FragmentHomeGetController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  /// 必须预留一个顶级的。
  final parts = <Ab<PartListForFragmentHome>>[PartListForFragmentHome(null).ab].ab;

  PartListForFragmentHome currentPart([Abw? abw]) => parts().last(abw);

  List<Ab<FragmentGroup>> currentFragmentGroups([Abw? abw]) => currentPart().fragmentGroups(abw);

  FragmentGroup currentFragmentGroup(int index, Abw abw) => currentFragmentGroups()[index](abw);

  List<Ab<Fragment>> currentFragments([Abw? abw]) => currentPart().fragments(abw);

  Fragment currentFragment(int index, Abw abw) => currentFragments()[index](abw);

  FragmentGroup? currentFatherFragmentGroup([Abw? abw]) => currentPart().fatherFragmentGroup?.call(abw);

  Future<void> refreshPart() async {
    await DriftDb.instance.singleDAO.queryFragmentGroupBy(null);
  }

  Future<void> enterPart(Ab<FragmentGroup> fg) async {
    final part = PartListForFragmentHome(fg).ab;
    parts.refreshInevitable((obj) => obj..add(part));
  }

  void backPart() {
    if (parts().length == 1) return;
    parts.refreshInevitable((obj) => obj
      ..last().dispose(this)
      ..removeLastForAb(this));
  }

  void backPartTo(Ab<PartListForFragmentHome> p) {
    final index = parts().indexOf(p);
    final removeCount = parts().length - 1 - index;
    for (int i = 0; i < removeCount; i++) {
      backPart();
    }
  }

  Future<void> addFragmentGroup(String title) async {
    final newEntry = await DriftDb.instance.singleDAO.insertFragmentGroup(
      currentPart().fatherFragmentGroup?.call(),
      FragmentGroupsCompanion()..title = title.toDriftValue(),
    );
    currentPart().fragmentGroups.refreshInevitable((obj) => obj..add(newEntry.ab));
  }

  Future<void> addFragment(String title) async {
    final newEntry = await DriftDb.instance.singleDAO.insertFragment(
      currentPart().fatherFragmentGroup?.call(),
      FragmentsCompanion()..title = title.toDriftValue(),
    );
    currentPart().fragments.refreshInevitable((obj) => obj..add(newEntry.ab));
  }
}
