import 'dart:convert';

import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/page/edit/FragmentGroupGizmoEditPage.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:aaa/single_dialog/showAddFragmentToMemoryGroupDialog.dart';
import 'package:aaa/single_dialog/showCreateFragmentGroupDialog.dart';
import 'package:aaa/single_dialog/showPrivatePublishDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tools/tools.dart';
import 'FragmentGroupListPageController.dart';

class FragmentGroupListPage extends StatelessWidget {
  const FragmentGroupListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupListWidget<FragmentGroup, Fragment, FragmentGroupListPageController>(
      groupListWidgetController: FragmentGroupListPageController(),
      groupChainStrings: (group, abw) => group(abw).entity(abw)?.title ?? '不存在实体！',
      headSliver: (c, g, abw) => SliverToBoxAdapter(
        child: g(abw).entity(abw) == null
            ? Container()
            : Card(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                color: Colors.greenAccent,
                elevation: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    Icon(LineIcons.book, size: 34),
                                    Text(g(abw).entity(abw)!.title, style: Theme.of(context).textTheme.titleLarge),
                                  ],
                                ),
                              ),
                              // 公开/私密/发布
                              IconButton(
                                icon: AbwBuilder(
                                  builder: (abw) {
                                    final bePrivate = g(abw).entity(abw)!.be_private;
                                    final bePublish = g(abw).entity(abw)!.be_publish;
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
                                  showPrivatePublishDialog(currentFragmentGroupAb: g().entity);
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    () {
                                      final text = q.Document.fromJson(jsonDecode(g(abw).entity(abw)!.profile)).toPlainText().trim();
                                      return text.isEmpty ? "无简介" : text;
                                    }(),
                                    style: TextStyle(color: Colors.grey),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          c.fragmentGroupTagsAb(abw).isEmpty ? Container() : SizedBox(height: 10),
                          c.fragmentGroupTagsAb(abw).isEmpty
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          c.fragmentGroupTagsAb().map((e) => "#${e.tag}").join("  "),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                child: Text("发布数据"),
                                onPressed: () {},
                              ),
                              SizedBox(height: 15, child: VerticalDivider(color: Colors.grey)),
                              TextButton(
                                child: Text("编辑"),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => FragmentGroupGizmoEditPage(fragmentGroupAb: g(abw).entity)),
                                  );
                                },
                              ),
                              SizedBox(height: 15, child: VerticalDivider(color: Colors.grey)),
                              TextButton(
                                child: Text("查看详情"),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
      groupBuilder: (c, group, abw) {
        return Card(
          elevation: 0,
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
                      Expanded(child: Text(group(abw).entity()!.title, style: TextStyle(color: Colors.black))),
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          unit(abw).unitEntity().title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  onLongPress: () {
                    c.isUnitSelecting.refreshEasy((oldValue) => !oldValue);
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
              c.isUnitSelecting(abw)
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
      oneActionBuilder: (c, abw) {
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
    );
  }
}
