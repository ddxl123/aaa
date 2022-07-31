import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/page/create/CreateModifyMemoryGroupPage.dart';
import 'package:aaa/page/create/CreateOrModifyType.dart';
import 'package:aaa/page/normal/FragmentInMemoryGroupPage.dart';
import 'package:aaa/tool/Extensioner.dart';
import 'package:aaa/tool/Helper.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/MemoryGroupModelAbController.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupModel extends StatelessWidget {
  const MemoryGroupModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryGroupModelAbController>(
      putController: MemoryGroupModelAbController(),
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
                        child: Text('添加记忆组'),
                        value: 0,
                      )
                    ],
                    onChanged: (value) {
                      if (value == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (ctx) => const CreateModifyMemoryGroupPage(createOrModifyType: CreateModifyCheckType.create)),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            preferredSize: const Size.fromHeight(kMinInteractiveDimension),
          ),
          body: AbBuilder<MemoryGroupModelAbController>(
            tag: Aber.hashCodeTag,
            builder: (c, abw) {
              return SmartRefresher(
                controller: c.refreshController,
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                child: CustomScrollView(
                  slivers: [
                    ..._memoryGroupList(context: c.context, fixedMemoryGroupType: MemoryGroupType.normal),
                    const SliverToBoxAdapter(child: Divider(height: 20)),
                    ..._memoryGroupList(context: c.context, fixedMemoryGroupType: MemoryGroupType.fullFloating),
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

  List<Widget> _memoryGroupList({required BuildContext context, required MemoryGroupType fixedMemoryGroupType}) {
    return [
      _sliverAppBar(
        context,
        text: Helper.filter(
          from: fixedMemoryGroupType,
          targets: {
            [MemoryGroupType.normal]: () => '常规碎片组：',
            [MemoryGroupType.fullFloating]: () => '全悬浮碎片组：',
          },
          orElse: () => 'unknown',
        ),
      ),
      AbBuilder<MemoryGroupModelAbController>(
        tag: Aber.hashCodeTag,
        builder: (c, abw) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) {
                return _memoryGroupWidget(index: index, fixedMemoryGroupType: fixedMemoryGroupType);
              },
              childCount: Helper.filter(
                from: fixedMemoryGroupType,
                targets: {
                  [MemoryGroupType.normal]: () => c.normalMemoryGroups(abw).length,
                  [MemoryGroupType.fullFloating]: () => c.fullFloatingMemoryGroups(abw).length,
                },
                orElse: () => 0,
              ),
            ),
          );
        },
      ),
    ];
  }

  Widget _sliverAppBar(BuildContext context, {required String text}) {
    return SliverAppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Text(text),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget _memoryGroupWidget({required int index, required MemoryGroupType fixedMemoryGroupType}) {
    return AbBuilder<MemoryGroupModelAbController>(
      tag: Aber.hashCodeTag,
      builder: (c, abw) {
        final outerMemoryGroup = Helper.filter(
          from: fixedMemoryGroupType,
          targets: {
            [MemoryGroupType.normal]: () => c.normalMemoryGroups()[index],
            [MemoryGroupType.fullFloating]: () => c.fullFloatingMemoryGroups()[index],
          },
          orElse: null,
        );
        final memoryGroup = outerMemoryGroup().memoryGroup(abw);

        final statusButtonBackgroundColor = Helper.filter(
          from: memoryGroup.type,
          targets: {
            [MemoryGroupType.normal]: () => Helper.filter(
                  from: memoryGroup.normalStatus,
                  targets: {
                    [MemoryGroupStatusForNormal.notStart]: () => Colors.amber,
                    [MemoryGroupStatusForNormal.goon]: () => Colors.green,
                    [MemoryGroupStatusForNormal.completed]: () => Colors.grey,
                  },
                  orElse: () => Colors.red,
                ),
            [MemoryGroupType.fullFloating]: () => Helper.filter(
                  from: memoryGroup.fullFloatingStatus,
                  targets: {
                    [MemoryGroupStatusForFullFloating.notStarted]: () => Colors.amber,
                    [MemoryGroupStatusForFullFloating.remembering]: () => Colors.green,
                    [MemoryGroupStatusForFullFloating.pause]: () => Colors.blue,
                    [MemoryGroupStatusForFullFloating.completed]: () => Colors.grey,
                  },
                  orElse: () => Colors.red,
                ),
          },
          orElse: () => Colors.red,
        );

        final partFloatingWidget = Helper.filter(
          from: memoryGroup.type,
          targets: {
            [MemoryGroupType.normal]: () => Helper.filter(
                  from: memoryGroup.normalPartStatus,
                  targets: {
                    [
                      MemoryGroupStatusForNormalPart.enabled,
                      MemoryGroupStatusForNormalPart.paused,
                    ]: () => const Text('部分悬浮', style: TextStyle(color: Colors.grey))
                  },
                  orElse: () => Container(),
                )
          },
          orElse: () => Container(),
        );

        final statusButtonText = Helper.filter(
          from: memoryGroup.type,
          targets: {
            [MemoryGroupType.normal]: () => Helper.filter(
                  from: memoryGroup.normalStatus,
                  targets: {
                    [MemoryGroupStatusForNormal.notStart]: () => '未开始',
                    [MemoryGroupStatusForNormal.goon]: () => '继续',
                    [MemoryGroupStatusForNormal.completed]: () => '已完成',
                  },
                  orElse: () => 'unknown',
                ),
            [MemoryGroupType.fullFloating]: () => Helper.filter(
                  from: memoryGroup.fullFloatingStatus,
                  targets: {
                    [MemoryGroupStatusForFullFloating.notStarted]: () => '未开始',
                    [MemoryGroupStatusForFullFloating.remembering]: () => '记忆中',
                    [MemoryGroupStatusForFullFloating.pause]: () => '已暂停',
                    [MemoryGroupStatusForFullFloating.completed]: () => '已完成',
                  },
                  orElse: () => 'unknown',
                ),
          },
          orElse: () => 'unknown',
        );
        return Hero(
          tag: outerMemoryGroup.hashCode,
          child: GestureDetector(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          memoryGroup.title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      partFloatingWidget,
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(text: '已记 ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                    TextSpan(text: '1', style: TextStyle(fontSize: 14, color: Colors.black)),
                                    TextSpan(text: '  |  ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                    TextSpan(text: '记过 ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                    TextSpan(text: '12', style: TextStyle(fontSize: 14, color: Colors.black)),
                                    TextSpan(text: '  |  ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                    TextSpan(text: '未记 ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                    TextSpan(text: '332', style: TextStyle(fontSize: 14, color: Colors.black)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 5,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 5,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(text: '今日 11/50', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                        TextSpan(text: '  |  ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                        TextSpan(text: '总共 50/200', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Material(
                          child: InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                            splashColor: Colors.green,
                            child: Ink(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                color: statusButtonBackgroundColor,
                              ),
                              child: Text(statusButtonText),
                            ),
                            onTap: () {
                              c.onStatusTap(outerMemoryGroup);
                            },
                          ),
                        ),
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
                  builder: (_) => FragmentInMemoryGroupPage(
                    outerMemoryGroup: outerMemoryGroup,
                    innerMemoryGroupWidget: _memoryGroupWidget(index: index, fixedMemoryGroupType: fixedMemoryGroupType),
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
