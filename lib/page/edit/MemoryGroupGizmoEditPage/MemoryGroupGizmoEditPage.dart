import 'package:aaa/page/edit/MemoryGroupGizmoEditPage/BasicConfigWidget.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage/CurrentCircleWidget.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MemoryGroupGizmoEditPageAbController.dart';

class MemoryGroupGizmoEditPage extends StatelessWidget {
  const MemoryGroupGizmoEditPage({Key? key, required this.editPageType, required this.memoryGroupId}) : super(key: key);

  final int memoryGroupId;
  final MemoryGroupGizmoEditPageType editPageType;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      putController: MemoryGroupGizmoEditPageAbController(memoryGroupId: memoryGroupId),
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
        return c.memoryGroupAb().start_time == null
            ? FloatingRoundCornerButton(
                color: Colors.amberAccent,
                text: const Text('开始', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  c.clickStart();
                },
              )
            : FloatingRoundCornerButton(
                color: Colors.greenAccent,
                text: const Text(' 继续 ', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  c.clickContinue();
                },
              );
      },
    );
  }

  Widget _appBarTitleWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return Text(c.memoryGroupAb(abw).title);
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
            c.abBack();
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
              child: const Text('保存'),
              onPressed: () async {
                final isSavedSuccess = await c.save();
                if (isSavedSuccess) {
                  c.abBack();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
