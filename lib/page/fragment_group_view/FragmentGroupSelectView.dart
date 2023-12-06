import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/page/fragment_group_view/FragmentGroupSelectViewAbController.dart';
import 'package:aaa/single_dialog/showCreateFragmentGroupDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

typedef SelectResult = Future<void> Function(
  FragmentGroup? selectedDynamicFragmentGroup,
  FragmentGroupSelectViewAbController controller,
);

class FragmentGroupSelectView extends StatefulWidget {
  const FragmentGroupSelectView({super.key, required this.selectResult});

  final SelectResult selectResult;

  @override
  State<FragmentGroupSelectView> createState() => _FragmentGroupSelectViewState();
}

class _FragmentGroupSelectViewState extends State<FragmentGroupSelectView> {
  final fragmentGroupSelectViewAbController = FragmentGroupSelectViewAbController(
    enterUserId: Aber.find<GlobalAbController>().loggedInUser()!.id,
    enterFragmentGroupId: null,
  );

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
          ],
        ),
        rightActionBuilder: (c, abw) {
          return CustomDropdownBodyButton(
            initValue: 0,
            primaryButton: IconButton(onPressed: null, icon: Icon(Icons.add, color: Colors.blue)),
            items: [
              CustomItem(value: 0, text: "添加碎片组"),
            ],
            onChanged: (v) {
              showCreateFragmentGroupDialog(dynamicGroupEntity: c.getCurrentGroupAb()().getDynamicGroupEntity());
            },
          );
        },
        groupChainStrings: (group, abw) => group(abw).getDynamicGroupEntity(abw)!.title,
        headSliver: (c, g, abw) => Container(),
        groupBuilder: (c, group, abw) {
          return Card(
            child: MaterialButton(
              child: Row(
                children: [
                  Expanded(
                    child: Text(group(abw).getDynamicGroupEntity()!.title),
                  ),
                ],
              ),
              onPressed: () {
                c.enterGroup(group);
              },
            ),
          );
        },
        unitBuilder: (c, unit, abw) {
          return Card(
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(unit(abw).unitEntity.title),
                  ),
                ],
              ),
            ),
          );
        },
        floatingButtonOnPressed: (c) {},
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.greenAccent)),
        child: Text("选择当前位置"),
        onPressed: () async {
          await widget.selectResult(
            fragmentGroupSelectViewAbController.getCurrentGroupAb()().getDynamicGroupEntity(),
            fragmentGroupSelectViewAbController,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
