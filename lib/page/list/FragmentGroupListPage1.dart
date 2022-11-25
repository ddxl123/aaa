import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage.dart';
import 'package:aaa/page/edit/FragmentGroupGizmoEditPage.dart';
import 'package:tools/tools.dart';
import 'package:aaa/page/list/FragmentGroupListPageAbController.dart';
import 'package:aaa/page/list/ListPageType.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'FragmentGroupListPageAbController1.dart';

class GroupListWidget extends StatelessWidget {
  const GroupListWidget({Key? key, required this.listPageType}) : super(key: key);

  final ListPageType listPageType;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<GroupListWidgetAbController>(
      putController: GroupListWidgetAbController(),
      tag: Aber.single,
      builder: (controller, abw) {
        return Scaffold(
          primary: false,
          appBar: _appBarBottom(context),
          body: _body(),
        );
      },
    );
  }

  Widget _body() {
    return AbBuilder<GroupListWidgetAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return IndexedStack(
          index: c.parts(abw).length - 1,
          children: [
            ...c.parts(abw).map(
                  (e) => SmartRefresher(
                    controller: c.currentPart().refreshController,
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    child: CustomScrollView(
                      slivers: [
                        (c.currentPart().isAllEmpty(abw))
                            ? SliverToBoxAdapter(
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('什么都没有~'),
                                ],
                              ))
                            : const SliverToBoxAdapter(),
                        _fragmentGroupsBuilder(),
                        _fragmentsBuilder(),
                        SliverToBoxAdapter(
                          child: TextButton(
                            onPressed: () {
                              c.backPart();
                            },
                            child: const Text('back'),
                          ),
                        ),
                      ],
                    ),
                    onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 200));
                      await c.enterPart(null);
                      c.currentPart().refreshController.refreshCompleted();
                    },
                  ),
                ),
          ],
        );
      },
    );
  }

  Widget _fragmentGroupsBuilder() {
    return AbBuilder<GroupListWidgetAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(c.currentPart().indexFragmentGroup(index, abw).title.toString()),
                      onPressed: () {
                        c.enterPart(c.currentPart().indexAbFragmentGroup(index));
                      },
                      onLongPress: () async {
                        Aber.find<HomeAbController>().isFragmentSelecting.refreshEasy((oldValue) => !oldValue);
                      },
                    ),
                  ),
                  AbBuilder<HomeAbController>(
                    builder: (hController, hAwb) {
                      if (hController.isFragmentSelecting(hAwb)) {
                        return AbBuilder<FragmentGroupListPageAbController>(
                          tag: Aber.single,
                          builder: (countC, countAbw) {
                            return Text(
                              '${countC.currentPart().indexSelectedFragmentCountForAllSubgroup(index, countAbw)}/${countC.currentPart().indexFragmentCountForAllSubgroup(index, countAbw)}',
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                  AbBuilder<HomeAbController>(
                    builder: (hController, hAwb) {
                      if (hController.isFragmentSelecting(hAwb)) {
                        return AbBuilder<FragmentGroupListPageAbController>(
                          tag: Aber.single,
                          builder: (selectController, selectAbw) {
                            return IconButton(
                              icon: () {
                                final isSelected = selectController.currentPart().indexIsSelectedForFragmentGroup(index, selectAbw);
                                if (isSelected == null) {
                                  return const FaIcon(FontAwesomeIcons.circleHalfStroke, color: Colors.amber, size: 14);
                                }
                                if (isSelected) {
                                  return const FaIcon(FontAwesomeIcons.solidCircle, color: Colors.amber, size: 14);
                                }
                                return const FaIcon(FontAwesomeIcons.solidCircle, color: Colors.grey, size: 14);
                              }(),
                              onPressed: () async {
                                await selectController.currentPart().selectFragmentGroup(index, selectController.currentPart().indexFragmentGroup(index).id);
                              },
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              );
            },
            childCount: c.currentPart().groupEntities(abw).length,
          ),
        );
      },
    );
  }

  Widget _fragmentsBuilder() {
    return AbBuilder<GroupListWidgetAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      child: Text(c.currentPart().indexFragment(index, abw).content.toString()),
                      onPressed: () {},
                      onLongPress: () {
                        Aber.find<HomeAbController>().isFragmentSelecting.refreshEasy((oldValue) => !oldValue);
                      },
                    ),
                  ),
                  AbBuilder<HomeAbController>(
                    builder: (hController, hAwb) {
                      if (hController.isFragmentSelecting(hAwb)) {
                        return AbBuilder<GroupListWidgetAbController>(
                          tag: Aber.single,
                          builder: (selectController, selectAbw) {
                            return IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.solidCircle,
                                color: selectController.currentPart().indexIsSelectedForFragment(index, selectAbw) ? Colors.amber : Colors.grey,
                                size: 14,
                              ),
                              onPressed: () async {
                                selectController.currentPart().selectFragment(selectController.currentPart().indexFragment(index).id);
                              },
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              );
            },
            childCount: c.currentPart().unitEntities(abw).length,
          ),
        );
      },
    );
  }

  PreferredSize _appBarBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kMinInteractiveDimension),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          color: Colors.white10,
          border: Border(
              // bottom: BorderSide(width: 0.5, color: Colors.grey),
              ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AbBuilder<GroupListWidgetAbController>(
                  tag: Aber.single,
                  builder: (c, abw) {
                    return SingleChildScrollView(
                      controller: c.groupChainController,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      child: Row(
                        children: [
                          ...c.parts(abw).map(
                                (e) => TextButton(
                                  child: Text(
                                    e().fatherGroupEntity?.call(abw) == null ? '~ >' : '${e().fatherGroupEntity!(abw).title} >',
                                  ),
                                  onPressed: () {
                                    c.backPartJump(e);
                                  },
                                ),
                              ),
                          SizedBox(width: MediaQuery.of(context).size.width / 3),
                        ],
                      ),
                    );
                  }),
            ),
            AbBuilder<GroupListWidgetAbController>(
              tag: Aber.single,
              builder: (c, abw) {
                return CustomDropdownBodyButton(
                  initValue: 0,
                  primaryButton: const Icon(Icons.more_horiz),
                  itemAlignment: Alignment.centerLeft,
                  items: [
                    Item(value: 0, text: '添加碎片'),
                    Item(value: 1, text: '添加碎片组'),
                  ],
                  onChanged: (v) {
                    if (v == 0) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => const FragmentGizmoEditPage()));
                    } else if (v == 1) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => const FragmentGroupGizmoEditPage()));
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
