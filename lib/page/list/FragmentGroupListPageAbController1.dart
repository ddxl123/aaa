
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


/// TODO: 快速点击按钮时，可能会触发多次函数，可能会抛出 'setState() or markNeedsBuild() called during build.' 等异常。
class Parts {
  Parts({
    required this.fatherGroupEntity,
    required this.controller,
  });

  final GroupListWidgetAbController controller;

  /// TODO: 调用 dispose 时，会抛出异常。
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  /// 保存当前 position。
  ///
  /// back 会上一个页面时，上一个页面的 position 会被重置，因此需要这个状态。
  double currentPosition = 0;

  final Ab<FragmentGroup>? fatherGroupEntity;

  final groupEntities = <Ab<FragmentGroup>>[].ab;

  final unitEntities = <Ab<Fragment>>[].ab;

  final fragmentCountForAllSubgroup = <Ab<FragmentGroup>, Ab<int>>{}.ab;

  final selectedFragmentCountForAllSubgroup = <Ab<FragmentGroup>, Ab<int>>{}.ab;

  FragmentGroup indexFragmentGroup(int index, [Abw? abw]) => groupEntities()[index](abw);

  Ab<FragmentGroup> indexAbFragmentGroup(int index) => groupEntities()[index];

  Fragment indexFragment(int index, [Abw? abw]) => unitEntities()[index](abw);

  Ab<Fragment> indexAbFragment(int index) => unitEntities()[index];

  int indexFragmentCountForAllSubgroup(int index, Abw abw) => fragmentCountForAllSubgroup()[indexAbFragmentGroup(index)]?.call(abw) ?? 0;

  int indexSelectedFragmentCountForAllSubgroup(int index, Abw abw) => selectedFragmentCountForAllSubgroup()[indexAbFragmentGroup(index)]?.call(abw) ?? 0;

  /// 当前碎片是否已被选择。
  bool indexIsSelectedForFragment(int index, Abw abw) => controller.selectedFragmentIds(abw).contains(indexFragment(index).id);

  /// 当前碎片组是否已被选择。
  ///
  /// 返回 null 表示至少选择了一个，但没有全选。
  bool? indexIsSelectedForFragmentGroup(int index, [Abw? abw]) {
    final current = indexAbFragmentGroup(index);
    final int allCount = fragmentCountForAllSubgroup(abw)[current]!();
    final int selectedCount = selectedFragmentCountForAllSubgroup(abw)[current]!();
    return selectedCount == 0 ? false : (selectedCount < allCount ? null : true);
  }

  bool isAllEmpty(Abw abw) {
    return groupEntities(abw).isEmpty && unitEntities(abw).isEmpty;
  }

  Future<void> addFragmentGroup(FragmentGroupsCompanion entry) async {
    final newEntry = await DriftDb.instance.insertDAO.insertFragmentGroupWithRef(entry);
    groupEntities.refreshInevitable((obj) => obj..add(newEntry.ab));
  }

  /// TODO: 未使用 [withRefs]。
  Future<void> addFragment({required FragmentsCompanion willFragment}) async {
    final newEntry = await DriftDb.instance.insertDAO.insertFragmentWithRef(willFragment: willFragment);
    unitEntities.refreshInevitable((obj) => obj..add(newEntry.ab));
  }

  Future<void> _refreshPart() async {
    final newFragmentGroups = (await DriftDb.instance.generalQueryDAO.queryFragmentGroups(fatherGroupEntity?.call().id)).map((e) => e.ab);
    final newFragments = (await DriftDb.instance.generalQueryDAO.queryFragmentsByFragmentGroupId(fatherGroupEntity?.call().id)).map((e) => e.ab);
    clean();
    groupEntities.refreshInevitable((obj) => obj..addAll(newFragmentGroups));
    unitEntities.refreshInevitable((obj) => obj..addAll(newFragments));
  }

  Future<void> querySelectedAndFragmentCountFromAllSubgroup() async {
    await Future.forEach<Ab<FragmentGroup>>(
      groupEntities(),
      (element) async {
        final List<String> fs = await DriftDb.instance.generalQueryDAO.queryFragmentsForAllSubgroup(element().id, []);

        // 查询当前组内所有组的全部碎片数量。
        final int allCount = fs.length;
        if (fragmentCountForAllSubgroup().containsKey(element)) {
          fragmentCountForAllSubgroup()[element]!.refreshEasy((oldValue) => allCount);
        } else {
          fragmentCountForAllSubgroup().addAll({element: allCount.ab});
        }

        // 查询当前组内所有组的已选碎片数量。
        final selectedCount = fs.where((element) => controller.selectedFragmentIds().contains(element)).length;
        if (selectedFragmentCountForAllSubgroup().containsKey(element)) {
          selectedFragmentCountForAllSubgroup()[element]!.refreshEasy((oldValue) => selectedCount);
        } else {
          selectedFragmentCountForAllSubgroup().addAll({element: selectedCount.ab});
        }
      },
    );
    fragmentCountForAllSubgroup.refreshForce();
    selectedFragmentCountForAllSubgroup.refreshForce();
  }

  void selectFragment(String fId) {
    if (controller.selectedFragmentIds().contains(fId)) {
      controller.selectedFragmentIds.refreshInevitable((obj) => obj..remove(fId));
      return;
    }
    controller.selectedFragmentIds.refreshInevitable((obj) => obj..add(fId));
  }

  /// 只有当当前组内所有组的碎片被全选时，才会执行全不选
  Future<void> selectFragmentGroup(int index, String fgId) async {
    final List<String> fs = await DriftDb.instance.generalQueryDAO.queryFragmentsForAllSubgroup(fgId, []);
    final bool? isSelected = indexIsSelectedForFragmentGroup(index);

    if (isSelected == true) {
      controller.selectedFragmentIds.refreshInevitable((obj) => obj..removeAll(fs));
    } else {
      controller.selectedFragmentIds.refreshInevitable((obj) => obj..addAll(fs));
    }
    await querySelectedAndFragmentCountFromAllSubgroup();
  }

  void clean() {
    groupEntities.clear_(controller);
    unitEntities.clear_(controller);
    fragmentCountForAllSubgroup.clear_(controller);
    selectedFragmentCountForAllSubgroup.clear_(controller);
  }

  void dispose() {
    groupEntities.clearAndSelf_(controller);
    unitEntities.clearAndSelf_(controller);
    fragmentCountForAllSubgroup.clearAndSelf_(controller);
    selectedFragmentCountForAllSubgroup.clearAndSelf_(controller);
  }
}

class GroupListWidgetAbController extends AbController {
  final groupChainController = ScrollController();

  /// 必须预留一个顶级的。
  final parts = <Ab<Parts>>[].ab;

  final Ab<Set<String>> selectedFragmentIds = <String>{}.ab;

  Parts currentPart([Abw? abw]) => parts().last(abw);

  @override
  void onInit() {
    parts().add(Parts(controller: this, fatherGroupEntity: null).ab);
  }

  Future<void> enterPart(Ab<FragmentGroup>? fg) async {
    if (fg != null) {
      currentPart().currentPosition = currentPart().refreshController.position!.pixels;
      final part = Parts(fatherGroupEntity: fg, controller: this).ab;
      parts.refreshInevitable((obj) => obj..add(part));
    }
    await currentPart()._refreshPart();
    await currentPart().querySelectedAndFragmentCountFromAllSubgroup();
    await groupChainController.animateTo(groupChainController.position.maxScrollExtent, duration: const Duration(milliseconds: 1000), curve: Curves.easeOutCirc);
  }

  /// 若返回 true，则 back 成功。
  /// 若返回 false，则当前为 root。
  bool _backPart() {
    if (parts().length == 1) return false;
    parts().last().dispose();
    parts().removeLast_(this);
    parts.refreshForce();
    currentPart().refreshController.position!.jumpTo(currentPart().currentPosition);
    return true;
  }

  /// [_backPart] 后再进行 query。
  bool backPart() {
    final bp = _backPart();
    if (bp) {
      // 这里不需要 await
      currentPart().querySelectedAndFragmentCountFromAllSubgroup();
      return true;
    }
    return false;
  }

  /// back 到指定 part。
  Future<void> backPartJump(Ab<Parts> p) async {
    final index = parts().indexOf(p);
    final removeCount = parts().length - 1 - index;
    for (int i = 0; i < removeCount; i++) {
      _backPart();
    }
    await currentPart().querySelectedAndFragmentCountFromAllSubgroup();
  }
}
