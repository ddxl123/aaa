import 'package:aaa/page/list/FragmentGroupListPageAbController1.dart';
import 'package:drift/drift.dart' as d;
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class Unit<U extends d.Table> with AbBroken {
  final Ab<U> unitEntity;

  Unit({
    required this.unitEntity,
  });


  @override
  void broken(AbController c) {
    unitEntity.broken(c);
  }
}

class Group<G extends d.Table, U extends d.Table> with AbBroken {
  /// 当前所在的组。
  /// 为 null 表示当前所在组为根组。
  final currentGroup = Ab<Group?>(null);

  final currentGroupEntity = Ab<G?>(null);

  final groups = <Ab<Group<G, U>>>[].ab;
  final units = <Ab<Unit<U>>>[].ab;

  /// 保存当前 position。
  ///
  /// back 会上一个页面时，上一个页面的 position 会被重置，因此需要这个状态。
  double currentPosition = 0;

  /// 回到
  void toRootClear(AbController c) {
    currentGroup.broken(c);
    currentGroupEntity.broken(c);
    currentGroup.refreshEasy((oldValue) => null);
    currentGroupEntity.refreshEasy((oldValue) => null);
  }

  @override
  void broken(AbController c) {
    groups.clearAndSelf_(c);
    units.clearAndSelf_(c);
  }
}

/// [G] 组类型。
///
/// [U] 单元类型。
abstract class GroupListWidgetController<G extends d.Table, U extends d.Table> extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  final scrollController = ScrollController();
  final group = Group<G, U>().ab;

  /// 当 [whichGroup] 为 null 时，进入根路径。
  Future<bool> enterGroup(Ab<Group<G, U>>? whichGroup);

  Future<bool> backGroup();

  /// 当 [whichGroup] 为 null 时，跳到根路径。
  Future<bool> jumpGroup(Ab<Group<G, U>>? whichGroup);
}

class FragmentGroupListWidgetAbController extends GroupListWidgetController<FragmentGroups, Fragments> {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  Future<bool> enterGroup(Ab<Group<FragmentGroups, Fragments>>? whichGroup) async {
    if (whichGroup == null) {
      group
    }
  }

  @override
  Future<bool> backGroup() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> jumpGroup(Ab<Group<FragmentGroups, Fragments>>? whichGroup) async {
    throw UnimplementedError();
  }
}
