import 'package:aaa/single_sheet/showCategoriesBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

import 'KnowledgeBaseHomeAbController.dart';

class KnowledgeBaseHome extends StatelessWidget {
  const KnowledgeBaseHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<KnowledgeBaseHomeAbController>(
      putController: KnowledgeBaseHomeAbController(),
      builder: (c, abw) {
        return Scaffold(
          body: SmartRefresher(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            header: ClassicHeader(),
            controller: c.refreshController,
            onRefresh: () async {
              await c.refresh();
              c.refreshController.refreshCompleted();
            },
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AbwBuilder(
                    builder: (abw) {
                      return Row(
                        children: [
                          ...c.categories(abw).map(
                            (e) {
                              return TextButton(
                                style: ButtonStyle(
                                  visualDensity: kMinVisualDensity,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 5, vertical: 0)),
                                ),
                                onPressed: () {
                                  logger.outNormal(print: "-${e.name}-");
                                },
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
                          ),
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
                      );
                    },
                  ),
                ),
                ...List.generate(
                  20,
                  (index) => SizedBox(
                    child: Text("data"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
