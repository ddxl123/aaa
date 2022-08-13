import 'package:aaa/page/edit/MemoryModelGizmoEditPage.dart';
import 'package:aaa/tool/aber/Aber.dart';
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
      tag: Aber.hashCodeTag,
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
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => const MemoryModelGizmoEditPage()));
                      }
                    },
                  ),
                ),
              ],
            ),
            preferredSize: const Size.fromHeight(kMinInteractiveDimension),
          ),
          body: AbBuilder<MemoryModeListPageAbController>(
            tag: Aber.hashCodeTag,
            builder: (c, abw) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: SmartRefresher(
                  controller: c.refreshController,
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  child: CustomScrollView(
                    slivers: [
                      _memoryRule(),
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

  Widget _memoryRule() {
    return AbBuilder<MemoryModeListPageAbController>(
      tag: Aber.hashCodeTag,
      builder: (controller, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(controller.memoryModels()[index](abw).title.toString()),
                      onPressed: () {},
                    ),
                  ),
                  filter(
                    from: listPageType,
                    targets: {
                      [ListPageType.selectPath]: () => IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.solidCircle,
                              color: controller.selected(abw) == controller.memoryModels()[index]() ? Colors.amber : Colors.grey,
                              size: 14,
                            ),
                            onPressed: () {
                              controller.selectMemoryModel(controller.memoryModels()[index]());
                            },
                          ),
                    },
                    orElse: () => Container(),
                  ),
                ],
              );
            },
            childCount: controller.memoryModels(abw).length,
          ),
        );
      },
    );
  }
}