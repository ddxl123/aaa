import 'package:aaa/page/fragment_group_view/FragmentGroupListViewAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class FragmentGroupListView extends StatelessWidget {
  const FragmentGroupListView({super.key, required this.enterFragmentGroup});

  final FragmentGroup enterFragmentGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GroupListWidget<FragmentGroup, Fragment, FragmentGroupListViewAbController>(
        groupListWidgetController: FragmentGroupListViewAbController(enterFragmentGroup: enterFragmentGroup),
        groupChainStrings: (group, abw) => group(abw).entity(abw)!.title,
        groupBuilder: (c, group, abw) {
          return GestureDetector(
            child: Container(
              child: Text(group().entity()!.title),
            ),
            onTap: () {
              c.enterGroup(group);
            },
          );
        },
        unitBuilder: (c, group, abw) => Container(
          child: Text(group().unitEntity().title),
        ),
        oneActionBuilder: (group, abw) => Container(),
        floatingButtonOnPressed: (c) {},
      ),
    );
  }
}
