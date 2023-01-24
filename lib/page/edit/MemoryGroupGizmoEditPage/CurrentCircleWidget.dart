import 'package:drift_main/share_common/share_enum.dart';
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
                floatingRoundCornerButtonPlaceholderBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _newLearnCountWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CustomAbWrongCard(
          child: Row(
            children: [
              const Text('新学数量：'),
              Expanded(
                child: StfBuilder1<int>(
                  // 保留上一次的设置
                  initValue: c.cWillNewLearnCountStorage.abValue(abw),
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
                              c.cWillNewLearnCountStorage.abValue.refreshEasy((oldValue) => n.floor());
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
        return CustomAbWrongCard(
          abWrong: c.cReviewIntervalStorage.verifyErrorMessage,
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
                              c.cReviewIntervalStorage.abValue.refreshEasy((oldValue) => DateTime.now().add(Duration(seconds: int.tryParse(v) ?? 0)));
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
                            return Text('${c.cReviewIntervalStorage.abValue(abwT)}前');
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

  Widget _newReviewDisplayOrder() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CustomAbWrongCard(
          child: Row(
            children: [
              const Text('新 | 复习 碎片展示顺序：'),
              CustomDropdownBodyButton<NewReviewDisplayOrder>(
                initValue: c.cNewReviewDisplayOrderStorage.abValue(abw),
                items: [
                  Item(value: NewReviewDisplayOrder.mix, text: '混合'),
                  Item(value: NewReviewDisplayOrder.new_review, text: '优先新碎片'),
                  Item(value: NewReviewDisplayOrder.review_new, text: '优先复习碎片'),
                ],
                onChanged: (v) {
                  c.cNewReviewDisplayOrderStorage.abValue.refreshEasy((oldValue) => v!);
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
        return CustomAbWrongCard(
          child: Row(
            children: [
              const Text('新碎片 展示顺序：'),
              CustomDropdownBodyButton<NewDisplayOrder>(
                initValue: c.cNewDisplayOrderStorage.abValue(abw),
                items: [
                  Item(value: NewDisplayOrder.random, text: '随机'),
                  Item(value: NewDisplayOrder.title_a_2_z, text: '标题首字母A~Z顺序'),
                  Item(value: NewDisplayOrder.create_early_2_late, text: '创建时间'),
                ],
                onChanged: (v) {
                  c.cNewDisplayOrderStorage.abValue.refreshEasy((oldValue) => v!);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
