part of aber;

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
    required this.currentGroup,
    required this.currentGroupEntity,
  });

  /// 当前所在的组。
  /// 为 null 表示当前所在组为根组。
  final Ab<Group?> currentGroup;

  final Ab<G?> currentGroupEntity;

  /// 已进入的组。
  ///
  /// 必然为 [groups] 元素之一。
  Ab<Group<G, U>>? enteredGroup;

  final groups = <Ab<Group<G, U>>>[].ab;
  final units = <Ab<Unit<U>>>[].ab;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  /// 保存当前 position。
  ///
  /// back 会上一个页面时，上一个页面的 position 会被重置，因此需要这个状态。
  double currentPosition = 0;

  /// 同时会自动带动 [groups] 的子元素进行 broken。
  ///
  /// 只 broken [groups] 和 [units]。
  @override
  void broken(AbController c) {
    enteredGroup?.call().refreshController.dispose();
    enteredGroup = null;
    // enteredGroup?.broken(c); 已经在 groups 上统一 broken。
    groups.clearAndSelfBroken(c);
    units.clearAndSelfBroken(c);
  }
}

/// [G] 组类型。
///
/// [U] 单元类型。
abstract class GroupListWidgetController<G, U> extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  final groupChainScrollController = ScrollController();
  final group = Group<G, U>(currentGroup: Ab<Group<G, U>?>(null), currentGroupEntity: Ab<G?>(null)).ab;
  late final groupChain = <Ab<Group<G, U>>>[group].ab;

  Ab<Group<G, U>> getCurrentGroup() {
    return groupChain().last;
  }

  /// 进入哪个 [groupChain] 或进入新的 [whichGroup]。
  ///
  /// [whichGroup] 为 [groupChain] 的元素。
  Future<void> enterGroup(Ab<Group<G, U>> whichGroup) async {
    if (groupChain().contains(whichGroup)) {
      // 若为空，则当前 whichGroup 为 last。
      whichGroup().enteredGroup?.broken(this);
      if (whichGroup().enteredGroup != null) {
        groupChain().removeRangeBroken(this, groupChain().indexOf(whichGroup), groupChain().length);
      }
    } else {
      final result = await findGroupAndUnitInWhichGroup(whichGroup);
      whichGroup().groups().addAll(result.groups);
      whichGroup().units().addAll(result.units);
      groupChain().last().enteredGroup = whichGroup;
      groupChain().add(whichGroup);
    }
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

  /// 查询 [whichGroup] 内的全部 [Group] 和 [Unit]。
  Future<GroupsAndUnits<G, U>> findGroupAndUnitInWhichGroup(Ab<Group<G, U>> whichGroup);
}

class GroupsAndUnits<G, U> {
  final List<Ab<Group<G, U>>> groups;
  final List<Ab<Unit<U>>> units;

  GroupsAndUnits({
    required this.groups,
    required this.units,
  });
}
