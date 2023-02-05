import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class GroupListWidget<G, U, GC, C extends GroupListWidgetController<G, U, GC>> extends StatelessWidget {
  const GroupListWidget({
    Key? key,
    this.headSliver,
    required this.groupListWidgetController,
    required this.groupChainStrings,
    required this.groupBuilder,
    required this.unitBuilder,
    required this.oneActionBuilder,
    required this.floatingButtonOnPressed,
  }) : super(key: key);
  final C groupListWidgetController;

  final Widget Function(C c, Ab<Group<G, U, GC>> group, Abw abw)? headSliver;
  final String Function(Ab<Group<G, U, GC>> group, Abw abw) groupChainStrings;
  final Widget Function(C c, Ab<Group<G, U, GC>> group, Abw abw) groupBuilder;
  final Widget Function(C c, Ab<Unit<U>> unit, Abw abw) unitBuilder;
  final Widget Function(C c, Abw abw) oneActionBuilder;
  final void Function(C c) floatingButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<GroupListWidgetController<G, U, GC>>(
      putController: groupListWidgetController,
      tag: Aber.single,
      builder: (c, abw) {
        return Scaffold(
          primary: false,
          appBar: _appBarBottom(context),
          body: _body(),
          bottomNavigationBar: _bottomNavigationBar(),
          floatingActionButton: c.isUnitSelecting(abw) ? _floatingActionButton() : null,
        );
      },
    );
  }

  Widget _floatingActionButton() {
    return AbwBuilder(
      builder: (abw) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.amber,
              child: const Text('记'),
              onPressed: () {
                floatingButtonOnPressed(groupListWidgetController);
              },
            ),
            groupListWidgetController.groupChain(abw).first(abw).selectedUnitCount(abw) == 0
                ? const SizedBox()
                : Transform.translate(
                    offset: const Offset(0, -10),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: Colors.amber)),
                      child: Text(groupListWidgetController.groupChain(abw).first(abw).selectedUnitCount(abw).toString()),
                    ),
                  ),
          ],
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    return AbwBuilder(
      builder: (hAbw) {
        if (groupListWidgetController.isUnitSelecting(hAbw)) {
          Widget button({
            required IconData iconData,
            required String label,
            required Function() onPressed,
            Color? color,
          }) {
            return MaterialButton(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              onPressed: onPressed,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(iconData, size: 22, color: color),
                  const SizedBox(height: 5),
                  Text(label, style: TextStyle(fontSize: 12, color: color)),
                ],
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            decoration: const BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  button(iconData: FontAwesomeIcons.penToSquare, label: '编辑', onPressed: () {}),
                  button(iconData: FontAwesomeIcons.copy, label: '复制', onPressed: () {}),
                  button(iconData: FontAwesomeIcons.paste, label: '粘贴', onPressed: () {}),
                  button(iconData: FontAwesomeIcons.arrowRightFromBracket, label: '移动', onPressed: () {}),
                  button(iconData: FontAwesomeIcons.trashCan, label: '删除', color: Colors.red, onPressed: () {}),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _body() {
    return AbBuilder<C>(
      tag: Aber.single,
      builder: (c, tAbw) {
        return IndexedStack(
          index: c.groupChain(tAbw).length - 1,
          children: [
            ...c.groupChain(tAbw).map(
                  (e) => AbwBuilder(
                    builder: (abw) {
                      return SmartRefresher(
                        onRefresh: () async {
                          await c.refreshCurrentGroup();
                          e().refreshController.refreshCompleted();
                        },
                        controller: e(abw).refreshController,
                        child: CustomScrollView(
                          slivers: [
                            e(abw).entity(abw) == null ? SliverToBoxAdapter() : (headSliver?.call(c, e, abw) ?? SliverToBoxAdapter()),
                            (e().groups().isEmpty && e().units().isEmpty)
                                ? SliverToBoxAdapter(
                                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('什么都没有~'),
                                    ],
                                  ))
                                : const SliverToBoxAdapter(),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                                child: Row(
                                  children: [
                                    Text("子组", style: Theme.of(c.context).textTheme.titleLarge),
                                  ],
                                ),
                              ),
                            ),
                            _fragmentGroupsBuilder(),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                                child: Row(
                                  children: [
                                    Text("碎片", style: Theme.of(c.context).textTheme.titleLarge),
                                  ],
                                ),
                              ),
                            ),
                            _fragmentsBuilder(),
                            SliverToBoxAdapter(
                              child: TextButton(
                                onPressed: () async {
                                  await c.backGroup();
                                },
                                child: const Text('back'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
          ],
        );
      },
    );
  }

  Widget _fragmentGroupsBuilder() {
    return AbBuilder<C>(
      tag: Aber.single,
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildListDelegate(
            c.getCurrentGroupAb()(abw).groups(abw).map(
              (e) {
                return AbwBuilder(builder: (abw) => groupBuilder(c, e, abw));
                // return Row(
                //   children: [
                //     Expanded(
                //       child: TextButton(
                //         child: Text(e().currentGroupEntity().toString()),
                //         onPressed: () {
                //           // c.enterPart(c.currentPart().indexAbFragmentGroup(index));
                //         },
                //         onLongPress: () async {
                //           // Aber.find<HomeAbController>().isFragmentSelecting.refreshEasy((oldValue) => !oldValue);
                //         },
                //       ),
                //     ),
                // AbBuilder<HomeAbController>(
                //   builder: (hController, hAwb) {
                //     if (hController.isFragmentSelecting(hAwb)) {
                //       return AbBuilder<FragmentGroupListPageAbController>(
                //         tag: Aber.single,
                //         builder: (countC, countAbw) {
                //           return Text(
                //             '${countC.currentPart().indexSelectedFragmentCountForAllSubgroup(index, countAbw)}/${countC.currentPart().indexFragmentCountForAllSubgroup(index, countAbw)}',
                //           );
                //         },
                //       );
                //     }
                //     return Container();
                //   },
                // ),
                // AbBuilder<HomeAbController>(
                //   builder: (hController, hAwb) {
                //     if (hController.isFragmentSelecting(hAwb)) {
                //       return AbBuilder<FragmentGroupListPageAbController>(
                //         tag: Aber.single,
                //         builder: (selectController, selectAbw) {
                //           return IconButton(
                //             icon: () {
                //               final isSelected = selectController.currentPart().indexIsSelectedForFragmentGroup(index, selectAbw);
                //               if (isSelected == null) {
                //                 return const FaIcon(FontAwesomeIcons.circleHalfStroke, color: Colors.amber, size: 14);
                //               }
                //               if (isSelected) {
                //                 return const FaIcon(FontAwesomeIcons.solidCircle, color: Colors.amber, size: 14);
                //               }
                //               return const FaIcon(FontAwesomeIcons.solidCircle, color: Colors.grey, size: 14);
                //             }(),
                //             onPressed: () async {
                //               await selectController.currentPart().selectFragmentGroup(index, selectController.currentPart().indexFragmentGroup(index).id);
                //             },
                //           );
                //         },
                //       );
                //     }
                //     return Container();
                //   },
                // ),
                //   ],
                // );
              },
            ).toList(),
          ),
        );
      },
    );
  }

  Widget _fragmentsBuilder() {
    return AbBuilder<C>(
      tag: Aber.single,
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildListDelegate(
            c.getCurrentGroupAb()(abw).units(abw).map(
              (e) {
                return AbwBuilder(builder: (abw) => unitBuilder(c, e, abw));
                // return Row(
                //   children: [
                // Expanded(
                //   child: MaterialButton(
                //     child: Text(e().currentGroupEntity().toString()),
                //     onPressed: () {},
                //     // onLongPress: () {
                //     //   Aber.find<HomeAbController>().isFragmentSelecting.refreshEasy((oldValue) => !oldValue);
                //     // },
                //   ),
                // ),
                // AbBuilder<HomeAbController>(
                //   builder: (hController, hAwb) {
                //     if (hController.isFragmentSelecting(hAwb)) {
                //       return AbBuilder<GroupListWidgetController>(
                //         tag: Aber.single,
                //         builder: (selectController, selectAbw) {
                //           return IconButton(
                //             icon: FaIcon(
                //               FontAwesomeIcons.solidCircle,
                //               color: selectController.currentPart().indexIsSelectedForFragment(index, selectAbw) ? Colors.amber : Colors.grey,
                //               size: 14,
                //             ),
                //             onPressed: () async {
                //               selectController.currentPart().selectFragment(selectController.currentPart().indexFragment(index).id);
                //             },
                //           );
                //         },
                //       );
                //     }
                //     return Container();
                //   },
                // ),
                //   ],
                // );
              },
            ).toList(),
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
              child: AbBuilder<C>(
                  tag: Aber.single,
                  builder: (c, abw) {
                    return SingleChildScrollView(
                      controller: c.groupChainScrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      child: Row(
                        children: [
                          ...c.groupChain(abw).map(
                                (e) => AbwBuilder(
                                  builder: (innerAbw) {
                                    return TextButton(
                                      child: Text(
                                        e(innerAbw).entity(innerAbw) == null ? '~ >' : '${groupChainStrings(e, innerAbw)} >',
                                      ),
                                      onPressed: () async {
                                        await c.enterGroup(e);
                                      },
                                    );
                                  },
                                ),
                              ),
                          SizedBox(width: MediaQuery.of(context).size.width / 3),
                        ],
                      ),
                    );
                  }),
            ),
            AbBuilder<C>(
              tag: Aber.single,
              builder: (c, abw) {
                return oneActionBuilder(c, abw);
              },
            ),
          ],
        ),
      ),
    );
  }
}
