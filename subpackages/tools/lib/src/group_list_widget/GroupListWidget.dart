import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class GroupListWidget<G, U, UR, C extends GroupListWidgetController<G, U, UR>> extends StatefulWidget {
  const GroupListWidget({
    Key? key,
    required this.headSliver,
    required this.groupListWidgetController,
    required this.groupChainStrings,
    required this.groupBuilder,
    required this.unitBuilder,
    this.leftActionBuilder,
    this.rightActionBuilder,
    required this.floatingButtonOnPressed,
  }) : super(key: key);
  final C groupListWidgetController;

  final Widget Function(C c, Ab<Group<G, U, UR>> group, Abw abw)? headSliver;
  final String Function(Ab<Group<G, U, UR>> group, Abw abw) groupChainStrings;
  final Widget Function(C c, Ab<Group<G, U, UR>> group, Abw abw) groupBuilder;
  final Widget Function(C c, Ab<Unit<U, UR>> unit, Abw abw) unitBuilder;
  final Widget Function(C c, Abw abw)? leftActionBuilder;
  final Widget Function(C c, Abw abw)? rightActionBuilder;
  final void Function(C c) floatingButtonOnPressed;

  @override
  State<GroupListWidget<G, U, UR, C>> createState() => _GroupListWidgetState<G, U, UR, C>();
}

class _GroupListWidgetState<G, U, UR, C extends GroupListWidgetController<G, U, UR>> extends State<GroupListWidget<G, U, UR, C>> {
  late final C groupListWidgetController;

  @override
  void initState() {
    super.initState();
    groupListWidgetController = widget.groupListWidgetController;
  }

  @override
  Widget build(BuildContext context) {
    return AbBuilder<GroupListWidgetController<G, U, UR>>(
      putController: groupListWidgetController,
      tag: Aber.single,
      builder: (c, abw) {
        return Scaffold(
          extendBody: true,
          primary: false,
          body: _body(),
          floatingActionButton: c.isSelecting(abw) ? _floatingActionButton() : null,
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
                  AbBuilder<C>(
                    tag: Aber.single,
                    builder: (c, abw) {
                      return widget.leftActionBuilder?.call(c, abw) ?? Container();
                    },
                  ),
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
                                      child: c.groupChain(abw)[index](innerAbw).getDynamicGroupEntity(innerAbw) == null
                                          ? Icon(Icons.circle, size: 5)
                                          : Text(
                                              widget.groupChainStrings(c.groupChain(abw)[index], innerAbw),
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
                      },
                    ),
                  ),
                  AbBuilder<C>(
                    tag: Aber.single,
                    builder: (c, abw) {
                      return widget.rightActionBuilder?.call(c, abw) ?? Container();
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
                                  widget.headSliver == null
                                      ? SliverToBoxAdapter()
                                      : _Head<G, U, UR, C>(
                                          mainState: this,
                                          c: c,
                                          e: e,
                                        ),
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
              },
            ).toList(),
          ),
        );
      },
    );
  }
}

class _Head<G, U, UR, C extends GroupListWidgetController<G, U, UR>> extends StatefulWidget {
  const _Head({super.key, required this.mainState, required this.c, required this.e});

  final _GroupListWidgetState<G, U, UR, C> mainState;
  final C c;
  final Ab<Group<G, U, UR>> e;

  @override
  State<_Head<G, U, UR, C>> createState() => _HeadState<G, U, UR, C>();
}

class _HeadState<G, U, UR, C extends GroupListWidgetController<G, U, UR>> extends State<_Head<G, U, UR, C>> {
  double _expandedHeight = double.maxFinite;
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
        final height = renderBox?.size.height;
        if (height != _expandedHeight) {
          setState(() {
            _expandedHeight = height ?? 0;
          });
        }
      },
    );
    return AbwBuilder(
      builder: (abw) {
        return SliverAppBar(
          expandedHeight: _expandedHeight,
          collapsedHeight: _expandedHeight > MediaQuery.of(context).size.height - 100 ? _expandedHeight : null,
          floating: false,
          snap: false,
          toolbarHeight: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    key: _key,
                    child: widget.mainState.widget.headSliver?.call(widget.c, widget.e, abw),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
