import 'package:drift_main/DriftDb.dart';
import 'package:aaa/page/create/MemoryGroupGizmoConfigPageAbController.dart';
import 'package:aaa/page/create/CreateOrModifyType.dart';
import 'package:aaa/page/transition/MemoryModelChoosePage.dart';
import 'package:tools/tools.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/sheetroute/DefaultSheetRoute.dart';
import 'package:aaa/tool/widget_wrapper/FloatingRoundCornerButton.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemoryGroupGizmoConfigPage extends StatelessWidget {
  const MemoryGroupGizmoConfigPage({Key? key, required this.configPageType, required this.memoryGroupGizmo}) : super(key: key);

  /// 当 [configPageType] 为 [ConfigPageType.create] 或 [ConfigPageType.createCheck] 时，[memoryGroupGizmo] 为 null。
  final Ab<MemoryGroup>? memoryGroupGizmo;
  final ConfigPageType configPageType;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryGroupGizmoConfigPageAbController>(
      putController: MemoryGroupGizmoConfigPageAbController(configPageType: configPageType, memoryGroupGizmo: memoryGroupGizmo),
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white12,
            leading: _crossWidget(),
            title: _appBarTitleWidget(),
            actions: [_tickWidget()],
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _titleWidget(),
                _memoryModelWidget(),
                _showTypeWidget(),
                _selectFragmentWidget(),
              ],
            ),
          ),
          floatingActionButton: _floatingActionButton(),
          floatingActionButtonLocation: FloatingRoundCornerButtonLocation(context: context, offset: const Offset(0, -50)),
        );
      },
    );
  }

  Widget _floatingActionButton() {
    return AbBuilder<MemoryGroupGizmoConfigPageAbController>(
      builder: (c, abw) {
        return Helper.filter(
          from: c.configPageType,
          targets: {
            [ConfigPageType.modifyCheck]: () => FloatingRoundCornerButton(
                  text: '保存并开始',
                  onPressed: () {},
                ),
          },
          orElse: () => Container(),
        );
      },
    );
  }

  Widget _appBarTitleWidget() {
    return AbBuilder<MemoryGroupGizmoConfigPageAbController>(
      builder: (c, abw) {
        return Text(
          Helper.filter(
            from: c.configPageType,
            targets: {
              [ConfigPageType.create]: () => '创建记忆组',
              [ConfigPageType.modifyCheck]: () => '检查记忆组配置',
            },
            orElse: () => 'unknown',
          ),
        );
      },
    );
  }

  Widget _crossWidget() {
    return AbBuilder<MemoryGroupGizmoConfigPageAbController>(
      builder: (c, abw) {
        return IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
          onPressed: () {
            c.cancel();
          },
        );
      },
    );
  }

  Widget _tickWidget() {
    return AbBuilder<MemoryGroupGizmoConfigPageAbController>(
      builder: (c, abw) {
        return Helper.filter(
          from: configPageType,
          targets: {
            [ConfigPageType.create]: () => IconButton(
                  icon: const FaIcon(FontAwesomeIcons.check, color: Colors.green),
                  onPressed: () {
                    c.create();
                  },
                ),
            [ConfigPageType.modifyCheck]: () => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: TextButton(
                    child: const Text('仅保存'),
                    onPressed: () {
                      c.commitForModify();
                    },
                  ),
                ),
          },
          orElse: () => Container(),
        );
      },
    );
  }

  Widget _titleWidget() {
    return AbBuilder<MemoryGroupGizmoConfigPageAbController>(
      builder: (c, abw) {
        return Row(
          children: [
            const Text('名称：', style: TextStyle(fontSize: 16)),
            Expanded(
              child: TextField(
                minLines: null,
                maxLines: null,
                autofocus: true,
                decoration: const InputDecoration(border: InputBorder.none, hintText: '请输入...'),
                onChanged: (text) {
                  c.title.refreshEasy((oldValue) => text);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _memoryModelWidget() {
    return AbBuilder<MemoryGroupGizmoConfigPageAbController>(
      builder: (c, abw) {
        return Row(
          children: [
            const Text('记忆模型：', style: TextStyle(fontSize: 16)),
            TextButton(
              child: AbBuilder<MemoryGroupGizmoConfigPageAbController>(
                builder: (gzC, gzAbw) {
                  return Text(gzC.selectedMemoryModel(gzAbw)?.title ?? '点击选择');
                },
              ),
              onPressed: () {
                Navigator.push(c.context, MaterialPageRoute(builder: (_) => const MemoryModelChoosePage()));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showTypeWidget() {
    return AbBuilder<MemoryGroupGizmoConfigPageAbController>(
      builder: (c, abw) {
        return Row(
          children: [
            const Text('展示类型：', style: TextStyle(fontSize: 16)),
            DropdownButton2<MemoryGroupType>(
              value: c.type(abw),
              customItemsIndexes: const [1, 3, 5],
              customItemsHeight: 10,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              items: const [
                DropdownMenuItem(
                  child: Text('  应用内          '),
                  value: MemoryGroupType.inApp,
                ),
                DropdownMenuItem(
                  enabled: false,
                  child: Divider(),
                ),
                DropdownMenuItem(
                  child: Text('  全部悬浮'),
                  value: MemoryGroupType.allFloating,
                ),
                DropdownMenuItem(
                  enabled: false,
                  child: Divider(),
                ),
                DropdownMenuItem(
                  child: Text('  跟随模型'),
                  value: MemoryGroupType.followModel,
                ),
              ],
              onChanged: (value) {
                c.type.refreshEasy((oldValue) => value!);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _selectFragmentWidget() {
    return AbBuilder<MemoryGroupGizmoConfigPageAbController>(
      builder: (c, abw) {
        return Row(
          children: [
            const Text('已选碎片：', style: TextStyle(fontSize: 16)),
            TextButton(
              child: Text('点击查看（共 ${c.fragments(abw).length} 个）', style: const TextStyle(fontSize: 16)),
              onPressed: () {
                Navigator.of(c.context).push(
                  DefaultSheetRoute(
                    bodySliver0: () {
                      return SliverToBoxAdapter(
                        child: AbBuilder<MemoryGroupGizmoConfigPageAbController>(
                          builder: (sController, sAbw) {
                            return Material(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ...(sController.fragments(sAbw).isEmpty
                                          ? [Container()]
                                          : sController.fragments(sAbw).map(
                                                (e) => Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 200,
                                                      child: Text(e.title.toString()),
                                                    )
                                                  ],
                                                ),
                                              )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
