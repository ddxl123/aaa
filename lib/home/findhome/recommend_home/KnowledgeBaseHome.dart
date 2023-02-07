import 'package:aaa/single_sheet/showCategoriesBottomSheet.dart';
import 'package:drift_main/share_common/share_enum.dart';
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
          body: Column(
            children: [
              SizedBox(height: 5),
              _mainCategoriesWidget(),
              SizedBox(height: 10),
              Expanded(
                child: AbBuilder<KnowledgeBaseHomeAbController>(
                  builder: (c, abw) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _subCategoriesWidget(),
                        _contentWidget(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _mainCategoriesWidget() {
    return AbBuilder<KnowledgeBaseHomeAbController>(
      builder: (c, abw) {
        return Container(
          color: Colors.white,
          child: Row(
            children: [
              IconButton(
                icon: Transform.scale(
                  child: const Icon(Icons.dehaze, color: Colors.grey),
                  scaleX: 0.5,
                  scaleY: 1.0,
                ),
                onPressed: () {
                  showCategoriesSheet(context: c.context);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...c.categories(abw).map(
                        (e) {
                          return TextButton(
                            child: AbwBuilder(
                              builder: (abw) {
                                return Text(
                                  e.name,
                                  style: TextStyle(
                                    color: c.getSelectedMainCategory(abw) == e ? Colors.black : Colors.grey,
                                  ),
                                );
                              },
                            ),
                            onPressed: () {
                              c.changeTo(mainCategory: e, subCategory: null, currentSortType: null);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _subCategoriesWidget() {
    return AbBuilder<KnowledgeBaseHomeAbController>(
      builder: (c, abw) {
        return Container(
          height: MediaQuery.of(c.context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                ...c.getSelectedMainCategory(abw)?.subCategories.map(
                      (e) {
                        var text = e.name;
                        if (e.name.length == 5 || e.name.length == 6) {
                          text = e.name.substring(0, 3) + "\n" + e.name.substring(3);
                        } else if (e.name.length > 8) {
                          text = e.name.substring(0, 4) + "\n" + e.name.substring(4, 7) + "...";
                        } else if (e.name.length > 4) {
                          text = e.name.substring(0, 4) + "\n" + e.name.substring(4);
                        }
                        return MaterialButton(
                          visualDensity: VisualDensity(horizontal: -3),
                          child: Text(
                            text,
                            style: TextStyle(color: c.getSelectedSubCategory(abw) == e ? Colors.black : Colors.grey),
                          ),
                          onPressed: () {
                            c.changeTo(mainCategory: null, subCategory: e, currentSortType: null);
                          },
                        );
                      },
                    ) ??
                    [],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _contentWidget() {
    return AbBuilder<KnowledgeBaseHomeAbController>(
      builder: (c, abw) {
        return Expanded(
          child: SmartRefresher(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            controller: c.refreshController,
            header: ClassicHeader(),
            onRefresh: () async {
              await c.refreshPage();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AbwBuilder(
                        builder: (abw) {
                          return CustomDropdownBodyButton<CurrentSortType>(
                            primaryButton: Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                              child: Row(
                                children: [
                                  Transform.scale(
                                    child: const Icon(Icons.sort, color: Colors.blue, size: 18),
                                    scaleX: 0.8,
                                    scaleY: 1.0,
                                  ),
                                  Text(
                                    filter(
                                      from: c.currentSortTypeAb(abw),
                                      targets: {
                                        [CurrentSortType.by_hot]: () => "按热度",
                                        [CurrentSortType.by_time]: () => "按时间",
                                        [CurrentSortType.by_random]: () => "随机",
                                      },
                                      orElse: null,
                                    ),
                                    style: TextStyle(color: Colors.blue, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            initValue: c.currentSortTypeAb(abw),
                            items: [
                              Item(value: CurrentSortType.by_hot, text: "按热度"),
                              Item(value: CurrentSortType.by_time, text: "按时间"),
                              Item(value: CurrentSortType.by_random, text: "随机"),
                            ],
                            onChanged: (v) async {
                              await c.changeTo(mainCategory: null, subCategory: null, currentSortType: v);
                              c.currentSortTypeAb.refreshEasy((oldValue) => v!);
                            },
                          );
                        },
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  ...List.generate(
                    20,
                    (index) => Card(
                      child: Container(height: 100),
                    ),
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
