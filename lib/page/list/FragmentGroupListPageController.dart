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
      await withRefs(
        syncTag: null,
        ref: (st) async {
          return RefFragmentGroups(
            self: (table) async {
              await whichGroupEntity?.reset(
                creatorUserId: toAbsent(),
                fatherFragmentGroupsId: toAbsent(),
                local_isSelected: false.toValue(),
                title: toAbsent(),
                syncTag: st,
              );
            },
            rFragment2FragmentGroups: null,
            child_fragmentGroups: null,
          );
        },
      );
    }
    return Tuple2(t1: selectedCount, t2: allCount);
  }

  Future<void> resetFragmentIsSelected({required Ab<Fragment> fragmentAb, required bool isSelected}) async {
    await withRefs(
      syncTag: null,
      ref: (st) async {
        return RefFragments(
          self: ($FragmentsTable table) async {
            await fragmentAb().reset(
              content: toAbsent(),
              creatorUserId: toAbsent(),
              fatherFragmentId: toAbsent(),
              local_isSelected: isSelected.toValue(),
              noteId: toAbsent(),
              syncTag: st,
            );
          },
          fragmentMemoryInfos: null,
          rFragment2FragmentGroups: null,
          child_fragments: null,
          memoryModels: null,
        );
      },
    );
    fragmentAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }

  Future<void> resetFragmentGroupIsSelected({required Ab<FragmentGroup?> fragmentGroupAb, required bool isSelected}) async {
    await withRefs(
      syncTag: null,
      ref: (st) async {
        return RefFragmentGroups(
          self: (table) async {
            await fragmentGroupAb()?.reset(
              creatorUserId: toAbsent(),
              fatherFragmentGroupsId: toAbsent(),
              local_isSelected: isSelected.toValue(),
              title: toAbsent(),
              syncTag: st,
            );
            final fs = await db.generalQueryDAO.querySubFragmentsInFragmentGroup(targetFragmentGroup: fragmentGroupAb());
            final fgs = await db.generalQueryDAO.querySubFragmentGroupsInFragmentGroup(targetFragmentGroup: fragmentGroupAb());
            await Future.forEach<Fragment>(
              fs,
              (element) async {
                await element.reset(
                  content: toAbsent(),
                  creatorUserId: toAbsent(),
                  fatherFragmentId: toAbsent(),
                  local_isSelected: isSelected.toValue(),
                  noteId: toAbsent(),
                  syncTag: st,
                );
              },
            );
            await Future.forEach<FragmentGroup>(
              fgs,
              (element) async {
                await element.reset(
                  creatorUserId: toAbsent(),
                  fatherFragmentGroupsId: toAbsent(),
                  local_isSelected: isSelected.toValue(),
                  title: toAbsent(),
                  syncTag: st,
                );
              },
            );
          },
          rFragment2FragmentGroups: null,
          child_fragmentGroups: null,
        );
      },
    );
    fragmentGroupAb.refreshForce();
    await refreshCount(whichGroup: getCurrentGroupAb());
  }
}
