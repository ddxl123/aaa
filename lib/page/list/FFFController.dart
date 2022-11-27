import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class FFFController extends GroupListWidgetController<FragmentGroup, Fragment> {
  @override
  Future<GroupsAndUnits<FragmentGroup, Fragment>> findGroupAndUnitInWhichGroup(Ab<Group<FragmentGroup, Fragment>> whichGroup) async {
    return GroupsAndUnits(groups: [], units: []);
  }
}

class FFF extends StatelessWidget {
  const FFF({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupListWidget<FragmentGroup, Fragment>(
      groupListWidgetController: FFFController(),
      groupBuilder: (group, abw) {
        return CardCustom(child: Text(group(abw).currentGroupEntity()!.title));
      },
      unitBuilder: (unit, abw) {
        return CardCustom(child: Text(unit(abw).unitEntity().content));
      },
    );
  }
}
