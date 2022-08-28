import 'package:aaa/page/edit/MemoryModelGizmoEditPageAbController.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemoryModelGizmoEditPage extends StatelessWidget {
  const MemoryModelGizmoEditPage({Key? key, required this.memoryModelGizmo, required this.editPageType}) : super(key: key);
  final Ab<MemoryModel>? memoryModelGizmo;
  final Ab<MemoryModelGizmoEditPageType> editPageType;

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
            ],
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
            [MemoryModelGizmoEditPageType.create]: () => const Text('创建记忆规则'),
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
            c.analyze();
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
          child: TextField(
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
          verifyAb: c.title,
        );
      },
    );
  }

  Widget _familiarityAlgorithmWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        return CardCustom(
          child: TextField(
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
          verifyAb: c.familiarityAlgorithm,
        );
      },
    );
  }

  Widget _nextTimeAlgorithmWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        return CardCustom(
          child: TextField(
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
          verifyAb: c.nextTimeAlgorithm,
        );
      },
    );
  }

  Widget _buttonDataWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        return CardCustom(
          child: TextField(
            controller: c.buttonDataEditingController,
            enabled: filter(
              from: c.editPageType(abw),
              targets: {
                [MemoryModelGizmoEditPageType.create, MemoryModelGizmoEditPageType.modify]: () => true,
                [MemoryModelGizmoEditPageType.look]: () => false,
              },
              orElse: null,
            ),
            decoration: const InputDecoration(border: InputBorder.none, labelText: '按钮数值分配：'),
            onChanged: (v) {
              c.buttonData.refreshEasy((oldValue) => v);
            },
          ),
          verifyAb: c.buttonData,
        );
      },
    );
  }
}
