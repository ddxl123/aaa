import 'dart:convert';

import 'package:aaa/page/fragment_group_view/FragmentGroupListViewAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';

class FragmentGroupListView extends StatelessWidget {
  const FragmentGroupListView({super.key, required this.enterFragmentGroup});

  final FragmentGroup enterFragmentGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: Container(), preferredSize: Size(0, 10)),
      body: GroupListWidget<FragmentGroup, Fragment, FragmentGroupListViewAbController>(
        groupListWidgetController: FragmentGroupListViewAbController(enterFragmentGroup: enterFragmentGroup),
        groupChainStrings: (group, abw) => group(abw).entity(abw)!.title,
        leftActionBuilder: (c, abw) {
          return Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Icon(Icons.circle, size: 5),
            ],
          );
        },
        headSliver: (c, group, abw) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(color: Colors.grey, width: 90, height: 130),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    group(abw).entity(abw)?.title ?? "发生异常！",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Text("热度999"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 5,
                              children: [
                                Container(
                                  child: Text("的撒旦", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Container(
                                  child: Text("的撒旦", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Container(
                                  child: Text("的撒旦", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text("创建者"),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.download_outlined, size: 34, color: Colors.green),
                                        Text(
                                          "999+",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    // c.download(willDownloadFragmentGroup: e.fragment_group);
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.black12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          visualDensity: kMinVisualDensity,
                          onPressed: () {},
                          child: Icon(Icons.share, size: 18),
                        ),
                      ),
                      Container(height: 30, child: VerticalDivider(color: Colors.black12)),
                      Expanded(
                        child: MaterialButton(
                          visualDensity: kMinVisualDensity,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, size: 18),
                              Text("999+", style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                      Container(height: 30, child: VerticalDivider(color: Colors.black12)),
                      Expanded(
                        child: MaterialButton(
                          visualDensity: kMinVisualDensity,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.mode_comment_outlined, size: 18),
                              Text("999+", style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                      Container(height: 30, child: VerticalDivider(color: Colors.black12)),
                      Expanded(
                        child: MaterialButton(
                          visualDensity: kMinVisualDensity,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.thumb_up_alt_outlined, size: 18),
                              Text("999+", style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black12),
                  SizedBox(height: 10),
                  _Profile(fragmentGroup: group().entity(), fragmentGroupListViewAbController: c),
                ],
              ),
            ),
          );
        },
        groupBuilder: (c, group, abw) {
          return GestureDetector(
            child: Container(
              height: 50,
              child: Text(group().entity()!.title),
            ),
            onTap: () {
              c.enterGroup(group);
            },
          );
        },
        unitBuilder: (c, group, abw) => Container(
          child: Text(group().unitEntity().title),
        ),
        rightActionBuilder: (group, abw) => Container(),
        floatingButtonOnPressed: (c) {},
      ),
    );
  }
}

class _Profile extends StatefulWidget {
  const _Profile({super.key, required this.fragmentGroup, required this.fragmentGroupListViewAbController});

  final FragmentGroup? fragmentGroup;
  final FragmentGroupListViewAbController fragmentGroupListViewAbController;

  @override
  State<_Profile> createState() => _ProfileState();
}

class _ProfileState extends State<_Profile> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    if (widget.fragmentGroup == null || q.Document.fromJson(jsonDecode(widget.fragmentGroup!.profile)).isEmpty()) {
      return const Text("无简介", style: TextStyle(color: Colors.grey));
    }
    late Widget w;
    if (isExpand) {
      final quillController = q.QuillController.basic()..document = q.Document.fromJson(jsonDecode(widget.fragmentGroup!.profile));
      w = q.QuillEditor(
        enableInteractiveSelection: false,
        scrollController: ScrollController(),
        controller: quillController,
        readOnly: true,
        showCursor: false,
        autoFocus: false,
        expands: false,
        focusNode: FocusNode(),
        padding: const EdgeInsets.all(0),
        scrollable: false,
      );
    } else {
      w = Row(
        children: [
          Expanded(
            child: Text(
              q.Document.fromJson(jsonDecode(widget.fragmentGroup!.profile)).toPlainText().split("\n").first,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            const Expanded(child: Text("简介", style: TextStyle(color: Colors.grey), textAlign: TextAlign.center)),
            Expanded(
              child: GestureDetector(
                child: isExpand
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text("隐藏", style: TextStyle(color: Colors.grey)), Icon(Icons.arrow_drop_down)],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text("展开", style: TextStyle(color: Colors.grey)), Icon(Icons.arrow_left)],
                      ),
                onTap: () {
                  isExpand = !isExpand;
                  widget.fragmentGroupListViewAbController.thisRefresh();
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        w,
      ],
    );
  }
}
