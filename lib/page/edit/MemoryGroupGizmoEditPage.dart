import 'package:aaa/tool/annotation.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPageAbController.dart';
import 'package:aaa/page/edit/EditPageType.dart';
import 'package:aaa/page/select/MemoryModelSelectPage.dart';
import 'package:tools/tools.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/sheetroute/DefaultSheetRoute.dart';
import 'package:aaa/tool/widget_wrapper/FloatingRoundCornerButton.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemoryGroupGizmoEditPage extends StatelessWidget {
  const MemoryGroupGizmoEditPage({Key? key, required this.editPageType, required this.memoryGroupGizmo}) : super(key: key);

  final Ab<MemoryGroup>? memoryGroupGizmo;
  final MemoryGroupGizmoEditPageType editPageType;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      putController: MemoryGroupGizmoEditPageAbController(editPageType: editPageType, memoryGroupGizmo: memoryGroupGizmo),
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
              children: _children(),
            ),
          ),
          floatingActionButton: _floatingActionButton(),
          floatingActionButtonLocation: FloatingRoundCornerButtonLocation(context: context, offset: const Offset(0, -50)),
        );
      },
    );
  }

  @Filter()
  List<Widget> _children() {
    return filter(
      from: editPageType,
      targets: {
        [MemoryGroupGizmoEditPageType.initCheck]: () => [
              _titleWidget(),
              _memoryModelWidget(),
              _showTypeWidget(),
              _selectFragmentWidget(),
            ],
        [MemoryGroupGizmoEditPageType.modifyOtherCheck]: () => [
              _newLearnCountWidget(),
              _reviewIntervalWidget(),
              _filterOutWidget(),
            ],
      },
      orElse: null,
    );
  }

  @Filter()
  Widget _floatingActionButton() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return filter(
          from: c.editPageType,
          targets: {
            [MemoryGroupGizmoEditPageType.modifyOtherCheck]: () => FloatingRoundCornerButton(
                  text: '应用并开始',
                  onPressed: () async {
                    await c.commitModifyModifyOtherCheck();
                  },
                ),
          },
          orElse: () => Container(),
        );
      },
    );
  }

  @Filter()
  Widget _appBarTitleWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return Text(
          filter(
            from: c.editPageType,
            targets: {
              [MemoryGroupGizmoEditPageType.initCheck]: () => '初始化记忆组：',
              [MemoryGroupGizmoEditPageType.modifyOtherCheck]: () => '当前周期：',
            },
            orElse: () => 'unknown',
          ),
        );
      },
    );
  }

  /// 叉号
  Widget _crossWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.red),
          onPressed: () {
            c.cancel();
          },
        );
      },
    );
  }

  /// 对号
  @Filter()
  Widget _tickWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return filter(
          from: editPageType,
          targets: {
            [MemoryGroupGizmoEditPageType.initCheck]: () => IconButton(
                  icon: const FaIcon(FontAwesomeIcons.check, color: Colors.green),
                  onPressed: () {
                    c.commitModifyInitCheck();
                  },
                ),
          },
          orElse: () => Container(),
        );
      },
    );
  }

  Widget _titleWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return Row(
          children: [
            const Text('名称：', style: TextStyle(fontSize: 16)),
            Expanded(
              child: TextField(
                controller: c.titleTextEditingController,
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
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return Row(
          children: [
            const Text('记忆模型：', style: TextStyle(fontSize: 16)),
            TextButton(
              child: AbBuilder<MemoryGroupGizmoEditPageAbController>(
                builder: (gzC, gzAbw) {
                  return Text(gzC.selectedMemoryModel(gzAbw)?.title ?? '点击选择');
                },
              ),
              onPressed: () {
                Navigator.push(c.context, MaterialPageRoute(builder: (_) => const MemoryModelSelectPage()));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showTypeWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
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
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return Row(
          children: [
            const Text('已选碎片：', style: TextStyle(fontSize: 16)),
            TextButton(
              child: Text('点击查看（共 ${c.selectedFragments(abw).length} 个）', style: const TextStyle(fontSize: 16)),
              onPressed: () {
                Navigator.of(c.context).push(
                  DefaultSheetRoute(
                    bodySliver0: () {
                      return SliverToBoxAdapter(
                        child: AbBuilder<MemoryGroupGizmoEditPageAbController>(
                          builder: (sController, sAbw) {
                            return Material(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ...(sController.selectedFragments(sAbw).isEmpty
                                          ? [Container()]
                                          : sController.selectedFragments(sAbw).map(
                                                (e) => Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 200,
                                                      child: Text(e(abw).title.toString()),
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

  Widget _newLearnCountWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return Row(
          children: [
            const Text('新学数量：'),
            Expanded(
              child: AbStatefulBuilder(
                // 保留上一次的设置
                initExtra: {'value': c.newLearnCount(abw).toDouble()},
                builder: (Map<String, Object?> extra, BuildContext context, void Function() refresh) {
                  double dynValue = extra['value'] as double;
                  // 不能超过最大值
                  if (dynValue > c.notLearnCount()) {
                    extra['value'] = c.notLearnCount();
                    dynValue = extra['value'] as double;
                  }
                  // 如果没有 space，则 0/300，其中 0 字符长度会动态的变宽成 10 或 100，从而导致刷新的时候滑块抖动。
                  // space 意味着将 0 前面添加两个 0，即 000/300。
                  int space = c.notLearnCount().toString().length - dynValue.toInt().toString().length;
                  return Row(
                    children: [
                      Expanded(
                        child: Slider(
                          label: dynValue.toInt().toString(),
                          min: 0,
                          max: c.notLearnCount().toDouble(),
                          value: dynValue,
                          divisions: c.notLearnCount(),
                          onChanged: (n) {
                            extra['value'] = n;
                            refresh();
                          },
                          onChangeEnd: (n) {
                            c.newLearnCount.refreshEasy((oldValue) => n.floor());
                          },
                        ),
                      ),
                      Text('${'0' * space}${dynValue.toInt()}/${c.notLearnCount()}')
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _reviewIntervalWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return AbStatefulBuilder(
          initExtra: {
            'tec': TextEditingController(text: (c.reviewInterval(abw).difference(DateTime.now()).inMinutes.toString())),
          },
          onDispose: (extra, ctx, refresh) {
            (extra['tec'] as TextEditingController).dispose();
          },
          builder: (extra, context, refresh) {
            final tec = extra['tec'] as TextEditingController;

            return Row(
              children: [
                const Text('复习区间：  '),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(counter: Container()),
                              maxLength: 9,
                              controller: tec,
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                if (v.trim() == '') {
                                  c.reviewInterval.refreshEasy((oldValue) => DateTime.now());
                                  return;
                                }
                                final tryInt = int.tryParse(v);
                                c.reviewInterval.refreshEasy(
                                  (oldValue) =>
                                      tryInt == null ? DateTime.fromMillisecondsSinceEpoch(-1) : DateTime.now().add(Duration(minutes: tryInt)),
                                );
                              },
                            ),
                          ),
                          const Text('  分钟内  '),
                        ],
                      ),
                      Row(
                        children: [
                          Text(() {
                            final time = c.reviewInterval(abw);
                            return '${time.year}年${time.month}月${time.day}日${time.hour}时前';
                          }()),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _filterOutWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return AbStatefulBuilder(
          initExtra: {'tec': TextEditingController(text: c.filterOut())},
          onDispose: (extra, ctx, refresh) {
            (extra['tec'] as TextEditingController).dispose();
          },
          builder: (extra, context, refresh) {
            final tec = extra['tec'] as TextEditingController;

            return Row(
              children: [
                const Text('过滤碎片：  '),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: tec,
                              onChanged: (v) {
                                c.filterOut.refreshEasy((oldValue) => v);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
