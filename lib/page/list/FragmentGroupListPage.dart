import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/single_dialog/showAddFragmentToMemoryGroupDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

import 'FragmentGroupListPageController.dart';

class FragmentGroupListPage extends StatelessWidget {
  const FragmentGroupListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupListWidget<FragmentGroup, Fragment, FragmentGroupListPageController>(
      groupListWidgetController: FragmentGroupListPageController(),
      groupChainStrings: (group, abw) => group(abw).entity(abw)?.title ?? '不存在实体！',
      groupBuilder: (c, group, abw) {
        return Row(
          children: [
            Expanded(
              child: TextButton(
                child: Text(group(abw).entity()!.title),
                onPressed: () async {
                  await c.enterGroup(group);
                },
                onLongPress: () async {
                  c.isUnitSelecting.refreshEasy((oldValue) => !oldValue);
                  Aber.find<HomeAbController>().isShowFloating.refreshEasy((oldValue) => !oldValue);
                },
              ),
            ),
            c.isUnitSelecting(abw) ? Text('${group(abw).selectedUnitCount(abw)}/${group(abw).allUnitCount(abw)}') : Container(),
            c.isUnitSelecting(abw)
                ? IconButton(
                    icon: () {
                      if (group(abw).entity(abw)!.local_isSelected) {
                        return const SolidCircleIcon();
                      } else {
                        if (group(abw).selectedUnitCount(abw) == 0) {
                          return const SolidCircleGreyIcon();
                        } else {
                          return const CircleHalfStrokeIcon();
                        }
                      }
                    }(),
                    onPressed: () async {
                      await c.resetFragmentGroupAndSubIsSelected(
                        fragmentGroupAb: group().entity,
                        isSelected: !group().entity()!.local_isSelected,
                      );
                    },
                  )
                : Container(),
          ],
        );
      },
      unitBuilder: (c, unit, abw) {
        return Row(
          children: [
            Expanded(
              child: MaterialButton(
                child: Text(unit(abw).unitEntity().content),
                onPressed: () {},
                onLongPress: () {
                  c.isUnitSelecting.refreshEasy((oldValue) => !oldValue);
                  Aber.find<HomeAbController>().isShowFloating.refreshEasy((oldValue) => !oldValue);
                },
              ),
            ),
            c.isUnitSelecting(abw)
                ? IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.solidCircle,
                      color: unit(abw).unitEntity(abw).local_isSelected ? Colors.amber : Colors.grey,
                      size: 14,
                    ),
                    onPressed: () async {
                      await c.resetFragmentIsSelected(
                        fragmentAb: unit().unitEntity,
                        isSelected: !unit().unitEntity().local_isSelected,
                      );
                    },
                  )
                : Container(),
          ],
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
      floatingButtonOnPressed: (c) {
        showAddFragmentToMemoryGroupDialog();
      },
    );
  }
}
