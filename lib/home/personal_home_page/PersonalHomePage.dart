import 'dart:convert';

import 'package:aaa/home/personal_home_page/PersonalHomePageAbController.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';

/// TODO: 检查所有 putController ，看看它是否需要放置到 StatefulWidget 中。
class PersonalHomePage extends StatelessWidget {
  const PersonalHomePage({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbBuilder<PersonalHomePageAbController>(
        putController: PersonalHomePageAbController(userId: userId),
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
                    child: CachedNetworkImage(
                      imageUrl: c.userAvatar(abw)??"",
                      errorWidget: (ctx, url, err) {
                        print("u--- $url");
                        print("u--- $err");
                        return Icon(Icons.ac_unit, size: 80, color: Colors.tealAccent);
                      },
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.none,
                    ),
                  ),
                  onTap: () async {
                    c.showAvatar();
                  },
                ),
                const SizedBox(width: 10),
                AbwBuilder(
                  builder: (abw) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.userName(abw)??"加载中", style: Theme.of(c.context).textTheme.headlineSmall),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text("关注 ", style: const TextStyle(color: Colors.grey)),
                            Text(c.follow(abw) > 9999 ? "9999+" : c.follow(abw).toString()),
                            Text("  |  ", style: TextStyle(color: Colors.grey)),
                            Text("被关注 ", style: const TextStyle(color: Colors.grey)),
                            Text(c.beFollowed(abw) > 9999 ? "9999+" : c.follow(abw).toString()),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                AbwBuilder(
                  builder: (abw) {
                    if (c.isSelf) {
                      return TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black12), visualDensity: VisualDensity(horizontal: 1, vertical: -1)),
                        child: Text("编辑", style: TextStyle(color: Colors.black45)),
                        onPressed: () {},
                      );
                    }
                    if (c.isFollowed(abw)) {
                      return TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black12), visualDensity: VisualDensity(horizontal: 1, vertical: -1)),
                        child: Text("已关注", style: TextStyle(color: Colors.black45)),
                        onPressed: () {},
                      );
                    } else {
                      return TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue), visualDensity: VisualDensity(horizontal: 1, vertical: -1)),
                        child: Text("关注", style: TextStyle(color: Colors.white)),
                        onPressed: () {},
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
            pushToFragmentGroupListView(context: c.context, enterFragmentGroup: null, userId: userId);
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
                        pushToFragmentGroupListView(context: c.context, userId: userId, enterFragmentGroup: e);
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
