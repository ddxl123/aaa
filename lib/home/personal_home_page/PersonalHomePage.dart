import 'dart:convert';

import 'package:aaa/global/tool_widgets/CustomImageWidget.dart';
import 'package:aaa/home/personal_home_page/PersonalHomePageAbController.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';

class PersonalHomePage extends StatefulWidget {
  const PersonalHomePage({super.key, required this.userId});

  final int userId;

  @override
  State<PersonalHomePage> createState() => _PersonalHomePageState();
}

class _PersonalHomePageState extends State<PersonalHomePage> {
  late final PersonalHomePageAbController personalHomePageAbController;

  @override
  void initState() {
    super.initState();
    personalHomePageAbController = PersonalHomePageAbController(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbBuilder<PersonalHomePageAbController>(
        putController: personalHomePageAbController,
        builder: (c, abw) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                ),
                _userInfo(),
                SliverAppBar(
                  elevation: 0,
                  toolbarHeight: 0,
                  primary: false,
                  pinned: true,
                  backgroundColor: Colors.white,
                  bottom: TabBar(
                    controller: c.tabController,
                    tabs: [
                      Tab(text: "TA的碎片"),
                      Tab(text: "TA的发布"),
                      // TODO: TA的动态
                      // Tab(text: "TA的动态"),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: c.tabController,
              children: [
                KeepStateWidget(
                  child: _fragment(),
                ),
                KeepStateWidget(
                  child: _publishFragmentGroups(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _userInfo() {
    return SliverToBoxAdapter(
      child: AbBuilder<PersonalHomePageAbController>(
        builder: (c, abw) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                GestureDetector(
                  child: Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    child: ForceCloudImageWidget(
                      size: Size(globalUserAvatarSquareSide, globalUserAvatarSquareSide),
                      cloudPath: c.userAvatarCloudPath(abw),
                    ),
                  ),
                  onTap: () async {
                    await c.showAvatar();
                  },
                ),
                const SizedBox(width: 10),
                AbwBuilder(
                  builder: (abw) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.userName(abw) ?? "加载中", style: Theme.of(c.context).textTheme.headlineSmall),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            GestureDetector(
                              child: Row(
                                children: [
                                  Text("关注 ", style: const TextStyle(color: Colors.grey)),
                                  Text(c.followCountAb(abw) > 9999 ? "9999+" : c.followCountAb(abw).toString()),
                                ],
                              ),
                              onTap: () {
                                pushToFollowListPage(context: context, userId: widget.userId, followOrBeFollowed: true);
                              },
                            ),
                            Text("  |  ", style: TextStyle(color: Colors.grey)),
                            GestureDetector(
                              child: Row(
                                children: [
                                  Text("被关注 ", style: const TextStyle(color: Colors.grey)),
                                  Text(c.beFollowedCountAb(abw) > 9999 ? "9999+" : c.beFollowedCountAb(abw).toString()),
                                ],
                              ),
                              onTap: () {
                                pushToFollowListPage(context: context, userId: widget.userId, followOrBeFollowed: false);
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                AbwBuilder(
                  builder: (abw) {
                    if (c.isFollowed3(abw) == null) {
                      return TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black12), visualDensity: VisualDensity(horizontal: 1, vertical: -1)),
                        child: Text("编辑", style: TextStyle(color: Colors.black45)),
                        onPressed: () {
                          c.clickFollowed();
                        },
                      );
                    }
                    if (c.isFollowed3(abw) == true) {
                      return TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black12), visualDensity: VisualDensity(horizontal: 1, vertical: -1)),
                        child: Text("已关注", style: TextStyle(color: Colors.black45)),
                        onPressed: () {
                          c.clickFollowed();
                        },
                      );
                    } else {
                      return TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue), visualDensity: VisualDensity(horizontal: 1, vertical: -1)),
                        child: Text("关注", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          c.clickFollowed();
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _fragment() {
    return AbBuilder<PersonalHomePageAbController>(
      builder: (c, abw) {
        return GestureDetector(
          onTap: () {
            pushToFragmentGroupListView(context: c.context, enterFragmentGroupId: null, userId: widget.userId);
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Spacer(),
                      Text("进入", style: TextStyle(color: Colors.blue)),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: c.fragmentGroupsAb(abw).isEmpty ? Center(child: Text("该用户没有碎片~")) : Container(),
                ),
                ...c.fragmentGroupsAb(abw).map(
                  (e) {
                    return SliverToBoxAdapter(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: 60, height: 90, color: Colors.grey),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e.jump_fragment_group?.title ?? e.fragment_group.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            () {
                                              final text = q.Document.fromJson(jsonDecode(
                                                e.jump_fragment_group?.profile ?? e.fragment_group.profile,
                                              )).toPlainText().split("\n").first.trim();
                                              return text.isEmpty ? "无简介" : text;
                                            }(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.grey),
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
                      ),
                    );
                  },
                ),
                ...c.fragmentsAb(abw).map(
                  (e) {
                    return SliverToBoxAdapter(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  e.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _publishFragmentGroups() {
    return AbBuilder<PersonalHomePageAbController>(
      builder: (c, abw) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: c.publishFragmentGroupAb(abw).isEmpty ? Center(child: Text("该用户没有发布过~")) : Container(),
              ),
              ...c.publishFragmentGroupAb(abw).map(
                (e) {
                  return SliverToBoxAdapter(
                    child: GestureDetector(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: 60, height: 90, color: Colors.grey),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            () {
                                              final text = q.Document.fromJson(jsonDecode(e.profile)).toPlainText().split("\n").first.trim();
                                              return text.isEmpty ? "无简介" : text;
                                            }(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        pushToFragmentGroupListView(context: c.context, userId: widget.userId, enterFragmentGroupId: e.id);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
