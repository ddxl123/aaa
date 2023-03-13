import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';

class FragmentGroupListPageController extends GroupListWidgetController<FragmentGroup, Fragment> {
  @override
  Future<GroupsAndUnitEntities<FragmentGroup, Fragment>> findEntities(FragmentGroup? whichGroupEntity) async {
    // 若 whichGroupEntity 不为 null，则必然存在 whichGroupEntity。father_fragment_groups_id!。
    final fs = await db.generalQueryDAO.queryFragmentsInFragmentGroupById(targetFragmentGroupId: whichGroupEntity?.id);
    final fgs = await db.generalQueryDAO.queryFragmentGroupsInFragmentGroupById(targetFragmentGroupId: whichGroupEntity?.id);
    return GroupsAndUnitEntities(
      unitEntities: fs,
      groupEntities: fgs,
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
      final st = await SyncTag.create();
      await db.updateDAO.resetFragmentGroup(
        originalFragmentGroupReset: whichGroupEntity == null
            ? null
            : () async {
                await whichGroupEntity.reset(
                  client_be_selected: false.toValue(),
                  creator_user_id: toAbsent(),
                  father_fragment_groups_id: toAbsent(),
                  title: toAbsent(),
                  syncTag: st,
                  be_private: toAbsent(),
                  be_publish: toAbsent(),
                  tags: toAbsent(),
                );
              },
        syncTag: st,
      );
    }
    return Tuple2(t1: selectedCount, t2: allCount);
  }

  Future<void> resetFragmentIsSelected({required Ab<Fragment> fragmentAb, required bool isSelected}) async {
    await db.updateDAO.resetFragmentIsSelected(
      originalFragment: fragmentAb(),
      isSelected: isSelected,
      syncTag: await SyncTag.create(),
    );
    fragmentAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }

  Future<void> resetFragmentGroupAndSubIsSelected({required Ab<FragmentGroup?> fragmentGroupAb, required bool isSelected}) async {
    await db.updateDAO.resetFragmentGroupAndSubIsSelected(
      fragmentGroup: fragmentGroupAb(),
      isSelected: isSelected,
      syncTag: await SyncTag.create(),
    );
    fragmentGroupAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }
}
