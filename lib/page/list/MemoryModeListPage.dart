import 'package:aaa/page/edit/MemoryModelGizmoEditPage.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:aaa/page/gizmo/MemoryModelGizmoPage.dart';
import 'package:tools/tools.dart';
import 'package:aaa/page/list/ListPageType.dart';
import 'package:aaa/page/list/MemoryModeListPageAbController.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class MemoryModeListPage extends StatelessWidget {
  const MemoryModeListPage({Key? key, required this.listPageType}) : super(key: key);

  final ListPageType listPageType;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryModeListPageAbController>(
      putController: MemoryModeListPageAbController(),
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
                        child: Text('添加记忆规则'),
                        value: 0,
                      )
                    ],
                    onChanged: (value) {
                      if (value == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => MemoryModelGizmoEditPage(
                              memoryModelGizmo: null,
                              editPageType: MemoryModelGizmoEditPageType.create.ab,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            preferredSize: const Size.fromHeight(kMinInteractiveDimension),
          ),
          body: AbBuilder<MemoryModeListPageAbController>(
            tag: Aber.nearest,
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
      tag: Aber.nearest,
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
