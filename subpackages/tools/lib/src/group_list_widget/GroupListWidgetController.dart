import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class Unit<U> with AbBroken {
  final Ab<U> unitEntity;

  Unit({
    required this.unitEntity,
  });

  @override
  void broken(AbController c) {
    unitEntity.broken(c);
  }
}

class Group<G, U> with AbBroken {
  Group({
    required this.fatherGroup,
    required this.entity,
  });

  /// 当前所在的组。
  /// 为 null 表示当前所在组为根组。
  final Ab<Group?> fatherGroup;

  /// 为 null 表示当前所在组为根组。
  final Ab<G?> entity;

  /// 在创建元素时，同时创建元素对应的 [selectedUnitCount] 和 [allUnitCount]。
  final groups = <Ab<Group<G, U>>>[].ab;
  final units = <Ab<Unit<U>>>[].ab;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final selectedUnitCount = 0.ab;

  final allUnitCount = 0.ab;

  /// 保存当前 position。
  ///
  /// back 会上一个页面时，上一个页面的 position 会被重置，因此需要这个状态。
  double currentPosition = 0;

  void refreshGroupsAndUnits({
    required AbController c,
    required GroupsAndUnitEntities<G, U> groupsAndUnitEntities,
  }) {
    broken(c);
    groups().addAll(
      groupsAndUnitEntities.groupEntities.map(
        (e) => Group<G, U>(fatherGroup: fatherGroup, entity: e.ab).ab,
      ),
    );
    units().addAll(groupsAndUnitEntities.unitEntities.map((e) => Unit<U>(unitEntity: e.ab).ab));
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
abstract class GroupListWidgetController<G, U> extends AbController {
  final refreshController = RefreshController(initialRefresh: true);
  final groupChainScrollController = ScrollController();
  final group = Group<G, U>(fatherGroup: Ab<Group<G, U>?>(null), entity: Ab<G?>(null)).ab;
  late final groupChain = <Ab<Group<G, U>>>[group].ab;
  final isUnitSelecting = false.ab;

  @override
  void onDispose() {
    refreshController.dispose();
    groupChainScrollController.dispose();
  }

  Ab<Group<G, U>> getCurrentGroupAb() {
    return groupChain().last;
  }

  List<G> getCurrentFragmentGroupChain([Abw? abw]) {
    if (groupChain().length == 1) {
      return [];
    }
    return groupChain(abw).sublist(1, groupChain(abw).length).map((e) => e().entity(abw)!).toList();
  }

  /// 刷新 [Group.selectedUnitCount] 和 [Group.allUnitCount]
  ///
  /// [Tuple2.t1] 为 [Group.selectedUnitCount]
  /// [Tuple2.t2] 为 [Group.allUnitCount]
  ///
  /// 可以不用等待异步。
  Future<(int, int)> needRefreshCount(G? whichGroupEntity);

  Future<void> refreshCount({required Ab<Group<G, U>> whichGroup, bool isRootRefreshCount = true}) async {
    final count = await needRefreshCount(whichGroup().entity());
    whichGroup().selectedUnitCount.refreshEasy((oldValue) => count.$1);
    whichGroup().allUnitCount.refreshEasy((oldValue) => count.$2);

    await Future.forEach<Ab<Group<G, U>>>(
      whichGroup().groups(),
      (element) async {
        final eCount = await needRefreshCount(element().entity());
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
    final newEntities = await findEntities(g.entity());
    g.refreshGroupsAndUnits(c: this, groupsAndUnitEntities: newEntities);
    refreshCount(whichGroup: getCurrentGroupAb());
    groupChain.refreshForce();

    groupChainScrollController.animateTo(
      groupChainScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCirc,
    );
  }

  /// 进入哪个 [groupChain] 或进入新的 [whichGroup]。
  ///
  /// [whichGroup] 为 [groupChain] 的元素。
  Future<void> enterGroup(Ab<Group<G, U>> whichGroup) async {
    if (groupChain().contains(whichGroup)) {
      final indexOf = groupChain().indexOf(whichGroup);
      if (getCurrentGroupAb() != whichGroup) {
        groupChain()[indexOf + 1].broken(this);
        groupChain().removeRangeBroken(this, indexOf + 1, groupChain().length);
      }
    } else {
      groupChain().add(whichGroup);
    }

    refreshCount(whichGroup: whichGroup);

    group.refreshForce();
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

  /// 查询 [whichGroupEntity] 内的全部 [Group] 实体 和 [Unit] 实体。
  Future<GroupsAndUnitEntities<G, U>> findEntities(G? whichGroupEntity);
}

class GroupsAndUnitEntities<G, U> {
  final List<G> groupEntities;
  final List<U> unitEntities;

  GroupsAndUnitEntities({
    required this.groupEntities,
    required this.unitEntities,
  });
}
