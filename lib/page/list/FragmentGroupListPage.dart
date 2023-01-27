import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:aaa/single_dialog/showAddFragmentToMemoryGroupDialog.dart';
import 'package:aaa/single_dialog/showCreateFragmentGroupDialog.dart';
import 'package:aaa/single_dialog/showPrivatePublishDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tools/tools.dart';
import '../edit/FragmentGizmoEditPage.dart';
import 'FragmentGroupListPageController.dart';

class FragmentGroupListPage extends StatelessWidget {
  const FragmentGroupListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupListWidget<FragmentGroup, Fragment, FragmentGroupConfig, FragmentGroupListPageController>(
      groupListWidgetController: FragmentGroupListPageController(),
      groupChainStrings: (group, abw) => group(abw).entity(abw)?.title ?? '不存在实体！',
      headSliver: (c, g, abw) => SliverToBoxAdapter(
        child: g(abw).entity(abw) == null
            ? Container()
            : Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(g(abw).entity(abw)!.title+" 组属性", style: Theme.of(context).textTheme.titleLarge),
                        Spacer(),
                        // 公开/私密/发布
                        IconButton(
                          icon: AbwBuilder(
                            builder: (abw) {
                              final bePrivate = g(abw).config(abw)!.be_private;
                              final bePublish = g(abw).config(abw)!.be_publish;
                              final privateColor = bePrivate ? Colors.amber : Colors.green;
                              final publishColor = bePublish ? Colors.green : Colors.amber;
                              return Row(
                                children: [
                                  Text(bePrivate ? "已私密 " : "已公开 ", style: TextStyle(color: privateColor)),
                                  Icon(Icons.circle, size: 8, color: (!bePrivate && bePublish) ? Colors.green : Colors.grey),
                                  Text(bePublish ? " 已发布" : " 未发布", style: TextStyle(color: publishColor)),
                                ],
                              );
                            },
                          ),
                          onPressed: () {
                            showPrivatePublishDialog(fragmentGroupConfigAb: g().config);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
      groupBuilder: (c, group, abw) {
        return Card(
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Row(
                    children: [
                      Icon(LineIcons.book),
                      SizedBox(width: 20),
                      Expanded(child: Text(group(abw).entity()!.title)),
                    ],
                  ),
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
                        if (group(abw).entity(abw)!.client_be_selected) {
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
                          isSelected: !group().entity()!.client_be_selected,
                        );
                      },
                    )
                  : Container(),
            ],
          ),
        );
      },
      unitBuilder: (c, unit, abw) {
        return Card(
          elevation: 0,
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Row(children: [Expanded(child: Text(unit(abw).unitEntity().title))]),
                  onLongPress: () {
                    c.isUnitSelecting.refreshEasy((oldValue) => !oldValue);
                    Aber.find<HomeAbController>().isShowFloating.refreshEasy((oldValue) => !oldValue);
                  },
                  onPressed: () async {
                    await pushToFragmentEditPage(context: c.context, initSomeBefore: [], initSomeAfter: [], initFragmentAb: unit().unitEntity);
                  },
                ),
              ),
              c.isUnitSelecting(abw)
                  ? IconButton(
                      style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      icon: FaIcon(
                        FontAwesomeIcons.solidCircle,
                        color: unit(abw).unitEntity(abw).client_be_selected ? Colors.amber : Colors.grey,
                        size: 14,
                      ),
                      onPressed: () async {
                        await c.resetFragmentIsSelected(
                          fragmentAb: unit().unitEntity,
                          isSelected: !unit().unitEntity().client_be_selected,
                        );
                      },
                    )
                  : Container(),
            ],
          ),
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
            if (v == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => const FragmentGizmoEditPage(
                            initSomeBefore: [],
                            initSomeAfter: [],
                            initFragmentAb: null,
                          )));
            } else if (v == 1) {
              showCreateFragmentGroupDialog(fragmentGroup: c.getCurrentGroupAb()().entity());
            }
          },
        );
      },
      floatingButtonOnPressed: (c) {
        showAddFragmentToMemoryGroupDialog();
      },
    );
  }
}
