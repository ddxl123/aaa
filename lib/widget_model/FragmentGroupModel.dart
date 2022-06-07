import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FragmentGroupModel extends StatelessWidget {
  const FragmentGroupModel({Key? key, required this.modelType}) : super(key: key);

  final FragmentGroupModelType modelType;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentGroupModelAbController>(
      putController: FragmentGroupModelAbController(),
      tag: Aber.hashCodeTag,
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
    return AbBuilder<FragmentGroupModelAbController>(
      tag: Aber.hashCodeTag,
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
                      await c.refreshCurrentPart();
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
    return AbBuilder<FragmentGroupModelAbController>(
      tag: Aber.hashCodeTag,
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return TextButton(
                child: Text(c.currentFragmentGroup(index, abw).title.toString()),
                onPressed: () {
                  c.enterPart(c.currentFragmentGroups()[index]);
                },
              );
            },
            childCount: c.currentFragmentGroups(abw).length,
          ),
        );
      },
    );
  }

  Widget _fragmentsBuilder() {
    return AbBuilder<FragmentGroupModelAbController>(
      tag: Aber.hashCodeTag,
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return TextButton(
                child: Text(c.currentFragment(index, abw).title.toString()),
                onPressed: () {
                  if (modelType == FragmentGroupModelType.add) return;
                },
              );
            },
            childCount: c.currentFragments(abw).length,
          ),
        );
      },
    );
  }

  PreferredSize _appBarBottom(BuildContext context) {
    return PreferredSize(
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          color: Colors.amberAccent,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: AbBuilder<FragmentGroupModelAbController>(
            tag: Aber.hashCodeTag,
            builder: (c, abw) {
              return Row(
                children: [
                  ...c.parts(abw).map(
                        (e) => TextButton(
                          child: Text(
                            e().fatherFragmentGroup?.call(abw) == null ? '~ >' : e().fatherFragmentGroup!(abw).title.toString() + ' >',
                          ),
                          onPressed: () {
                            c.backPartTo(e);
                          },
                        ),
                      ),
                  SizedBox(width: MediaQuery.of(context).size.width / 3)
                ],
              );
            },
          ),
        ),
      ),
      preferredSize: const Size.fromHeight(kMinInteractiveDimension),
    );
  }
}
