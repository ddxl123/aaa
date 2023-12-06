import 'dart:convert';

import 'package:aaa/global/tool_widgets/CustomImageWidget.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:aaa/tool/other.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;

import 'KnowledgeBaseHomeAbController.dart';

class KnowledgeBaseHome extends StatelessWidget {
  const KnowledgeBaseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AbBuilder<KnowledgeBaseHomeAbController>(
      putController: KnowledgeBaseHomeAbController(),
      builder: (c, abw) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(height: 5),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: AbwBuilder(
                            builder: (cAbw) {
                              return Row(
                                children: [
                                  Icon(Icons.filter_list, size: 18, color: Colors.grey),
                                  Text(
                                    c.selectedCategoriesAb(cAbw).isEmpty ? "分类" : c.selectedCategoriesAb(cAbw).join(","),
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        onTap: () {
                          c.categorySelect();
                        },
                      ),
                    ),
                    const Spacer(),
                    AbwBuilder(
                      builder: (tAbw) {
                        return CustomDropdownBodyButton(
                          primaryButton: Row(
                            children: [
                              Text(
                                c.knowledgeBaseContentSortTypeAb(tAbw).text,
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              const Icon(Icons.sort, size: 18, color: Colors.grey),
                            ],
                          ),
                          initValue: c.knowledgeBaseContentSortTypeAb(tAbw),
                          items: [
                            ...KnowledgeBaseContentSortType.values.map(
                              (e) => CustomItem(value: e, text: e.text),
                            ),
                          ],
                          onChanged: (v) {
                            c.knowledgeBaseContentSortTypeAb.refreshEasy((oldValue) => v!);
                            c.refreshController.requestRefresh();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: AbwBuilder(
                  builder: (rAbw) {
                    return SmartRefresher(
                      controller: c.refreshController,
                      header: ClassicHeader(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...c.fragmentGroupsAb(rAbw).map(
                              (e) {
                                return GestureDetector(
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          ForceCloudImageWidget(
                                            size: globalFragmentGroupCoverRatio * 100,
                                            cloudPath: e.fragment_group.cover_cloud_path,
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        e.fragment_group.title,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    // TODO: 热度功能
                                                    // Text("热度333", style: TextStyle(color: Colors.orange)),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                AbwBuilder(
                                                  builder: (cAbw) {
                                                    return Wrap(
                                                      spacing: 5,
                                                      runSpacing: 5,
                                                      children: [
                                                        ...() {
                                                          final subs = <FragmentGroupTag>[];
                                                          if (e.fragment_group_tags.length > 3) {
                                                            subs.addAll(e.fragment_group_tags.sublist(0, 3));
                                                          } else {
                                                            subs.addAll(e.fragment_group_tags);
                                                          }
                                                          return subs.map(
                                                            (t) {
                                                              return Container(
                                                                child: Text(t.tag, style: TextStyle(fontSize: 12, color: Colors.grey)),
                                                                padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.grey),
                                                                  borderRadius: BorderRadius.circular(5),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }(),
                                                        if (e.fragment_group_tags.length > 3)
                                                          Transform.scale(
                                                            child: Text("▶", style: TextStyle(color: Colors.grey)),
                                                            scaleX: 0.5,
                                                          ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        () {
                                                          final text = q.Document.fromJson(jsonDecode(e.fragment_group.profile)).toPlainText().trim();
                                                          return text.isEmpty ? "无简介" : text;
                                                        }(),
                                                        style: TextStyle(color: Colors.grey),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.favorite,
                                                          size: 18,
                                                          color: e.liked_id_for_current_logined == null ? Colors.grey : Colors.red,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          e.liked_count.toString(),
                                                          style: TextStyle(color: Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                    // TODO: 评论功能
                                                    // SizedBox(width: 20),
                                                    // Icon(Icons.mode_comment_outlined, size: 20, color: Colors.grey),
                                                    // Text("999+", style: TextStyle(color: Colors.grey)),
                                                    SizedBox(width: 15),
                                                    InkWell(
                                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                                      child: Padding(
                                                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.download_outlined, size: 32, color: Colors.green),
                                                            Text(
                                                              e.saved_count.toString(),
                                                              style: TextStyle(color: Colors.grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () {},
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    pushToFragmentGroupListView(context: context, enterFragmentGroupId: e.fragment_group.id, userId: e.fragment_group.creator_user_id);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      onRefresh: () {
                        c.refresh();
                      },
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
}
