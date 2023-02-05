import 'package:aaa/home/findhome/recommend_home/KnowledgeBaseHome.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

import 'FindHomeAbController.dart';

class FindHome extends StatelessWidget {
  const FindHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<FindHomeAbController>(
      putController: FindHomeAbController(),
      builder: (c, abw) {
        return Scaffold(
          appBar: CustomTabAppBar(
            tabController: c.tabController,
            tabs: const [
              Tab(child: Text("热门")),
              Tab(child: Text("推荐")),
              Tab(child: Text("知识库")),
              Tab(child: Text("求制作")),
              Tab(child: Text("关注")),
            ],
            otherWidgets: [
              IconButton(
                style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                icon: const FaIcon(FontAwesomeIcons.magnifyingGlass, size: 20),
                onPressed: () {},
              ),
              IconButton(
                style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                icon: const FaIcon(FontAwesomeIcons.bell, size: 22),
                onPressed: () {},
              ),
              const SizedBox(width: 5),
            ],
          ),
          body: TabBarView(
            controller: c.tabController,
            children: [
              KeepStateWidget(
                builder: (_) => const Text('热门'),
              ),
              KeepStateWidget(
                builder: (_) => const Text("推荐"),
              ),
              KeepStateWidget(
                builder: (_) => const KnowledgeBaseHome(),
              ),
              KeepStateWidget(
                builder: (_) => const Text('求制作'),
              ),
              KeepStateWidget(
                builder: (_) => const Text('关注'),
              ),
            ],
          ),
        );
      },
    );
  }
}
