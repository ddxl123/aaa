import 'dart:convert';

import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:aaa/single_dialog/showAddFragmentToMemoryGroupDialog.dart';
import 'package:aaa/single_dialog/showCreateFragmentGroupDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';
import '../../single_dialog/showFragmentGroupConfigDialog.dart';
import 'FragmentGroupListPageController.dart';

class FragmentGroupListPage extends StatelessWidget {
  const FragmentGroupListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GroupListWidget<FragmentGroup, Fragment, FragmentGroupListPageController>(
        groupListWidgetController: FragmentGroupListPageController(),
        groupChainStrings: (group, abw) => group(abw).entity(abw)!.title,
        headSliver: (c, g, abw) => g(abw).entity(abw) == null ? Container() : _Head(c: c, g: g, abw: abw),
        groupBuilder: (c, group, abw) {
          return Card(
            elevation: 0,
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    visualDensity: kMinVisualDensity,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(c.isSelfOfFragmentGroup(fg: group().entity()!) ? 20 : 10, 15, 10, 15),
                      child: Row(
                        children: [
                          c.isSelfOfFragmentGroup(fg: group().entity()!)
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: Transform.scale(
                                    scaleY: -1,
                                    child: Icon(Icons.turn_slight_right, color: Colors.green),
                                  ),
                                ),
                          Expanded(
                            child: Text(
                              group(abw).entity()!.title,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.chevron_right, color: group().entity()!.be_publish ? Colors.green : Colors.grey),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      await c.enterGroup(group);
                    },
                    onLongPress: () async {
                      await c.clearAllSelected();
                      c.isSelecting.refreshEasy((oldValue) => !oldValue);
                      if (c.isSelecting()) {
                        c.longPressedTarget.refreshEasy((oldValue) => group().entity()!);
                      } else {
                        c.longPressedTarget.refreshEasy((oldValue) => null);
                      }
                      Aber.find<HomeAbController>().isShowFloating.refreshEasy((oldValue) => !oldValue);
                    },
                  ),
                ),
                c.longPressedTarget(abw) == group().entity()!
                    ? MaterialButton(
                        visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity),
                        child: Text("编辑", style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          pushToFragmentGroupGizmoEditPage(context: context, fragmentGroupAb: group().entity);
                        },
                      )
                    : Container(),
                c.isSelecting(abw) ? Text('${group(abw).selectedUnitCount(abw)}/${group(abw).allUnitCount(abw)}') : Container(),
                c.isSelecting(abw)
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
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: kMinVisualDensity,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      // decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.amber, width: 10))),
                      child: Row(
                        children: [
                          Icon(Icons.brightness_1_outlined, size: 12, color: Colors.green),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              unit(abw).unitEntity().title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onLongPress: () async {
                      await c.clearAllSelected();
                      c.isSelecting.refreshEasy((oldValue) => !oldValue);
                      Aber.find<HomeAbController>().isShowFloating.refreshEasy((oldValue) => !oldValue);
                    },
                    onPressed: () async {
                      await pushToMultiFragmentTemplateView(
                        context: context,
                        allFragments: c.getCurrentGroupAb()().units().map((e) => e().unitEntity()).toList(),
                        fragment: unit().unitEntity(),
                      );
                    },
                  ),
                ),
                c.isSelecting(abw)
                    ? IconButton(
                        style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
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
        rightActionBuilder: (c, abw) {
          return Row(
            children: [
              CustomDropdownBodyButton(
                initValue: 0,
                primaryButton: SizedBox(
                  width: kMinInteractiveDimension,
                  height: kMinInteractiveDimension,
                  child: const Icon(Icons.add),
                ),
                itemAlignment: Alignment.centerLeft,
                items: [
                  Item(value: 0, text: '添加碎片'),
                  Item(value: 1, text: '添加碎片组'),
                ],
                onChanged: (v) async {
                  if (v == 0) {
                    final result = await pushToTemplateChoice(context: context);
                    if (result != null) {
                      await pushToFragmentTemplateEditView(
                        context: context,
                        initFragmentAb: null,
                        initFragmentTemplate: result,
                        initSomeBefore: [],
                        initSomeAfter: [],
                        initFragmentGroupChain: c.getCurrentFragmentGroupChain(),
                        isEditableAb: true.ab,
                        isTailNew: true,
                      );
                    }
                  } else if (v == 1) {
                    showCreateFragmentGroupDialog(fragmentGroup: c.getCurrentGroupAb()().entity());
                  }
                },
              ),
            ],
          );
        },
        floatingButtonOnPressed: (c) {
          showAddFragmentToMemoryGroupDialog();
        },
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return AbBuilder<FragmentGroupListPageController>(
      tag: Aber.single,
      builder: (c, abw) {
        if (c.isSelecting(abw)) {
          Widget button({
            required IconData iconData,
            required String label,
            required Function() onPressed,
            Color? color,
          }) {
            return MaterialButton(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              onPressed: onPressed,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(iconData, size: 26, color: color),
                  Text(label, style: TextStyle(fontSize: 12, color: color)),
                ],
              ),
            );
          }

          return Card(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
              child: Row(
                children: [
                  button(
                    iconData: Icons.close,
                    label: "关闭",
                    color: Colors.orange,
                    onPressed: () {
                      c.isSelecting.refreshEasy((oldValue) => false);
                      Aber.find<HomeAbController>().isShowFloating.refreshEasy((oldValue) => true);
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          button(
                            iconData: Icons.select_all_outlined,
                            label: '全选',
                            onPressed: () async {
                              await c.selectAll();
                            },
                          ),
                          button(
                            iconData: Icons.deselect_outlined,
                            label: '全不选',
                            onPressed: () async {
                              await c.deselectAll();
                            },
                          ),
                          button(
                            iconData: Icons.exposure_outlined,
                            label: '反选',
                            onPressed: () async {
                              await c.invertSelect();
                            },
                          ),
                          button(
                            iconData: Icons.border_clear,
                            label: '清空选择',
                            onPressed: () async {
                              await c.clearAllSelected();
                            },
                          ),
                          button(
                            iconData: Icons.exit_to_app,
                            label: '移动',
                            onPressed: () async {
                              await c.moveSelected();
                            },
                          ),
                          // TODO: 批量克隆
                          // button(
                          //   iconData: FontAwesomeIcons.paste,
                          //   label: '克隆',
                          //   onPressed: () async {
                          //     // await c.cloneSelected();
                          //   },
                          // ),
                          button(
                            iconData: FontAwesomeIcons.clone,
                            label: '复用',
                            onPressed: () async {
                              await c.reuseSelected();
                            },
                          ),
                          button(
                            iconData: Icons.delete_forever,
                            label: '删除',
                            color: Colors.red,
                            onPressed: () async {
                              await c.deleteSelected();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _Head extends StatelessWidget {
  const _Head({super.key, required this.abw, required this.c, required this.g});

  final FragmentGroupListPageController c;
  final Ab<Group<FragmentGroup, Fragment>> g;
  final Abw abw;

  bool hasFatherFragmentGroupBePublish() {
    final result = c.getCurrentFragmentGroupChain().where((element) => element.id != g().entity()!.id && element.be_publish);
    return result.isNotEmpty;
  }

  Widget publishWidget({required String text, required Color color}) {
    return Row(
      children: [
        Icon(Icons.settings, color: color, size: 20),
        SizedBox(width: 5),
        Text(text, style: TextStyle(color: color)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bePublish = g(abw).entity(abw)!.be_publish;

    final small = Row(
      children: [
        Spacer(),
        Card(
          child: MaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: kMinVisualDensity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: hasFatherFragmentGroupBePublish() ? publishWidget(text: "已随父组发布", color: Colors.green) : publishWidget(text: "未发布", color: Colors.amber),
            ),
            onPressed: () async {
              await showFragmentGroupConfigDialog(c: c, currentFragmentGroupAb: g().entity);
            },
          ),
        ),
      ],
    );
    final big = Card(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          children: [
            c.isSelfOfFragmentGroup(fg: g(abw).entity(abw)!)
                ? Row(
                    children: [
                      Spacer(),
                      Card(
                        child: MaterialButton(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: kMinVisualDensity,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: publishWidget(text: hasFatherFragmentGroupBePublish() ? "已随父组发布 · 并单独发布" : "已发布", color: Colors.green),
                          ),
                          onPressed: () async {
                            await showFragmentGroupConfigDialog(c: c, currentFragmentGroupAb: g().entity);
                          },
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Spacer(),
                      TextButton(
                        child: Text("查看源"),
                        onPressed: () {},
                      ),
                    ],
                  ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 90, height: 130, color: Colors.grey),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  g(abw).entity(abw)!.title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          c.currentFragmentGroupTagsAb(abw).isEmpty
                              ? Container()
                              : Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    ...c.currentFragmentGroupTagsAb(abw).map(
                                      (e) {
                                        return Container(
                                          padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey),
                                          ),
                                          child: Text(e.tag, style: TextStyle(color: Colors.grey, fontSize: 14)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  () {
                                    final text = q.Document.fromJson(jsonDecode(g(abw).entity(abw)!.profile)).toPlainText().trim();
                                    return text.isEmpty ? "无简介" : text;
                                  }(),
                                  style: TextStyle(color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return bePublish ? big : small;
  }
}
