import 'package:aaa/algorithm_parser/AlgorithmKeyboard.dart';
import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/MemoryModelGizmoEditPageAbController.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:cool_ui/cool_ui.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemoryModelGizmoEditPage extends StatelessWidget {
  const MemoryModelGizmoEditPage({Key? key, required this.memoryModelGizmo, required this.editPageType}) : super(key: key);
  final Ab<MemoryModel?> memoryModelGizmo;
  final Ab<MemoryModelGizmoEditPageType> editPageType;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      putController: MemoryModelGizmoEditPageAbController(memoryModelGizmo: memoryModelGizmo, editPageType: editPageType),
      tag: Aber.nearest,
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
                    child: const Text('使用默认记忆规则'),
                    onPressed: () {
                      final content = DefaultAlgorithmContent();
                      c.familiarityAlgorithmEditingController.text = content.defaultFamiliarContent;
                      c.buttonDataAlgorithmEditingController.text = content.defaultButtonDataContent;
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
      tag: Aber.nearest,
      builder: (c, abw) {
        return filter(
          from: c.editPageType(abw),
          targets: {
            [MemoryModelGizmoEditPageType.create]: () => IconButton(
                  icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
                  onPressed: () {
                    c.cancel();
                  },
                ),
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
      tag: Aber.nearest,
      builder: (c, abw) {
        return filter(
          from: c.editPageType(abw),
          targets: {
            [MemoryModelGizmoEditPageType.create]: () => const Text('创建记忆模型'),
            [MemoryModelGizmoEditPageType.look, MemoryModelGizmoEditPageType.modify]: () => Text(c.title(abw)),
          },
          orElse: null,
        );
      },
    );
  }

  Widget _appBarRightAnalyzeWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        return TextButton(
          child: const Text('分析'),
          onPressed: () {
            c.analyzeWithHandle();
          },
        );
      },
    );
  }

  Widget _appBarRightButtonWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        return filter(
          from: c.editPageType(abw),
          targets: {
            [MemoryModelGizmoEditPageType.create]: () => IconButton(
                  icon: const FaIcon(FontAwesomeIcons.check, color: Colors.green),
                  onPressed: () {
                    c.commit();
                  },
                ),
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
      tag: Aber.nearest,
      builder: (c, abw) {
        return CardCustom(
          verifyAb: c.title,
          child: TextField(
            minLines: 1,
            maxLines: 3,
            controller: c.titleEditingController,
            enabled: filter(
              from: c.editPageType(abw),
              targets: {
                [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => true,
                [MemoryModelGizmoEditPageType.look]: () => false,
              },
              orElse: null,
            ),
            decoration: const InputDecoration(border: InputBorder.none, labelText: '名称：'),
            onChanged: (v) {
              c.title.refreshEasy((oldValue) => v);
            },
          ),
        );
      },
    );
  }

  Widget _familiarityAlgorithmWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        return CardCustom(
          verifyAb: c.familiarityAlgorithm,
          child: TextField(
            keyboardType: c.isAlgorithmKeyboard(abw) ? AlgorithmKeyboard.inputType : TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            focusNode: c.familiarityAlgorithmFocusNode,
            controller: c.familiarityAlgorithmEditingController,
            enabled: filter(
              from: c.editPageType(abw),
              targets: {
                [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => true,
                [MemoryModelGizmoEditPageType.look]: () => false,
              },
              orElse: null,
            ),
            decoration: const InputDecoration(border: InputBorder.none, labelText: '熟悉度算法：'),
            onChanged: (v) {
              c.familiarityAlgorithm.refreshEasy((oldValue) => v);
            },
          ),
        );
      },
    );
  }

  Widget _nextTimeAlgorithmWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        return CardCustom(
          verifyAb: c.nextTimeAlgorithm,
          child: TextField(
            keyboardType: c.isAlgorithmKeyboard(abw) ? AlgorithmKeyboard.inputType : TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            controller: c.nextTimeAlgorithmEditingController,
            enabled: filter(
              from: c.editPageType(abw),
              targets: {
                [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => true,
                [MemoryModelGizmoEditPageType.look]: () => false,
              },
              orElse: null,
            ),
            decoration: const InputDecoration(border: InputBorder.none, labelText: '下次展示时间点算法：'),
            onChanged: (v) {
              c.nextTimeAlgorithm.refreshEasy((oldValue) => v);
            },
          ),
        );
      },
    );
  }

  Widget _buttonDataWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        return CardCustom(
          verifyAb: c.buttonDataAlgorithm,
          child: TextField(
            keyboardType: c.isAlgorithmKeyboard(abw) ? AlgorithmKeyboard.inputType : TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            controller: c.buttonDataAlgorithmEditingController,
            enabled: filter(
              from: c.editPageType(abw),
              targets: {
                [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => true,
                [MemoryModelGizmoEditPageType.look]: () => false,
              },
              orElse: null,
            ),
            decoration: const InputDecoration(border: InputBorder.none, labelText: '按钮数值分配算法：'),
            onChanged: (v) {
              c.buttonDataAlgorithm.refreshEasy((oldValue) => v);
            },
          ),
        );
      },
    );
  }
}
