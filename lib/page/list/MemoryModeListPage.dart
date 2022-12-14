import 'package:aaa/page/edit/MemoryModelGizmoEditPage.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:aaa/page/gizmo/MemoryModelGizmoPage.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:tools/tools.dart';
import 'package:aaa/page/list/MemoryModeListPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryModeListPage extends StatelessWidget {
  const MemoryModeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModeListPageAbController>(
      putController: MemoryModeListPageAbController(),
      tag: Aber.single,
      builder: (c, abw) {
        return Scaffold(
          appBar: _appBar(context: c.context),
          body: _body(),
        );
      },
    );
  }

  PreferredSizeWidget _appBar({required BuildContext context}) {
    return CustomNarrowAppBar(
      actions: [
        CustomDropdownBodyButton(
          initValue: 0,
          primaryButton: const Icon(Icons.more_horiz),
          itemAlignment: Alignment.centerLeft,
          items: [
            Item(value: 0, text: '添加记忆算法'),
          ],
          onChanged: (v) {
            if (v == 0) {
              pushToMemoryModelGizmoEditPageOfCreate(context: context);
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
    return AbBuilder<MemoryModeListPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: SmartRefresher(
            controller: c.refreshController,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: CustomScrollView(
              slivers: [
                _memoryModel(),
              ],
            ),
            onRefresh: () async {
              await c.refreshMemoryModels();
              c.refreshController.refreshCompleted();
            },
          ),
        );
      },
    );
  }

  Widget _memoryModel() {
    return AbBuilder<MemoryModeListPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(c.memoryModels()[index](abw).title.toString()),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MemoryModelGizmoPage(memoryModelGizmo: c.memoryModels()[index])),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            childCount: c.memoryModels(abw).length,
          ),
        );
      },
    );
  }
}
