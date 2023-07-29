import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class GroupListWidget<G, U, C extends GroupListWidgetController<G, U>> extends StatefulWidget {
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

  final Widget Function(C c, Ab<Group<G, U>> group, Abw abw)? headSliver;
  final String Function(Ab<Group<G, U>> group, Abw abw) groupChainStrings;
  final Widget Function(C c, Ab<Group<G, U>> group, Abw abw) groupBuilder;
  final Widget Function(C c, Ab<Unit<U>> unit, Abw abw) unitBuilder;
  final Widget Function(C c, Abw abw) oneActionBuilder;
  final void Function(C c) floatingButtonOnPressed;

  @override
  State<GroupListWidget<G, U, C>> createState() => _GroupListWidgetState<G, U, C>();
}

class _GroupListWidgetState<G, U, C extends GroupListWidgetController<G, U>> extends State<GroupListWidget<G, U, C>> {
  late final C groupListWidgetController;

  @override
  void initState() {
    super.initState();
    groupListWidgetController = widget.groupListWidgetController;
  }

  @override
  Widget build(BuildContext context) {
    return AbBuilder<GroupListWidgetController<G, U>>(
      putController: groupListWidgetController,
      tag: Aber.single,
      builder: (c, abw) {
        return Scaffold(
          extendBody: true,
          primary: false,
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
                widget.floatingButtonOnPressed(groupListWidgetController);
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

          return Card(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    button(iconData: FontAwesomeIcons.copy, label: '克隆', onPressed: () {}),
                    button(iconData: FontAwesomeIcons.clone, label: '复用', onPressed: () {}),
                    button(iconData: FontAwesomeIcons.penToSquare, label: '修改', onPressed: () {}),
                    button(iconData: FontAwesomeIcons.arrowRightFromBracket, label: '移动', onPressed: () {}),
                    button(iconData: FontAwesomeIcons.trashCan, label: '删除', color: Colors.red, onPressed: () {}),
                  ],
                ),
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
        return Column(
          children: [
            SizedBox(height: 5),
            Container(
              height: kMinInteractiveDimension,
              child: Row(
                children: [
                  Expanded(
                    child: AbBuilder<C>(
                      tag: Aber.single,
                      builder: (c, abw) {
                        return ListView.separated(
                          shrinkWrap: true,
                          controller: c.groupChainScrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                          itemCount: c.groupChain(abw).length,
                          itemBuilder: (BuildContext context, int index) {
                            return AbwBuilder(
                              builder: (innerAbw) {
                                return Row(
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                        visualDensity: kMinVisualDensity,
                                      ),
                                      child: Text(
                                        c.groupChain(abw)[index](innerAbw).entity(innerAbw) == null ? '~' : '${widget.groupChainStrings(c.groupChain(abw)[index], innerAbw)}',
                                      ),
                                      onPressed: () async {
                                        await c.enterGroup(c.groupChain(abw)[index]);
                                      },
                                    ),
                                    if (c.groupChain(abw).length - 1 == index) SizedBox(width: MediaQuery.of(context).size.width / 3),
                                  ],
                                );
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Icon(Icons.chevron_right);
                          },
                        );
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
                                            e(innerAbw).entity(innerAbw) == null ? '~ >' : '${widget.groupChainStrings(e, innerAbw)} >',
                                          ),
                                          onPressed: () async {
                                            await c.enterGroup(e);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                              SizedBox(width: MediaQuery.of(c.context).size.width / 3),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  AbBuilder<C>(
                    tag: Aber.single,
                    builder: (c, abw) {
                      return widget.oneActionBuilder(c, abw);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
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
                                  e(abw).entity(abw) == null ? SliverToBoxAdapter() : (widget.headSliver?.call(c, e, abw) ?? SliverToBoxAdapter()),
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
                                          Text("子组", style: TextStyle(color: Colors.grey)),
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
                                          Text("碎片", style: TextStyle(color: Colors.grey)),
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
                                      child: const Text('返回'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                ],
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
        return SliverToBoxAdapter(
          child: Column(
            children: [
              ...c.getCurrentGroupAb()(abw).groups(abw).map(
                (e) {
                  return AbwBuilder(builder: (abw) => widget.groupBuilder(c, e, abw));
                },
              ).toList(),
            ],
          ),
        );
        return SliverList(
          delegate: SliverChildListDelegate(
            c.getCurrentGroupAb()(abw).groups(abw).map(
              (e) {
                return AbwBuilder(builder: (abw) => widget.groupBuilder(c, e, abw));
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
                return AbwBuilder(builder: (abw) => widget.unitBuilder(c, e, abw));
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
}
