import 'dart:math';

import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';

class FragmentGroupListPageController extends GroupListWidgetController<FragmentGroup, Fragment> {
  /// 已选碎片。
  final selectedFragment = <Fragment>[].ab;

  /// 已选碎片组。
  final selectedFragmentGroup = <FragmentGroup>[].ab;

  @override
  Future<GroupsAndUnitEntities<FragmentGroup, Fragment>> findEntities(FragmentGroup? whichGroupEntity) async {
    return GroupsAndUnitEntities(
      groupEntities: [
        FragmentGroup(
          creatorUserId: 1,
          title: Random().nextInt(10000).toString(),
          createdAt: DateTime.now(),
          id: "11",
          updatedAt: DateTime.now(),
          isSelected: false,
        ),
      ],
      unitEntities: [
        Fragment(
          creatorUserId: 1,
          content: Random().nextInt(10000).toString(),
          createdAt: DateTime.now(),
          id: "11",
          updatedAt: DateTime.now(),
          isSelected: false,
        ),
      ],
    );
  }
}
