import 'package:aaa/page/edit/MemoryModelGizmoEditPage.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:aaa/page/gizmo/MemoryModelGizmoPage.dart';
import 'package:tools/tools.dart';
import 'package:aaa/page/list/ListPageType.dart';
import 'package:aaa/page/list/MemoryModeListPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryModeListPage extends StatelessWidget {
  const MemoryModeListPage({Key? key, required this.listPageType}) : super(key: key);

  final ListPageType listPageType;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModeListPageAbController>(
      putController: MemoryModeListPageAbController(),
      tag: Aber.single,
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kMinInteractiveDimension),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomDropdownBodyButton(
                  primaryButton: const Icon(Icons.more_horiz),
                  initValue: 0,
                  itemAlignment: Alignment.centerLeft,
                  items: [
                    Item(value: 0, text: '添加记忆算法'),
                  ],
                  onChanged: (value) {
                    if (value == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => MemoryModelGizmoEditPage(
                            memoryModelGizmo: Ab(null),
                            editPageType: MemoryModelGizmoEditPageType.create.ab,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          body: AbBuilder<MemoryModeListPageAbController>(
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
                    await Future.delayed(const Duration(milliseconds: 200));
                    await c.refreshMemoryModels();
                    c.refreshController.refreshCompleted();
                  },
                ),
              );
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
                  filter(
                    from: listPageType,
                    targets: {
                      [ListPageType.selectPath]: () => IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.solidCircle,
                              color: c.selected(abw) == c.memoryModels()[index]() ? Colors.amber : Colors.grey,
                              size: 14,
                            ),
                            onPressed: () {
                              c.selectMemoryModel(c.memoryModels()[index]());
                            },
                          ),
                    },
                    orElse: () => Container(),
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
