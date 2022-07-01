import 'package:aaa/page/normal/FragmentInMemoryGroupPageAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/MemoryGroupModelAbController.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FragmentInMemoryGroupPage extends StatelessWidget {
  const FragmentInMemoryGroupPage({Key? key, required this.outerMemoryGroup}) : super(key: key);
  final Ab<BasicSingleOuterMemoryGroup> outerMemoryGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AbBuilder<FragmentInMemoryGroupPageAbController>(
        putController: FragmentInMemoryGroupPageAbController(outerMemoryGroup),
        builder: (putC, putAbw) {
          return SmartRefresher(
            controller: putC.refreshController,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: CustomScrollView(
              slivers: [
                _memoryRule(),
                _fragments(),
              ],
            ),
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              await putC.refreshPage();
              putC.refreshController.refreshCompleted();
            },
          );
        },
      ),
    );
  }

  Widget _memoryRule() {
    return AbBuilder<FragmentInMemoryGroupPageAbController>(
      builder: (c, abw) {
        return SliverToBoxAdapter(
          child: Card(
            child: Column(
              children: [
                const Text('当前使用的记忆规则：'),
                Text((c.memoryRule(abw)?.title).toString()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _fragments() {
    return AbBuilder<FragmentInMemoryGroupPageAbController>(
      builder: (c, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return TextButton(
                onPressed: () {},
                child: Text(c.fragments()[index](abw).title.toString()),
              );
            },
            childCount: c.fragments(abw).length,
          ),
        );
      },
    );
  }
}
