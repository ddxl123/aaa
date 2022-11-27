part of aber;

class GroupListWidget<G, U> extends StatelessWidget {
  const GroupListWidget({
    Key? key,
    required this.groupListWidgetController,
    required this.groupBuilder,
    required this.unitBuilder,
  }) : super(key: key);
  final GroupListWidgetController<G, U> groupListWidgetController;

  final Widget Function(Ab<Group<G, U>> group, Abw abw) groupBuilder;
  final Widget Function(Ab<Unit<U>> unit, Abw abw) unitBuilder;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<GroupListWidgetController<G, U>>(
      putController: groupListWidgetController,
      tag: Aber.single,
      builder: (c, abw) {
        return Scaffold(
          primary: false,
          appBar: _appBarBottom(context),
          body: _body(),
        );
      },
    );
  }

  Widget _body() {
    return AbBuilder<GroupListWidgetController<G, U>>(
      tag: Aber.single,
      builder: (c, tAbw) {
        return IndexedStack(
          index: c.groupChain(tAbw).length - 1,
          children: [
            ...c.groupChain(tAbw).map(
                  (e) => AbwBuilder(
                    builder: (abw) {
                      return SmartRefresher(
                        onRefresh: () {
                          e().refreshController.refreshCompleted();
                        },
                        controller: e(abw).refreshController,
                        child: CustomScrollView(
                          slivers: [
                            (e().groups().isEmpty && e().units().isEmpty)
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
    return AbBuilder<GroupListWidgetController<G, U>>(
      tag: Aber.single,
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildListDelegate(
            c.getCurrentGroup()(abw).groups(abw).map(
              (e) {
                return AbwBuilder(builder: (abw) => groupBuilder(e, abw));
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
    return AbBuilder<GroupListWidgetController<G, U>>(
      tag: Aber.single,
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildListDelegate(
            c.getCurrentGroup()(abw).units(abw).map(
              (e) {
                return AbwBuilder(builder: (abw) => unitBuilder(e, abw));
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
              child: AbBuilder<GroupListWidgetController<G, U>>(
                  tag: Aber.single,
                  builder: (c, abw) {
                    return SingleChildScrollView(
                      controller: c.groupChainScrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      child: Row(
                        children: [
                          ...c.groupChain(abw).map(
                                (e) => TextButton(
                                  child: Text(
                                    e().currentGroup(abw) == null ? '~ >' : '${e().currentGroupEntity(abw)} >',
                                  ),
                                  onPressed: () async {
                                    await c.enterGroup(e);
                                  },
                                ),
                              ),
                          SizedBox(width: MediaQuery.of(context).size.width / 3),
                        ],
                      ),
                    );
                  }),
            ),
            AbBuilder<GroupListWidgetController<G, U>>(
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
                    // if (v == 0) {
                    //   Navigator.push(context, MaterialPageRoute(builder: (ctx) => const FragmentGizmoEditPage()));
                    // } else if (v == 1) {
                    //   Navigator.push(context, MaterialPageRoute(builder: (ctx) => const FragmentGroupGizmoEditPage()));
                    // }
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
