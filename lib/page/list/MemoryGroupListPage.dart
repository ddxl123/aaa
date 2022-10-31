import 'package:aaa/page/gizmo/MemoryGroupGizmoPage.dart';
import 'package:aaa/single_dialog/single_dialog.dart';
import 'package:tools/tools.dart';
import 'package:aaa/page/list/MemoryGroupListPageAbController.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupListPage extends StatelessWidget {
  const MemoryGroupListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryGroupListPageAbController>(
      putController: MemoryGroupListPageAbController(),
      tag: Aber.nearest,
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<int>(
                    dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    dropdownWidth: 150,
                    customButton: const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Icon(Icons.more_horiz),
                    ),
                    items: const [
                      DropdownMenuItem(
                        child: Text('添加记忆组'),
                        value: 0,
                      )
                    ],
                    onChanged: (value) {
                      if (value == 0) {
                        showDialogForCreateMemoryGroup(context: context);
                      }
                    },
                  ),
                ),
              ],
            ),
            preferredSize: const Size.fromHeight(kMinInteractiveDimension),
          ),
          body: AbBuilder<MemoryGroupListPageAbController>(
            tag: Aber.nearest,
            builder: (c, abw) {
              return SmartRefresher(
                controller: c.refreshController,
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                child: CustomScrollView(
                  slivers: [
                    _memoryGroupGizmoList(c.context),
                  ],
                ),
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 200));
                  await c.refreshPage();
                  c.refreshController.refreshCompleted();
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _memoryGroupGizmoList(BuildContext context) {
    return AbBuilder<MemoryGroupListPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, index) {
              return _memoryGroupGizmoWidget(index);
            },
            childCount: c.memoryGroupGizmos(abw).length,
          ),
        );
      },
    );
  }

  Color _statusButtonBackgroundColorFilter(MemoryGroup memoryGroup) {
    return filter(
      from: memoryGroup.type,
      targets: {
        [MemoryGroupType.inApp]: () {
          if (memoryGroup.startTime == null) {
            return Colors.amberAccent;
          } else if (memoryGroup.startTime == DateTime.fromMicrosecondsSinceEpoch(0)) {
            return Colors.grey;
          } else {
            return Colors.greenAccent;
          }
        },
      },
      orElse: () => Colors.red,
    );
  }

  String _statusButtonTextFilter(MemoryGroup memoryGroup) {
    return filter(
      from: memoryGroup.type,
      targets: {
        [MemoryGroupType.inApp]: () {
          if (memoryGroup.startTime == null) {
            return '未执行';
          } else if (memoryGroup.startTime == DateTime.fromMicrosecondsSinceEpoch(0)) {
            return '已完成';
          } else {
            return '继续';
          }
        },
      },
      orElse: () => 'unknown',
    );
  }

  Widget _memoryGroupGizmoWidget(int index) {
    return AbBuilder<MemoryGroupListPageAbController>(
      tag: Aber.nearest,
      builder: (c, abw) {
        final memoryGroupGizmo = c.memoryGroupGizmos(abw)[index];

        return Hero(
          tag: memoryGroupGizmo.hashCode,
          child: GestureDetector(
            child: CardCustom(
              verifyAb: null,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          memoryGroupGizmo(abw).title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      AbwBuilder(
                        builder: (abw) {
                          return OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(const BorderSide(color: Colors.blue, width: 1)),
                              backgroundColor: MaterialStateProperty.all(_statusButtonBackgroundColorFilter(memoryGroupGizmo(abw))),
                            ),
                            child: () {
                              return Text(_statusButtonTextFilter(memoryGroupGizmo(abw)));
                            }(),
                            onPressed: () {
                              c.onStatusTap(memoryGroupGizmo);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                c.context,
                MaterialPageRoute(
                  builder: (_) => MemoryGroupGizmoPage(
                    memoryGroupGizmo: memoryGroupGizmo,
                    innerMemoryGroupGizmoWidget: _memoryGroupGizmoWidget(index),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
