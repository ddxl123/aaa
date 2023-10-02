import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class Unit<U, UR> {
  final U unitEntity;
  final UR unitREntity;

  Unit({
    required this.unitEntity,
    required this.unitREntity,
  });
}

class Group<G, U, UR> with AbBroken {
  Group({
    required this.fatherGroup,
    required this.surfaceEntity,
    required this.jumpTargetEntity,
  });

  /// 当前所在的组。
  /// 为 null 表示当前所在组为根组。
  final Group<G, U, UR>? fatherGroup;

  /// 为 null 表示当前所在组为根组。
  final Ab<G?> surfaceEntity;

  /// jump 的目标组（如果有）
  final Ab<G?> jumpTargetEntity;

  G? getDynamicGroupEntity([Abw? abw]) => jumpTargetEntity(abw) ?? surfaceEntity(abw);

  Ab<G?> getDynamicGroupEntityAb() => jumpTargetEntity() != null ? jumpTargetEntity : surfaceEntity;

  /// 在创建元素时，同时创建元素对应的 [selectedUnitCount] 和 [allUnitCount]。
  ///
  /// 如果当前 Group 是 jump 类型，[groups] 则是目标组的 list。
  final groups = <Ab<Group<G, U, UR>>>[].ab;

  /// 如果当前 Group 是 jump 类型，[units] 则是目标组的 list。
  final units = <Ab<Unit<U, UR>>>[].ab;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final selectedUnitCount = 0.ab;

  final allUnitCount = 0.ab;

  /// 保存当前 position。
  ///
  /// back 会上一个页面时，上一个页面的 position 会被重置，因此需要这个状态。
  double currentPosition = 0;

  void refreshGroupsAndUnits({
    required AbController c,
    required GroupsAndUnitEntities<G, U, UR> groupsAndUnitEntities,
  }) {
    broken(c);
    groups().addAll(
      groupsAndUnitEntities.groupEntities.map(
        (e) {
          print("111111");
          print(e.$1);
          print(e.$2);
          print("222222");
          return Group<G, U, UR>(
            fatherGroup: this,
            surfaceEntity: e.$1.ab,
            jumpTargetEntity: (e.$2).ab,
          ).ab;
        },
      ),
    );
    units().addAll(groupsAndUnitEntities.unitEntities.map((e) => Unit<U, UR>(unitEntity: e.unitEntity, unitREntity: e.unitREntity).ab));
    jumpTargetEntity.refreshEasy((oldValue) => groupsAndUnitEntities.jumpTargetEntity);
  }

  /// 同时会自动带动 [groups] 的子元素进行 broken。
  ///
  /// 只 broken [groups] 和 [units]。
  @override
  void broken(AbController c) {
    for (var gs in groups()) {
      gs().refreshController.dispose();
    }
    groups.clearAndSelfBroken(c);
    units.clearAndSelfBroken(c);
  }
}

/// [G] 组类型。
///
/// [U] 单元类型。
///
/// [GC] 组配置。
abstract class GroupListWidgetController<G, U, UR> extends AbController {
  final groupChainScrollController = ScrollController();
  final rootGroup = Group<G, U, UR>(
    fatherGroup: null,
    surfaceEntity: Ab<G?>(null),
    jumpTargetEntity: Ab<G?>(null),
  ).ab;

  /// 当点击 jump 类型的碎片组时，跳转到的是 jump 类型碎片组本身，而非 jump 目标组，因此 [groupChain] 添加的也是 jump 类型碎片组。
  /// 因此需要手动 find 对应的目标碎片组。
  late final groupChain = <Ab<Group<G, U, UR>>>[rootGroup].ab;
  final isSelecting = false.ab;
  final longPressedTarget = Ab<Group<G, U, UR>?>(null);

  @override
  void onDispose() {
    groupChainScrollController.dispose();
  }

  void setRootGroupEntity({required G? surfaceEntity, required G? jumpTargetEntity}) {
    rootGroup().surfaceEntity.refreshEasy((oldValue) => surfaceEntity);
    rootGroup().jumpTargetEntity.refreshEasy((oldValue) => jumpTargetEntity);
  }

  /// 如果当前 Group 是 jump 类型，那么获取到的也是 jump 类型，而非目标碎片组。
  Ab<Group<G, U, UR>> getCurrentGroupAb() {
    return groupChain().last;
  }

  List<Ab<Group<G, U, UR>>> getGroupChainNotRoot([Abw? abw]) {
    if (groupChain().length == 1) {
      return [];
    }
    return groupChain(abw).sublist(1, groupChain(abw).length);
  }

  /// 只获取每个 [Group] 的 [Group.surfaceEntity]。
  List<G> getGroupChainSurfaceEntityNotRoot([Abw? abw]) {
    return getGroupChainNotRoot(abw).map((e) => e(abw).surfaceEntity()!).toList();
  }

  /// 只获取每个 [Group] 的 [Group.getDynamicGroupEntity]。
  List<G> getGroupChainDynamicEntityNotRoot([Abw? abw]) {
    return getGroupChainNotRoot(abw).map((e) => e(abw).getDynamicGroupEntity()!).toList();
  }

  /// 获取每个 [Group] 的 [Group.surfaceEntity] 和 [Group.jumpTargetEntity]，并合并成一个数组。
  List<G> getGroupChainCombineEntityNotRoot([Abw? abw]) {
    final result = <G>[];
    getGroupChainNotRoot(abw).map(
      (e) {
        result.add(e(abw).surfaceEntity(abw) as G);
        if (e(abw).jumpTargetEntity() != null) {
          result.add(e(abw).jumpTargetEntity() as G);
        }
      },
    ).toList();
    return result;
  }

  /// 刷新 [Group.selectedUnitCount] 和 [Group.allUnitCount]
  ///
  /// [Tuple2.t1] 为 [Group.selectedUnitCount]
  /// [Tuple2.t2] 为 [Group.allUnitCount]
  ///
  /// 可以不用等待异步。
  Future<(int, int)> needRefreshCount(Ab<Group<G, U, UR>> whichGroup);

  Future<void> refreshCount({required Ab<Group<G, U, UR>> whichGroup, bool isRootRefreshCount = true}) async {
    final count = await needRefreshCount(whichGroup);
    whichGroup().selectedUnitCount.refreshEasy((oldValue) => count.$1);
    whichGroup().allUnitCount.refreshEasy((oldValue) => count.$2);

    await Future.forEach<Ab<Group<G, U, UR>>>(
      whichGroup().groups(),
      (element) async {
        final eCount = await needRefreshCount(element);
        element().selectedUnitCount.refreshEasy((oldValue) => eCount.$1);
        element().allUnitCount.refreshEasy((oldValue) => eCount.$2);
      },
    );
    if (isRootRefreshCount) {
      await refreshCount(whichGroup: groupChain().first, isRootRefreshCount: false);
    }
  }

  Future<void> refreshCurrentGroup() async {
    final g = getCurrentGroupAb()();
    final newEntities = await findEntities(g.surfaceEntity());
    g.refreshGroupsAndUnits(c: this, groupsAndUnitEntities: newEntities);
    await refreshCount(whichGroup: getCurrentGroupAb());
    groupChain.refreshForce();

    groupChainScrollController.animateTo(
      // TODO: 有时候会出现这个异常 Failed assertion: line 105 pos 12: '_positions.isNotEmpty': ScrollController not attached to any scroll views.
      groupChainScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCirc,
    );
    await refreshExtra();
    await refreshDone();
  }

  FutureOr<void> refreshExtra();

  FutureOr<void> refreshDone();

  /// 进入哪个 [groupChain] 或进入新的 [whichGroup]。
  ///
  /// [whichGroup] 为 [groupChain] 的元素。
  Future<void> enterGroup(Ab<Group<G, U, UR>> whichGroup) async {
    if (groupChain().contains(whichGroup)) {
      final indexOf = groupChain().indexOf(whichGroup);
      if (getCurrentGroupAb() != whichGroup) {
        groupChain()[indexOf + 1].broken(this);
        groupChain().removeRangeBroken(this, indexOf + 1, groupChain().length);
      }
    } else {
      groupChain().add(whichGroup);
    }
    await refreshCurrentGroup();

    rootGroup.refreshForce();
    groupChain.refreshForce();
  }

  /// 返回到上一个 [Group]。
  Future<void> backGroup() async {
    if (groupChain().length > 1) {
      await enterGroup(groupChain()[groupChain().length - 2]);
    } else {
      await enterGroup(groupChain()[0]);
    }
  }

  /// 查询 [whichSurfaceGroupEntity] 内的全部 [Group] 实体 和 [Unit] 实体。
  Future<GroupsAndUnitEntities<G, U, UR>> findEntities(G? whichSurfaceGroupEntity);
}

class GroupsAndUnitEntities<G, U, UR> {
  final G? jumpTargetEntity;

  /// 第一个-碎片组，第二个-碎片组对应的jump
  final List<(G, G?)> groupEntities;
  final List<Unit<U, UR>> unitEntities;

  GroupsAndUnitEntities({
    required this.jumpTargetEntity,
    required this.groupEntities,
    required this.unitEntities,
  });
}
