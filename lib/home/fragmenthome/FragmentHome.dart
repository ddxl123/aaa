import 'package:aaa/home/fragmenthome/FragmentHomeGetController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/show/ShowWrapper.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FragmentHome extends StatefulWidget {
  const FragmentHome({Key? key}) : super(key: key);

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AbBuilder<FragmentHomeGetController>(
      controller: FragmentHomeGetController(),
      builder: (controller, abw) {
        return Scaffold(
          appBar: AppBar(
            actions: [_addButton()],
            bottom: _appBarBottom(),
          ),
          body: _body(),
        );
      },
    );
  }

  PreferredSize _appBarBottom() {
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
          child: AbBuilder<FragmentHomeGetController>(
            builder: (controller, abw) {
              return Row(
                children: [
                  ...controller.parts(abw).map(
                        (e) => TextButton(
                          child: Text(
                            e().fatherFragmentGroup?.call(abw) == null ? '~ >' : e().fatherFragmentGroup!(abw).title.toString() + ' >',
                          ),
                          onPressed: () {
                            controller.backPartTo(e);
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

  Widget _body() {
    return AbBuilder<FragmentHomeGetController>(
      builder: (controller, abw) {
        return IndexedStack(
          index: controller.parts(abw).length - 1,
          children: [
            ...controller.parts(abw).map(
                  (e) => SmartRefresher(
                    controller: controller.currentPart().refreshController,
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    child: CustomScrollView(
                      slivers: [
                        _fragmentGroupsBuilder(),
                        _fragmentsBuilder(),
                        SliverToBoxAdapter(
                          child: TextButton(
                            onPressed: () {
                              controller.backPart();
                            },
                            child: const Text('back'),
                          ),
                        ),
                      ],
                    ),
                    onRefresh: () async {
                      await Future.delayed(Duration(milliseconds: 200));
                      await controller.refreshCurrentPart();
                      controller.currentPart().refreshController.refreshCompleted();
                    },
                  ),
                ),
          ],
        );
      },
    );
  }

  Widget _fragmentGroupsBuilder() {
    return AbBuilder<FragmentHomeGetController>(
      builder: (controller, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return TextButton(
                child: Text(controller.currentFragmentGroup(index, abw).title.toString()),
                onPressed: () {
                  Aber.find<FragmentHomeGetController>().enterPart(controller.currentFragmentGroups()[index]);
                },
              );
            },
            childCount: controller.currentFragmentGroups(abw).length,
          ),
        );
      },
    );
  }

  Widget _fragmentsBuilder() {
    return AbBuilder<FragmentHomeGetController>(
      builder: (controller, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Text(controller.currentFragment(index, abw).title.toString());
            },
            childCount: controller.currentFragments(abw).length,
          ),
        );
      },
    );
  }

  Widget _addButton() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        customButton: const Icon(Icons.add),
        items: const [
          DropdownMenuItem(
            child: Text('添加碎片'),
            value: 0,
          ),
          DropdownMenuItem(
            child: Text('添加碎片组'),
            value: 1,
          ),
        ],
        onChanged: (v) {
          if (v == 0) {
            showWrapperInput(
              context: context,
              title: '添加碎片',
              textFields: [const DialogTextField()],
              okLabel: '添加',
              cancelLabel: '取消',
              firstHandle: (String firstContent) {
                Aber.find<FragmentHomeGetController>().addFragment(firstContent);
              },
            );
          } else if (v == 1) {
            showWrapperInput(
              context: context,
              title: '添加碎片组',
              textFields: [const DialogTextField()],
              okLabel: '添加',
              cancelLabel: '取消',
              firstHandle: (String firstContent) {
                Aber.find<FragmentHomeGetController>().addFragmentGroup(firstContent);
              },
            );
          }
        },
        dropdownWidth: 150,
      ),
    );
  }
}
