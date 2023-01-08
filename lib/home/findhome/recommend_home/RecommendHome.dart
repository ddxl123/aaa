import 'package:aaa/home/findhome/recommend_home/RecommendHomeAbController.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class RecommendHome extends StatelessWidget {
  const RecommendHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<RecommendHomeAbController>(
      putController: RecommendHomeAbController(),
      builder: (c, abw) {
        return Scaffold(
          appBar: CustomNarrowAppBar(
            isDivider: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Row(
                children: [
                  const Text("datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata"),
                ],
              ),
            ),
            actions: [
              IconButton(
                style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                icon: const Icon(Icons.expand_more),
                onPressed: () {},
              ),
            ],
          ),
          body: Text("data"),
        );
      },
    );
  }
}
