import 'dart:convert';

import 'package:aaa/single_dialog/showSelectFragmentGroupDialog.dart';
import 'package:aaa/single_sheet/showCategoriesBottomSheet.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(child: ElevatedButton(onPressed: () {}, child: Text("碎片库"))),
                  SizedBox(width: 10),
                  Expanded(child: ElevatedButton(onPressed: () {}, child: Text("算法库"))),
                  SizedBox(width: 10),
                  Expanded(child: ElevatedButton(onPressed: () {}, child: Text("模板库"))),
                  SizedBox(width: 10),
                ],
              ),
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
                              c.changeTo(mainCategory: e, subCategory: null, currentKnowledgeBaseContentSortType: null);
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
          height: MediaQuery
              .of(c.context)
              .size
              .height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                ...c
                    .getSelectedMainCategory(abw)
                    ?.subCategories
                    .map(
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
                        c.changeTo(mainCategory: null, subCategory: e, currentKnowledgeBaseContentSortType: null);
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
                          return CustomDropdownBodyButton<KnowledgeBaseContentSortType>(
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
                                      from: c.currentKnowledgeBaseContentSortTypeAb(abw),
                                      targets: {
                                        [KnowledgeBaseContentSortType.by_random]: () => "随机",
                                        [KnowledgeBaseContentSortType.by_hot]: () => "按热度",
                                        [KnowledgeBaseContentSortType.by_create_time]: () => "按创建时间",
                                        [KnowledgeBaseContentSortType.by_publish_time]: () => "按发布时间",
                                        [KnowledgeBaseContentSortType.by_update_time]: () => "按更新时间",
                                        [KnowledgeBaseContentSortType.by_like_count]: () => "按点赞量",
                                        [KnowledgeBaseContentSortType.by_save_count]: () => "按收集量",
                                      },
                                      orElse: null,
                                    ),
                                    style: TextStyle(color: Colors.blue, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            initValue: c.currentKnowledgeBaseContentSortTypeAb(abw),
                            items: [
                              Item(value: KnowledgeBaseContentSortType.by_random, text: "随机"),
                              Item(value: KnowledgeBaseContentSortType.by_hot, text: "按热度"),
                              Item(value: KnowledgeBaseContentSortType.by_create_time, text: "按创建时间"),
                              Item(value: KnowledgeBaseContentSortType.by_publish_time, text: "按发布时间"),
                              Item(value: KnowledgeBaseContentSortType.by_update_time, text: "按更新时间"),
                              Item(value: KnowledgeBaseContentSortType.by_like_count, text: "按点赞量"),
                              Item(value: KnowledgeBaseContentSortType.by_save_count, text: "按收集量"),
                            ],
                            onChanged: (v) async {
                              await c.changeTo(mainCategory: null, subCategory: null, currentKnowledgeBaseContentSortType: v);
                              c.currentKnowledgeBaseContentSortTypeAb.refreshEasy((oldValue) => v!);
                            },
                          );
                        },
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  ...c.knowledgeBaseContentListAb(abw).map(
                        (e) {
                      return AbwBuilder(
                        builder: (abw) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(e(abw).fragment_group.title, style: Theme
                                            .of(c.context)
                                            .textTheme
                                            .titleLarge),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text("448百科知识选择、填空", style: TextStyle(color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: VerticalDivider(color: Colors.black12),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.circle, size: 8),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      "dog 的中文翻译是什么的中文翻译是什么的中文翻译是什么的中文翻译是什么的中文翻译是什么的中文翻译是什么？",
                                                      style: TextStyle(
                                                        decoration: TextDecoration.underline,
                                                        decorationColor: Colors.grey,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(Icons.circle, size: 8),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "人的行为产生的本质是什么？",
                                                    style: TextStyle(
                                                      decoration: TextDecoration.underline,
                                                      decorationColor: Colors.grey,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Wrap(
                                          spacing: 5,
                                          children: [
                                            Container(
                                              child: Text(
                                                "数学",
                                                style: TextStyle(fontSize: 12, color: Colors.black54),
                                              ),
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(color: Color.fromARGB(255, 230, 230, 230), borderRadius: BorderRadius.circular(3)),
                                            ),
                                            Container(
                                              child: Text(
                                                "英语",
                                                style: TextStyle(fontSize: 12, color: Colors.black54),
                                              ),
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(color: Color.fromARGB(255, 230, 230, 230), borderRadius: BorderRadius.circular(3)),
                                            ),
                                            Container(
                                              child: Text(
                                                "四级英语",
                                                style: TextStyle(fontSize: 12, color: Colors.black54),
                                              ),
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(color: Color.fromARGB(255, 230, 230, 230), borderRadius: BorderRadius.circular(3)),
                                            ),
                                            Container(
                                              child: Text(
                                                "···",
                                                style: TextStyle(fontSize: 12, color: Colors.black54),
                                              ),
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(color: Color.fromARGB(255, 230, 230, 230), borderRadius: BorderRadius.circular(3)),
                                            ),
                                            ...e(abw).fragment_group.tags.jsonToArray().map((e) => Text(e)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.puzzlePiece, size: 14, color: Colors.orange),
                                      Text(" 13546", style: TextStyle(color: Colors.orange)),
                                      Spacer(),
                                      Text(
                                        "1304 赞 · 146 评论 · ",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      MaterialButton(
                                        child: Text(
                                          "82 收集",
                                          style: TextStyle(color: Colors.green, fontSize: 18),
                                        ),
                                        visualDensity: kMinVisualDensity,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () {
                                          c.collect(whichKnowledgeBaseContentAb: e);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
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
