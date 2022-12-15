import 'dart:math';

import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';

class FragmentGroupListPageController extends GroupListWidgetController<FragmentGroup, Fragment> {
  @override
  Future<GroupsAndUnitEntities<FragmentGroup, Fragment>> findEntities(FragmentGroup? whichGroupEntity) async {
    final fs = await DriftDb.instance.generalQueryDAO.queryFragmentsInFragmentGroup(targetFragmentGroup: whichGroupEntity);
    final fgs = await DriftDb.instance.generalQueryDAO.queryFragmentGroupsInFragmentGroup(targetFragmentGroup: whichGroupEntity);
    return GroupsAndUnitEntities(
      unitEntities: fs,
      groupEntities: fgs,
    );
  }

  @override
  Future<Tuple2<int, int>> needRefreshCount(FragmentGroup? whichGroupEntity) async {
    final selectedCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
      targetFragmentGroup: whichGroupEntity,
      queryFragmentWhereType: QueryFragmentWhereType.selected,
    );
    final allCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
      targetFragmentGroup: whichGroupEntity,
      queryFragmentWhereType: QueryFragmentWhereType.all,
    );
    if (selectedCount != allCount) {
      await db.updateDAO.resetFragmentGroupIsSelected(
        originalFragmentGroup: whichGroupEntity,
        isSelected: false,
        syncTag: null,
      );
    }
    return Tuple2(t1: selectedCount, t2: allCount);
  }

  Future<void> resetFragmentIsSelected({required Ab<Fragment> fragmentAb, required bool isSelected}) async {
    await db.updateDAO.resetFragmentIsSelected(
      originalFragment: fragmentAb(),
      isSelected: isSelected,
      syncTag: null,
    );
    fragmentAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }

  Future<void> resetFragmentGroupAndSubIsSelected({required Ab<FragmentGroup?> fragmentGroupAb, required bool isSelected}) async {
    await db.updateDAO.resetFragmentGroupAndSubIsSelected(fragmentGroup: fragmentGroupAb(), isSelected: isSelected);
    fragmentGroupAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }
}
