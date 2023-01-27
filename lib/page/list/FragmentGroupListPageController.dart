import 'dart:math';

import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';

class FragmentGroupListPageController extends GroupListWidgetController<FragmentGroup, Fragment, FragmentGroupConfig> {
  @override
  Future<GroupsAndUnitEntities<FragmentGroup, Fragment, FragmentGroupConfig>> findEntities(FragmentGroup? whichGroupEntity) async {
    // 若 whichGroupEntity 不为 null，则必然存在 whichGroupEntity。father_fragment_groups_id!。
    final config = whichGroupEntity == null ? null : await db.generalQueryDAO.queryFragmentGroupById(targetFragmentGroupId: whichGroupEntity.id);
    final fs = await db.generalQueryDAO.queryFragmentsInFragmentGroupById(targetFragmentGroupId: whichGroupEntity?.id);
    final fgs = await db.generalQueryDAO.queryFragmentGroupsInFragmentGroupById(targetFragmentGroupId: whichGroupEntity?.id);
    logger.outNormal(print: fgs);
    return GroupsAndUnitEntities(
      config: config?.fragmentGroupConfig,
      unitEntities: fs,
      groupAndConfigEntities: fgs.map((e) => GroupAndConfig(groupEntity: e.fragmentGroup, groupConfig: e.fragmentGroupConfig)).toList(),
    );
  }

  @override
  Future<Tuple2<int, int>> needRefreshCount(FragmentGroup? whichGroupEntity) async {
    final selectedCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
      targetFragmentGroupId: whichGroupEntity?.id,
      queryFragmentWhereType: QueryFragmentWhereType.selected,
    );
    final allCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
      targetFragmentGroupId: whichGroupEntity?.id,
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
