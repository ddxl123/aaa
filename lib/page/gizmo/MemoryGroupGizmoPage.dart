import 'package:drift_main/drift/DriftDb.dart';
import 'package:aaa/page/gizmo/MemoryGroupGizmoPageAbController.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupGizmoPage extends StatelessWidget {
  const MemoryGroupGizmoPage({Key? key, required this.memoryGroupGizmo, required this.innerMemoryGroupGizmoWidget}) : super(key: key);
  final Ab<MemoryGroup> memoryGroupGizmo;
  final Widget innerMemoryGroupGizmoWidget;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryGroupGizmoPageAbController>(
      putController: MemoryGroupGizmoPageAbController(memoryGroupGizmo: memoryGroupGizmo),
      builder: (putC, putAbw) {
        return Scaffold(
          appBar: AppBar(),
          body: SmartRefresher(
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
          ),
        );
      },
    );
  }

  Widget _memoryRule() {
    return AbBuilder<MemoryGroupGizmoPageAbController>(
      builder: (c, abw) {
        return SliverToBoxAdapter(
          child: innerMemoryGroupGizmoWidget,
        );
      },
    );
  }

  Widget _fragments() {
    return AbBuilder<MemoryGroupGizmoPageAbController>(
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
