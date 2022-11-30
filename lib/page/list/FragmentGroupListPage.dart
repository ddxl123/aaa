import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

import 'FragmentGroupListPageController.dart';

class FragmentGroupListPage extends StatelessWidget {
  const FragmentGroupListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupListWidget<FragmentGroup, Fragment>(
      groupListWidgetController: FragmentGroupListPageController(),
      groupChainStrings: (group, abw) => group(abw).entity(abw)?.title ?? '不存在实体！',
      groupBuilder: (c, group, abw) {
        return TextButton(
          child: Text(group(abw).entity()!.title),
          onPressed: () async {
            await c.enterGroup(group);
          },
        );
      },
      unitBuilder: (c, unit, abw) {
        return MaterialButton(
          child: Text(unit(abw).unitEntity().content),
          onPressed: () {},
        );
      },
      oneActionBuilder: (c, abw) {
        return CustomDropdownBodyButton(
          initValue: 0,
          primaryButton: const Icon(Icons.more_horiz),
          itemAlignment: Alignment.centerLeft,
          items: [
            Item(value: 0, text: '添加碎片'),
            Item(value: 1, text: '添加碎片组'),
          ],
          onChanged: (v) {
            // if (v == 0) {
            //   Navigator.push(context, MaterialPageRoute(builder: (ctx) => const FragmentGizmoEditPage()));
            // } else if (v == 1) {
            //   Navigator.push(context, MaterialPageRoute(builder: (ctx) => const FragmentGroupGizmoEditPage()));
            // }
          },
        );
      },
    );
  }
}
