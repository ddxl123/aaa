import 'package:aaa/home/findhome/recommend_home/RecommendHomeAbController.dart';
import 'package:aaa/single_sheet/showCategoriesBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
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
                      icon: Transform.scale(
                        child: const Icon(Icons.dehaze, color: Colors.grey),
                        scaleX: 0.5,
                        scaleY: 1.0,
                      ),
                      onPressed: () {
                        showCategoriesSheet(context: context);
                      },
                    ),
                    CustomDropdownBodyButton<int>(
                      primaryButton: Icon(Icons.sort, color: Colors.grey),
                      initValue: 0,
                      items: [
                        Item(value: 0, text: "按热度"),
                        Item(value: 1, text: "按时间"),
                        Item(value: 2, text: "随机"),
                      ],
                      onChanged: (v) {
                        c;
                      },
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
