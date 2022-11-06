import 'package:aaa/page/edit/MemoryGroupGizmoEditPage/BasicConfigWidget.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage/CurrentCircleWidget.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MemoryGroupGizmoEditPageAbController.dart';

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
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return const CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          slivers: [
            BasicConfigWidget(),
            CurrentCircleWidget(),
          ],
        );
      },
    );
  }

  Widget _floatingActionButton() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return c.memoryGroupGizmo!().startTime == null
            ? FloatingRoundCornerButton(
                color: Colors.amberAccent,
                text: const Text('保存并执行', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  c.applyAndStart();
                },
              )
            : FloatingRoundCornerButton(
                color: Colors.greenAccent,
                text: const Text('继续', style: TextStyle(color: Colors.white)),
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
        return Text(c.bTitle.abObj(abw));
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
              onPressed: () async {
                await c.analyze();
              },
            ),
            TextButton(
              child: const Text('保存'),
              onPressed: () async {
                await c.save();
              },
            ),
          ],
        );
      },
    );
  }
}
