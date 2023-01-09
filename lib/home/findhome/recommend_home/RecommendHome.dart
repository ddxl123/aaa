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
          body: CustomScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverAppBar(
                toolbarHeight: 0,
                bottom: CustomNarrowAppBar(
                  isDivider: true,
                  child: Container(
                    height: kMinInteractiveDimension,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      scrollDirection: Axis.horizontal,
                      child: AbwBuilder(
                        builder: (abw) {
                          return Row(
                            children: c.categories(abw).map(
                              (e) {
                                return TextButton(
                                  style: ButtonStyle(
                                    visualDensity: kMinVisualDensity,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
                                  ),
                                  onPressed: () {},
                                  child: AbwBuilder(
                                    builder: (abw) {
                                      return Text(
                                        e.name,
                                        style: TextStyle(
                                          color: c.getSelectedCategory(abw) == e ? Colors.black : Colors.grey,
                                          fontSize: 14,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ).toList(),
                          );
                        },
                      ),
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
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(
                  height: 200,
                  child: Text('data'),
                ),
                SizedBox(
                  height: 200,
                  child: Text('data'),
                ),
                SizedBox(
                  height: 200,
                  child: Text('data'),
                ),
                SizedBox(
                  height: 200,
                  child: Text('data'),
                ),
                SizedBox(
                  height: 200,
                  child: Text('data'),
                ),
                SizedBox(
                  height: 200,
                  child: Text('data'),
                ),
                SizedBox(
                  height: 200,
                  child: Text('data'),
                ),
              ]))
            ],
          ),
        );
      },
    );
  }
}
