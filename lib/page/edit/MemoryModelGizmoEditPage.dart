import 'package:aaa/algorithm_parser/AlgorithmKeyboard.dart';
import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/MemoryModelGizmoEditPageAbController.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:cool_ui/cool_ui.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemoryModelGizmoEditPage extends StatelessWidget {
  const MemoryModelGizmoEditPage({Key? key, required this.memoryModelAb}) : super(key: key);
  final Ab<MemoryModel> memoryModelAb;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      putController: MemoryModelGizmoEditPageAbController(memoryModelAb: memoryModelAb),
      tag: Aber.single,
      builder: (c, abw) {
        return KeyboardRootWidget(
          child: Scaffold(
            appBar: AppBar(
              leading: _appBarLeadingWidget(),
              title: _appBarTitleWidget(),
              actions: [
                _appBarRightAnalyzeWidget(),
                _appBarRightButtonWidget(),
              ],
            ),
            body: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              slivers: [
                SliverToBoxAdapter(child: _titleWidget()),
                SliverToBoxAdapter(child: _familiarityAlgorithmWidget()),
                SliverToBoxAdapter(child: _nextTimeAlgorithmWidget()),
                SliverToBoxAdapter(child: _buttonDataWidget()),
                SliverToBoxAdapter(
                  child: ElevatedButton(
                    child: const Text('使用默认记忆算法'),
                    onPressed: () {
                      final content = DefaultAlgorithmContent();
                      c.familiarityAlgorithmEditingController.text = content.defaultFamiliarContent;
                      c.buttonAlgorithmEditingController.text = content.defaultButtonDataContent;
                      c.nextTimeAlgorithmEditingController.text = content.defaultNextShowTimeContent;
                    },
                  ),
                ),
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

  Widget _appBarLeadingWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return filter(
          from: c.editPageType(abw),
          targets: {
            [MemoryModelGizmoEditPageType.look]: () => IconButton(
                  icon: const FaIcon(FontAwesomeIcons.angleLeft, color: Colors.red),
                  onPressed: () {
                    Navigator.pop(c.context);
                  },
                ),
            [MemoryModelGizmoEditPageType.modify]: () => IconButton(
                  icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
                  onPressed: () {
                    c.cancel();
                  },
                ),
          },
          orElse: null,
        );
      },
    );
  }

  Widget _appBarTitleWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return filter(
          from: c.editPageType(abw),
          targets: {
            [MemoryModelGizmoEditPageType.look, MemoryModelGizmoEditPageType.modify]: () => Text(c.titleStorage.abValue(abw)),
          },
          orElse: null,
        );
      },
    );
  }

  Widget _appBarRightAnalyzeWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return TextButton(
          child: const Text('分析'),
          onPressed: () {
            c.completeAnalyze();
          },
        );
      },
    );
  }

  Widget _appBarRightButtonWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return filter(
          from: c.editPageType(abw),
          targets: {
            [MemoryModelGizmoEditPageType.look]: () => TextButton(
                  child: const Text('修改'),
                  onPressed: () {
                    c.changeTo(type: MemoryModelGizmoEditPageType.modify);
                  },
                ),
            [MemoryModelGizmoEditPageType.modify]: () => IconButton(
                  icon: const FaIcon(FontAwesomeIcons.check, color: Colors.green),
                  onPressed: () {
                    c.commit();
                  },
                ),
          },
          orElse: null,
        );
      },
    );
  }

  Widget _titleWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return CustomCard(
          child: TextField(
            minLines: 1,
            maxLines: 3,
            controller: c.titleEditingController,
            enabled: filter(
              from: c.editPageType(abw),
              targets: {
                [MemoryModelGizmoEditPageType.modify]: () => true,
                [MemoryModelGizmoEditPageType.look]: () => false,
              },
              orElse: null,
            ),
            decoration: const InputDecoration(border: InputBorder.none, labelText: '名称：'),
            onChanged: (v) {
              c.titleStorage.abValue.refreshEasy((oldValue) => v);
            },
          ),
        );
      },
    );
  }

  Widget _familiarityAlgorithmWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return CustomCard(
          child: TextField(
            keyboardType: c.isAlgorithmKeyboard(abw) ? AlgorithmKeyboard.inputType : TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            focusNode: c.familiarityAlgorithmFocusNode,
            controller: c.familiarityAlgorithmEditingController,
            enabled: filter(
              from: c.editPageType(abw),
              targets: {
                [MemoryModelGizmoEditPageType.modify]: () => true,
                [MemoryModelGizmoEditPageType.look]: () => false,
              },
              orElse: null,
            ),
            decoration: const InputDecoration(border: InputBorder.none, labelText: '熟悉度算法：'),
            onChanged: (v) {
              c.familiarityAlgorithmStorage.abValue.refreshEasy((oldValue) => v);
            },
          ),
        );
      },
    );
  }

  Widget _nextTimeAlgorithmWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return CustomCard(
          child: TextField(
            keyboardType: c.isAlgorithmKeyboard(abw) ? AlgorithmKeyboard.inputType : TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            controller: c.nextTimeAlgorithmEditingController,
            enabled: filter(
              from: c.editPageType(abw),
              targets: {
                [MemoryModelGizmoEditPageType.modify]: () => true,
                [MemoryModelGizmoEditPageType.look]: () => false,
              },
              orElse: null,
            ),
            decoration: const InputDecoration(border: InputBorder.none, labelText: '下次展示时间点算法：'),
            onChanged: (v) {
              c.nextTimeAlgorithmStorage.abValue.refreshEasy((oldValue) => v);
            },
          ),
        );
      },
    );
  }

  Widget _buttonDataWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return CustomCard(
          child: TextField(
            keyboardType: c.isAlgorithmKeyboard(abw) ? AlgorithmKeyboard.inputType : TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            controller: c.buttonAlgorithmEditingController,
            enabled: filter(
              from: c.editPageType(abw),
              targets: {
                [MemoryModelGizmoEditPageType.modify]: () => true,
                [MemoryModelGizmoEditPageType.look]: () => false,
              },
              orElse: null,
            ),
            decoration: const InputDecoration(border: InputBorder.none, labelText: '按钮数值分配算法：'),
            onChanged: (v) {
              c.buttonAlgorithmStorage.abValue.refreshEasy((oldValue) => v);
            },
          ),
        );
      },
    );
  }
}
