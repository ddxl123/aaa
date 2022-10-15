import 'package:aaa/page/edit/MemoryModelGizmoEditPageAbController.dart';
import 'package:aaa/page/stage/InAppStage.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPageAbController.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:aaa/page/select/MemoryModelSelectPage.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';
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
          appBar: _appBar(),
          body: _body(),
          floatingActionButton: _floatingActionButton(),
          floatingActionButtonLocation: FloatingRoundCornerButtonLocation(context: context, offset: const Offset(0, -30)),
        );
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white12,
      leading: _appBarLeadingWidget(),
      title: _appBarTitleWidget(),
      actions: [_appBarRightButtonWidget()],
    );
  }

  Widget _body() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(builder: (c, abw) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(
            child: Theme(
              data: Theme.of(c.context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                maintainState: true,
                title: AbwBuilder(
                  builder: (abw) {
                    return Text(
                      '基础配置：',
                      style: TextStyle(color: c.isBasicConfigRedErr(abw) ? Colors.red : null),
                    );
                  },
                ),
                children: [
                  _titleWidget(),
                  _memoryModelWidget(),
                  _selectFragmentWidget(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Theme(
              data: Theme.of(c.context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                maintainState: true,
                initiallyExpanded: true,
                title: AbwBuilder(
                  builder: (abw) {
                    return Text(
                      '当前周期：',
                      style: TextStyle(color: c.isCurrentCycleRedErr(abw) ? Colors.red : null),
                    );
                  },
                ),
                children: [
                  _newLearnCountWidget(),
                  _reviewIntervalWidget(),
                  _filterOutWidget(),
                  _newReviewDisplayOrder(),
                  _newDisplayOrder(),
                  _showModeWidget(),
                  floatingRoundCornerButtonPlaceholderBox(),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _floatingActionButton() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return FloatingRoundCornerButton(
          text: '应用并开始',
          onPressed: () {
            c.applyAndStart();
          },
        );
      },
    );
  }

  Widget _appBarTitleWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return Text(c.title(abw));
      },
    );
  }

  /// 叉号
  Widget _appBarLeadingWidget() {
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
  Widget _appBarRightButtonWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return Row(
          children: [
            TextButton(
              child: const Text('分析'),
              onPressed: () {
                c.analyze();
              },
            ),
            TextButton(
              child: const Text('保存'),
              onPressed: () {
                c.save();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _titleWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: c.title,
          child: Row(
            children: [
              const Text('名称：', style: TextStyle(fontSize: 16)),
              Expanded(
                child: TextField(
                  controller: c.titleTextEditingController,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: '请输入...'),
                  onChanged: (v) {
                    c.title.refreshEasy((oldValue) => v);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _memoryModelWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: c.selectedMemoryModel,
          child: Row(
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
          ),
        );
      },
    );
  }

  Widget _showModeWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: null,
          child: Row(
            children: [
              const Text('展示类型：', style: TextStyle(fontSize: 16)),
              dropdownButton2<MemoryGroupType>(
                value: c.type(abw),
                item: [
                  Tuple2(t1: '仅应用内', t2: MemoryGroupType.inApp),
                  Tuple2(t1: '全部悬浮', t2: MemoryGroupType.allFloating),
                ],
                onChanged: (v) {
                  c.type.refreshEasy((oldValue) => v!);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _selectFragmentWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: null,
          child: Row(
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
          ),
        );
      },
    );
  }

  Widget _newLearnCountWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: null,
          child: Row(
            children: [
              const Text('新学数量：'),
              Expanded(
                child: AbStatefulBuilder(
                  // 保留上一次的设置
                  initExtra: {'value': c.willNewLearnCount(abw).toDouble()},
                  builder: (Map<String, Object?> extra, BuildContext context, void Function() refresh) {
                    double dynValue = extra['value'] as double;
                    // 不能超过最大值
                    if (dynValue > c.remainNewFragmentsCount()) {
                      extra['value'] = c.remainNewFragmentsCount();
                      dynValue = extra['value'] as double;
                    }
                    // 如果没有 space，则 0/300，其中 0 字符长度会动态的变宽成 10 或 100，从而导致刷新的时候滑块抖动。
                    // space 意味着将 0 前面添加两个 0，即 000/300。
                    int space = c.remainNewFragmentsCount().toString().length - dynValue.toInt().toString().length;
                    return Row(
                      children: [
                        Expanded(
                          child: Slider(
                            label: dynValue.toInt().toString(),
                            min: 0,
                            max: c.remainNewFragmentsCount().toDouble(),
                            value: dynValue,
                            divisions: c.remainNewFragmentsCount(),
                            onChanged: (n) {
                              extra['value'] = n;
                              refresh();
                            },
                            onChangeEnd: (n) {
                              c.willNewLearnCount.refreshEasy((oldValue) => n.floor());
                            },
                          ),
                        ),
                        Text('${'0' * space}${dynValue.toInt()}/${c.remainNewFragmentsCount()}')
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _reviewIntervalWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: c.reviewInterval,
          child: Row(
            children: [
              const Text('复习区间：  '),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: c.reviewIntervalTextEditingController,
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              if (v.trim() == '') {
                                c.reviewInterval.refreshEasy((oldValue) => DateTime.now());
                                return;
                              }
                              final tryInt = int.tryParse(v);
                              c.reviewInterval.refreshEasy(
                                (oldValue) => tryInt == null ? DateTime.now() : DateTime.now().add(Duration(minutes: tryInt)),
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
          ),
        );
      },
    );
  }

  Widget _filterOutWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: null,
          child: AbStatefulBuilder(
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
          ),
        );
      },
    );
  }

  Widget _newReviewDisplayOrder() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: null,
          child: Row(
            children: [
              const Text('新 | 复习 碎片展示顺序：'),
              dropdownButton2<NewReviewDisplayOrder>(
                value: c.newReviewDisplayOrder(abw),
                item: [
                  Tuple2(t1: '混合', t2: NewReviewDisplayOrder.mix),
                  Tuple2(t1: '优先新碎片', t2: NewReviewDisplayOrder.newReview),
                  Tuple2(t1: '优先复习碎片', t2: NewReviewDisplayOrder.reviewNew),
                ],
                onChanged: (v) {
                  c.newReviewDisplayOrder.refreshEasy((oldValue) => v!);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _newDisplayOrder() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: null,
          child: Row(
            children: [
              const Text('新碎片 展示顺序：'),
              dropdownButton2<NewDisplayOrder>(
                value: c.newDisplayOrder(abw),
                item: [
                  Tuple2(t1: '随机', t2: NewDisplayOrder.random),
                  Tuple2(t1: '标题首字母A~Z顺序', t2: NewDisplayOrder.titleA2Z),
                  Tuple2(t1: '创建时间', t2: NewDisplayOrder.createEarly2Late),
                ],
                onChanged: (v) {
                  c.newDisplayOrder.refreshEasy((oldValue) => v!);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
