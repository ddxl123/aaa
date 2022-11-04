import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

import 'MemoryGroupGizmoEditPageAbController.dart';

class CurrentCircleWidget extends StatelessWidget {
  const CurrentCircleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return SliverToBoxAdapter(
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
                _newReviewDisplayOrder(),
                _newDisplayOrder(),
                _filterOutWidget(),
                _floatingWindowWidget(),
                floatingRoundCornerButtonPlaceholderBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _floatingWindowWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: null,
          child: Column(
            children: [
              Row(
                children: [
                  const Text('是否启用悬浮窗：', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  Switch(
                    value: c.cIsEnableFloatingAlgorithm.abObj(abw),
                    onChanged: (v) {
                      c.cIsEnableFloatingAlgorithm.abObj.refreshEasy((oldValue) => v);
                    },
                  ),
                ],
              ),
              c.cIsEnableFloatingAlgorithm.abObj(abw)
                  ? Row(
                      children: [
                        c.cIsFloatingAlgorithmFollowMemoryModel.abObj(abw) ? const Text('当前算法跟随记忆模型') : const Text('当前算法使用自定义'),
                        const Spacer(),
                        TextButton(
                          child: c.cIsFloatingAlgorithmFollowMemoryModel.abObj(abw) ? const Text('跟随记忆模型') : const Text('切换为自定义'),
                          onPressed: () {
                            c.cIsFloatingAlgorithmFollowMemoryModel.abObj.refreshEasy((oldValue) => !oldValue);
                          },
                        ),
                      ],
                    )
                  : Container(),
              c.cIsEnableFloatingAlgorithm.abObj(abw) && c.cIsFloatingAlgorithmFollowMemoryModel.abObj(abw)
                  ? Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: c.ccFloatingAlgorithmTextEditingController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 3,
                            decoration: const InputDecoration(hintText: '请写入算法...'),
                            onChanged: (v) {
                              c.cFloatingAlgorithm.abObj.refreshEasy((oldValue) => v);
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
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
                child: StfBuilder1<int>(
                  // 保留上一次的设置
                  initValue: c.cWillNewLearnCount.abObj(abw),
                  builder: (int value, BuildContext context, ResetValue<int> resetValue) {
                    int finallyValue = value;
                    // 不能超过最大值
                    if (finallyValue > c.remainNewFragmentsCount()) {
                      resetValue(c.remainNewFragmentsCount(), true);
                      return Container();
                    }
                    // 如果没有 space，则 0/300，其中 0 字符长度会动态的变宽成 10 或 100，从而导致刷新的时候滑块抖动。
                    // space 意味着将 0 前面添加两个 0，即 000/300。
                    int space = c.remainNewFragmentsCount().toString().length - finallyValue.toInt().toString().length;
                    return Row(
                      children: [
                        Expanded(
                          child: Slider(
                            label: finallyValue.toInt().toString(),
                            min: 0,
                            max: c.remainNewFragmentsCount().toDouble(),
                            value: finallyValue.toDouble(),
                            divisions: c.remainNewFragmentsCount() == 0 ? null : c.remainNewFragmentsCount(),
                            onChanged: (n) {
                              resetValue(n.toInt(), true);
                            },
                            onChangeEnd: (n) {
                              c.cWillNewLearnCount.abObj.refreshEasy((oldValue) => n.floor());
                            },
                          ),
                        ),
                        Text('${'0' * space}${finallyValue.toInt()}/${c.remainNewFragmentsCount()}')
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
          verifyAb: c.cReviewInterval.abObj,
          child: Row(
            children: [
              const Text('复习区间：  '),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('接下来  '),
                        Expanded(
                          child: TextField(
                            controller: c.ccReviewIntervalTextEditingController,
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              c.cReviewInterval.abObj.refreshEasy((oldValue) => DateTime.now().add(Duration(seconds: int.tryParse(v) ?? 0)));
                            },
                          ),
                        ),
                        const Text('  秒内  '),
                      ],
                    ),
                    Row(
                      children: [
                        AbwBuilder(
                          builder: (abwT) {
                            return Text('${c.cReviewInterval.abObj(abwT)}前');
                          },
                        ),
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
          child: Column(
            children: [
              Row(
                children: [
                  const Text('是否启用过滤碎片：  '),
                  const Spacer(),
                  Switch(
                    value: c.cIsEnableFilterOutAlgorithm.abObj(abw),
                    onChanged: (v) {
                      c.cIsEnableFilterOutAlgorithm.abObj.refreshEasy((oldValue) => v);
                    },
                  ),
                ],
              ),
              c.cIsEnableFilterOutAlgorithm.abObj(abw)
                  ? Row(
                      children: [
                        c.cIsFilterOutAlgorithmFollowMemoryModel.abObj(abw) ? const Text('当前算法跟随记忆模型') : const Text('当前算法使用自定义'),
                        const Spacer(),
                        TextButton(
                          child: c.cIsFilterOutAlgorithmFollowMemoryModel.abObj(abw) ? const Text('切换为自定义') : const Text('跟随记忆模型'),
                          onPressed: () {
                            c.cIsFilterOutAlgorithmFollowMemoryModel.abObj.refreshEasy((oldValue) => !oldValue);
                          },
                        ),
                      ],
                    )
                  : Container(),
              c.cIsEnableFilterOutAlgorithm.abObj(abw) && !c.cIsFilterOutAlgorithmFollowMemoryModel.abObj(abw)
                  ? Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 3,
                                      controller: c.ccFilterOutAlgorithmTextEditingController,
                                      decoration: const InputDecoration(hintText: '请写入算法...'),
                                      onChanged: (v) {
                                        c.cFilterOutAlgorithm.abObj.refreshEasy((oldValue) => v);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
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
              CustomDropdownBodyButton<NewReviewDisplayOrder>(
                value: c.cNewReviewDisplayOrder.abObj(abw),
                item: [
                  Tuple2(t1: '混合', t2: NewReviewDisplayOrder.mix),
                  Tuple2(t1: '优先新碎片', t2: NewReviewDisplayOrder.newReview),
                  Tuple2(t1: '优先复习碎片', t2: NewReviewDisplayOrder.reviewNew),
                ],
                onChanged: (v) {
                  c.cNewReviewDisplayOrder.abObj.refreshEasy((oldValue) => v!);
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
              CustomDropdownBodyButton<NewDisplayOrder>(
                value: c.cNewDisplayOrder.abObj(abw),
                item: [
                  Tuple2(t1: '随机', t2: NewDisplayOrder.random),
                  Tuple2(t1: '标题首字母A~Z顺序', t2: NewDisplayOrder.titleA2Z),
                  Tuple2(t1: '创建时间', t2: NewDisplayOrder.createEarly2Late),
                ],
                onChanged: (v) {
                  c.cNewDisplayOrder.abObj.refreshEasy((oldValue) => v!);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
