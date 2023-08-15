import 'package:aaa/page/fragment_group_view/FragmentGroupSelectViewAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class FragmentGroupSelectView extends StatefulWidget {
  const FragmentGroupSelectView({super.key});

  @override
  State<FragmentGroupSelectView> createState() => _FragmentGroupSelectViewState();
}

class _FragmentGroupSelectViewState extends State<FragmentGroupSelectView> {
  final fragmentGroupSelectViewAbController = FragmentGroupSelectViewAbController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: Container(), preferredSize: Size(0, 10)),
      body: GroupListWidget<FragmentGroup, Fragment, RFragment2FragmentGroup, FragmentGroupSelectViewAbController>(
        groupListWidgetController: fragmentGroupSelectViewAbController,
        leftActionBuilder: (c, abw) => Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // Icon(Icons.circle, size: 5),
          ],
        ),
        groupChainStrings: (group, abw) => group(abw).getDynamicGroupEntity(abw)!.title,
        headSliver: (c, g, abw) => Container(),
        groupBuilder: (c, group, abw) => Container(),
        unitBuilder: (c, unit, abw) => Container(),
        floatingButtonOnPressed: (c) {},
      ),
      floatingActionButton: ElevatedButton(
        child: Text("选择当前位置"),
        onPressed: () {
          Navigator.pop<(FragmentGroup?, void)>(context, (fragmentGroupSelectViewAbController.getCurrentGroupAb()().getDynamicGroupEntity(), null));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
