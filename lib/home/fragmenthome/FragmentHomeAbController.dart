import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PartListForFragmentHome {
  PartListForFragmentHome(this.fatherFragmentGroup);

  /// TODO: back 会上一个页面时，上一个页面的 position 会被重置。
  /// TODO: 调用 dispose 时，会抛出异常。
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  double currentPosition = 0;

  final Ab<FragmentGroup>? fatherFragmentGroup;

  final fragmentGroups = <Ab<FragmentGroup>>[].ab;
  final fragments = <Ab<Fragment>>[].ab;

  void clean<C extends AbController>(C controller) {
    fragmentGroups.clear_(controller);
    fragments.clear_(controller);
  }

  void dispose<C extends AbController>(C controller) {
    fragmentGroups.clearAndSelf_(controller);
    fragments.clearAndSelf_(controller);
  }
}

class FragmentHomeAbController extends AbController {
  /// 必须预留一个顶级的。
  final parts = <Ab<PartListForFragmentHome>>[PartListForFragmentHome(null).ab].ab;

  PartListForFragmentHome currentPart([Abw? abw]) => parts().last(abw);

  List<Ab<FragmentGroup>> currentFragmentGroups([Abw? abw]) => currentPart().fragmentGroups(abw);

  FragmentGroup currentFragmentGroup(int index, Abw abw) => currentFragmentGroups()[index](abw);

  List<Ab<Fragment>> currentFragments([Abw? abw]) => currentPart().fragments(abw);

  Fragment currentFragment(int index, Abw abw) => currentFragments()[index](abw);

  FragmentGroup? currentFatherFragmentGroup([Abw? abw]) => currentPart().fatherFragmentGroup?.call(abw);

  Future<void> refreshCurrentPart<C extends AbController>() async {
    final newFragmentGroups = (await DriftDb.instance.singleDAO.queryFragmentGroupsBy(currentPart().fatherFragmentGroup?.call())).map((e) => e.ab);
    final newFragments = (await DriftDb.instance.singleDAO.queryFragmentsBy(currentPart().fatherFragmentGroup?.call())).map((e) => e.ab);
    currentPart().clean(this);
    currentPart().fragmentGroups.refreshInevitable((obj) => obj..addAll(newFragmentGroups));
    currentPart().fragments.refreshInevitable((obj) => obj..addAll(newFragments));
  }

  Future<void> enterPart(Ab<FragmentGroup> fg) async {
    currentPart().currentPosition = currentPart().refreshController.position!.pixels;
    final part = PartListForFragmentHome(fg).ab;
    parts.refreshInevitable((obj) => obj..add(part));
    // 在 onRefresh 中会调用 refreshCurrentPart();
  }

  void backPart() {
    if (parts().length == 1) return;
    parts.refreshInevitable(
      (obj) => obj
        ..last().dispose(this)
        ..removeLast_(this),
    );
    currentPart().refreshController.position!.jumpTo(currentPart().currentPosition);
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
