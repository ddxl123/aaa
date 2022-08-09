import 'package:drift_main/DriftDb.dart';
import 'package:aaa/page/normal/InsideMemoryGroupPageAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InsideMemoryGroupPage extends StatelessWidget {
  const InsideMemoryGroupPage({Key? key, required this.memoryGroupGizmo, required this.innerMemoryGroupGizmoWidget}) : super(key: key);
  final Ab<MemoryGroup> memoryGroupGizmo;
  final Widget innerMemoryGroupGizmoWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AbBuilder<InsideMemoryGroupPageAbController>(
        putController: InsideMemoryGroupPageAbController(memoryGroupGizmo: memoryGroupGizmo),
        builder: (putC, putAbw) {
          return SmartRefresher(
            controller: putC.refreshController,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: CustomScrollView(
              slivers: [
                _memoryRule(),
                _fragments(),
              ],
            ),
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              await putC.refreshPage();
              putC.refreshController.refreshCompleted();
            },
          );
        },
      ),
    );
  }

  Widget _memoryRule() {
    return AbBuilder<InsideMemoryGroupPageAbController>(
      builder: (c, abw) {
        return SliverToBoxAdapter(
          child: innerMemoryGroupGizmoWidget,
        );
      },
    );
  }

  Widget _fragments() {
    return AbBuilder<InsideMemoryGroupPageAbController>(
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return TextButton(
                onPressed: () {},
                child: Text(c.fragments()[index](abw).title.toString()),
              );
            },
            childCount: c.fragments(abw).length,
          ),
        );
      },
    );
  }
}
