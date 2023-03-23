import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/MemoryModelGizomoEditPage/AlgorithmEditPage.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:cool_ui/cool_ui.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MemoryModelGizmoEditPageAbController.dart';

class MemoryModelGizmoEditPage extends StatelessWidget {
  const MemoryModelGizmoEditPage({Key? key, required this.memoryModelAb}) : super(key: key);
  final Ab<MemoryModel> memoryModelAb;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      putController: MemoryModelGizmoEditPageAbController(originalMemoryModelAb: memoryModelAb),
      tag: Aber.single,
      builder: (c, abw) {
        return KeyboardRootWidget(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.chevron_left_outlined),
                onPressed: () {
                  c.abBack();
                },
              ),
              title: _appBarTitleWidget(),
              actions: [
                _appBarRightAnalyzeWidget(),
                _appBarRightButtonWidget(),
              ],
            ),
            body: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(child: _titleWidget()),
                SliverToBoxAdapter(child: _familiarityAlgorithmWidget()),
                SliverToBoxAdapter(child: _nextTimeAlgorithmWidget()),
                SliverToBoxAdapter(child: _buttonDataWidget()),
              ],
            ),
            floatingActionButton: AbwBuilder(
              builder: (fAbw) {
                return c.isAlgorithmKeyboard(fAbw)
                    ? FloatingRoundCornerButton(
                        text: const FaIcon(FontAwesomeIcons.keyboard),
                        onPressed: () {
                          c.changeKeyword();
                        },
                        border: const CircleBorder(),
                      )
                    : FloatingRoundCornerButton(
                        text: const Text('算法键盘'),
                        onPressed: () {
                          c.changeKeyword();
                        },
                      );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _appBarTitleWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return Text(c.copyMemoryModelAb(abw).title);
      },
    );
  }

  Widget _appBarRightAnalyzeWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return TextButton(
          child: const Text('分析'),
          onPressed: () {},
        );
      },
    );
  }

  Widget _appBarRightButtonWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            c.save();
          },
        );
      },
    );
  }

  Widget _titleWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                minLines: 1,
                maxLines: 3,
                controller: c.titleEditingController,
                decoration: const InputDecoration(border: InputBorder.none, labelText: '名称：'),
                onChanged: (v) {
                  c.copyMemoryModelAb.refreshInevitable((obj) => obj..title = v);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _bigSingle({
    required BuildContext context,
    required String title,
    required AlgorithmUsageStatus? groupValue,
    required ValueChanged<AlgorithmUsageStatus?>? onChanged,
    required bool aIsEmptyScheme,
    required bool bIsEmptyScheme,
    required bool cIsEmptyScheme,
    required EnterType aEnterType,
    required EnterType bEnterType,
    required EnterType cEnterType,
  }) {
    return Card(
      child: ExpansionTile(
        title: Text(title + "："),
        children: [
          _single(
            value: AlgorithmUsageStatus.a,
            groupValue: groupValue,
            onChanged: onChanged,
            isEmptyScheme: aIsEmptyScheme,
            enterType: aEnterType,
          ),
          _single(
            value: AlgorithmUsageStatus.b,
            groupValue: groupValue,
            onChanged: onChanged,
            isEmptyScheme: bIsEmptyScheme,
            enterType: bEnterType,
          ),
          _single(
            value: AlgorithmUsageStatus.c,
            groupValue: groupValue,
            onChanged: onChanged,
            isEmptyScheme: cIsEmptyScheme,
            enterType: cEnterType,
          ),
          StfBuilder1(
            initValue: false,
            builder: (bool extra, BuildContext context, void Function(bool, bool) resetValue) {
              return ExpansionTile(
                title: Text(
                  "说明：${extra ? "" : "..."}",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                trailing: Text(
                  extra ? "隐藏" : "展开",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
                children: [
                  ListTile(
                    visualDensity: kMinVisualDensity,
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "大苏打实打实大大飒飒大苏打实打实大大飒飒大苏打实打实大大飒飒大苏打实打实大大飒飒大苏打实打实大大飒飒大苏打实打实大大飒飒大苏打实打实大大飒飒大苏打实打实大大飒飒",
                            style: TextStyle(fontSize: 16, color: Color.fromRGBO(100, 100, 100, 1)),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  SizedBox(height: 10),
                ],
                onExpansionChanged: (be) {
                  resetValue(be, true);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _single({
    required AlgorithmUsageStatus value,
    required AlgorithmUsageStatus? groupValue,
    required ValueChanged<AlgorithmUsageStatus?>? onChanged,
    required bool isEmptyScheme,
    required EnterType enterType,
  }) {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return Row(
          children: [
            Expanded(
              child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 20,
                      child: c.filterForStatus(
                        algorithmUsageStatus: value,
                        aFunc: () => Text("A"),
                        bFunc: () => Text("B"),
                        cFunc: () => Text("C"),
                        abw: abw,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(width: 1.5),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: c.filterForStatus(
                                  algorithmUsageStatus: value,
                                  aFunc: () => Row(
                                    children: [
                                      Text("方案 A"),
                                      Text("  ${isEmptyScheme ? "(未配置)" : ""}"),
                                    ],
                                  ),
                                  bFunc: () => Row(
                                    children: [
                                      Text("方案 B"),
                                      Text("  ${isEmptyScheme ? "(A 的副本)" : ""}", style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                  cFunc: () => Row(
                                    children: [
                                      Text("方案 C"),
                                      Text("  ${isEmptyScheme ? "(A 的副本)" : ""}", style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                  abw: abw,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(value == groupValue ? "正在使用(不可修改)" : "可修改", style: TextStyle(color: Colors.grey, fontSize: 14)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right),
                  ],
                ),
                onPressed: () {
                  c.enterType.refreshEasy((oldValue) => enterType);
                  Navigator.push(c.context, MaterialPageRoute(builder: (_) => AlgorithmEditPage()));
                },
              ),
            ),
            Radio(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ],
        );
      },
    );
  }

  Widget _familiarityAlgorithmWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: _bigSingle(
            context: c.context,
            title: FamiliarityState.NAME,
            groupValue: c.copyMemoryModelAb(abw).familiarity_algorithm_usage_status,
            onChanged: (v) {
              c.copyMemoryModelAb().familiarity_algorithm_usage_status = v!;
              abw.refresh();
            },
            aIsEmptyScheme: c.copyMemoryModelAb(abw).familiarity_algorithm_a == null,
            bIsEmptyScheme: c.copyMemoryModelAb(abw).familiarity_algorithm_b == null,
            cIsEmptyScheme: c.copyMemoryModelAb(abw).familiarity_algorithm_c == null,
            aEnterType: EnterType(algorithmType: FamiliarityState, algorithmUsageStatus: AlgorithmUsageStatus.a),
            bEnterType: EnterType(algorithmType: FamiliarityState, algorithmUsageStatus: AlgorithmUsageStatus.b),
            cEnterType: EnterType(algorithmType: FamiliarityState, algorithmUsageStatus: AlgorithmUsageStatus.c),
          ),
        );
      },
    );
  }

  Widget _nextTimeAlgorithmWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: _bigSingle(
            context: c.context,
            title: NextShowTimeState.NAME,
            groupValue: c.copyMemoryModelAb(abw).next_time_algorithm_usage_status,
            onChanged: (v) {
              c.copyMemoryModelAb().next_time_algorithm_usage_status = v!;
              abw.refresh();
            },
            aIsEmptyScheme: c.copyMemoryModelAb(abw).next_time_algorithm_a == null,
            bIsEmptyScheme: c.copyMemoryModelAb(abw).next_time_algorithm_b == null,
            cIsEmptyScheme: c.copyMemoryModelAb(abw).next_time_algorithm_c == null,
            aEnterType: EnterType(algorithmType: NextShowTimeState, algorithmUsageStatus: AlgorithmUsageStatus.a),
            bEnterType: EnterType(algorithmType: NextShowTimeState, algorithmUsageStatus: AlgorithmUsageStatus.b),
            cEnterType: EnterType(algorithmType: NextShowTimeState, algorithmUsageStatus: AlgorithmUsageStatus.c),
          ),
        );
      },
    );
  }

  Widget _buttonDataWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: _bigSingle(
            context: c.context,
            title: ButtonDataState.NAME,
            groupValue: c.copyMemoryModelAb(abw).button_algorithm_usage_status,
            onChanged: (v) {
              c.copyMemoryModelAb().button_algorithm_usage_status = v!;
              abw.refresh();
            },
            aIsEmptyScheme: c.copyMemoryModelAb(abw).button_algorithm_a == null,
            bIsEmptyScheme: c.copyMemoryModelAb(abw).button_algorithm_b == null,
            cIsEmptyScheme: c.copyMemoryModelAb(abw).button_algorithm_c == null,
            aEnterType: EnterType(algorithmType: ButtonDataState, algorithmUsageStatus: AlgorithmUsageStatus.a),
            bEnterType: EnterType(algorithmType: ButtonDataState, algorithmUsageStatus: AlgorithmUsageStatus.b),
            cEnterType: EnterType(algorithmType: ButtonDataState, algorithmUsageStatus: AlgorithmUsageStatus.c),
          ),
        );
      },
    );
  }
}