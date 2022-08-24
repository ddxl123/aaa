import 'package:aaa/page/edit/MemoryModelGizmoEditPageAbController.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

class MemoryModelGizmoEditPage extends StatelessWidget {
  const MemoryModelGizmoEditPage({Key? key, required this.memoryModelGizmo, required this.editPageType}) : super(key: key);
  final Ab<MemoryModel>? memoryModelGizmo;
  final MemoryModelGizmoEditPageType editPageType;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      putController: MemoryModelGizmoEditPageAbController(memoryModelGizmo: memoryModelGizmo, editPageType: editPageType),
      tag: Aber.nearest,
      builder: (c, abw) {
        return Scaffold(
          appBar: AppBar(
            leading: _appBarLeadingWidget(),
            title: _appBarTitleWidget(),
            actions: [_appBarRightButtonWidget()],
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _titleWidget(),
                const SizedBox(height: 5),
                _card(
                  child: TextField(
                    controller: c.familiarityAlgorithmTextEditingController,
                    enabled: filter(
                      from: c.editPageType,
                      targets: {
                        [MemoryModelGizmoEditPageType.look]: () => false,
                        [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => true,
                      },
                      orElse: null,
                    ),
                    decoration: const InputDecoration(border: InputBorder.none, labelText: '熟悉度算法：'),
                    onChanged: (value) {
                      c.familiarityAlgorithm.refreshEasy((oldValue) => value);
                    },
                  ),
                ),
                const SizedBox(height: 5),
                _card(
                  child: TextField(
                    controller: c.nextTimeAlgorithmTextEditingController,
                    enabled: filter(
                      from: c.editPageType,
                      targets: {
                        [MemoryModelGizmoEditPageType.look]: () => false,
                        [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => true,
                      },
                      orElse: null,
                    ),
                    decoration: const InputDecoration(border: InputBorder.none, labelText: '下次展示时间点算法：'),
                    onChanged: (value) {
                      c.nextTimeAlgorithm.refreshEasy((oldValue) => value);
                    },
                  ),
                ),
                const SizedBox(height: 5),
                _card(
                  child: TextField(
                    controller: c.buttonDataTextEditingController,
                    enabled: filter(
                      from: c.editPageType,
                      targets: {
                        [MemoryModelGizmoEditPageType.look]: () => false,
                        [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => true,
                      },
                      orElse: null,
                    ),
                    decoration: const InputDecoration(border: InputBorder.none, labelText: '按钮数值分配：'),
                    onChanged: (value) {
                      c.buttonData.refreshEasy((oldValue) => value);
                    },
                  ),
                ),
              ],
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
          from: c.editPageType,
          targets: {
            [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => IconButton(
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
          from: c.editPageType,
          targets: {
            [MemoryModelGizmoEditPageType.create]: () => const Text('创建记忆规则'),
            [MemoryModelGizmoEditPageType.look, MemoryModelGizmoEditPageType.modify]: () => Text(c.title()),
          },
          orElse: null,
        );
      },
    );
  }

  Widget _appBarRightButtonWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        return filter(
          from: c.editPageType,
          targets: {
            [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => IconButton(
                  icon: const FaIcon(FontAwesomeIcons.check, color: Colors.green),
                  onPressed: () {
                    c.commit();
                  },
                ),
            [MemoryModelGizmoEditPageType.look]: () => TextButton(
                  child: const Text('修改'),
                  onPressed: () {
                    Navigator.push(
                      c.context,
                      MaterialPageRoute(
                        builder: (_) => MemoryModelGizmoEditPage(
                          memoryModelGizmo: c.memoryModelGizmo,
                          editPageType: MemoryModelGizmoEditPageType.modify,
                        ),
                      ),
                    );
                  },
                ),
          },
          orElse: null,
        );
      },
    );
  }

  Card _card({required Widget child}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: child,
      ),
    );
  }

  Widget _titleWidget() {
    return _card(
      child: AbBuilder<MemoryModelGizmoEditPageAbController>(
        tag: Aber.nearest,
        builder: (c, abw) {
          return TextField(
            controller: c.titleTextEditingController,
            enabled: filter(
              from: c.editPageType,
              targets: {
                [MemoryModelGizmoEditPageType.look]: () => false,
                [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => true,
              },
              orElse: null,
            ),
            decoration: const InputDecoration(border: InputBorder.none, labelText: '名称：'),
            onChanged: (value) {
              c.title.refreshEasy((oldValue) => value);
            },
          );
        },
      ),
    );
  }
}
