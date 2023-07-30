import 'dart:convert';

import 'package:aaa/page/edit/FragmentGroupGizmoEditPageAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';

class FragmentGroupGizmoEditPage extends StatefulWidget {
  const FragmentGroupGizmoEditPage({Key? key, required this.fragmentGroupAb}) : super(key: key);
  final Ab<FragmentGroup?> fragmentGroupAb;

  @override
  State<FragmentGroupGizmoEditPage> createState() => _FragmentGroupGizmoEditPageState();
}

class _FragmentGroupGizmoEditPageState extends State<FragmentGroupGizmoEditPage> {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentGroupGizmoEditPageAbController>(
      putController: FragmentGroupGizmoEditPageAbController(fragmentGroupAb: widget.fragmentGroupAb),
      builder: (c, abw) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.save_outlined),
                onPressed: () {
                  c.save();
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("标题", style: TextStyle(color: Colors.grey)),
                              TextField(
                                autofocus: true,
                                decoration: InputDecoration(hintText: "请输入..."),
                                controller: c.titleTextEditingController,
                                focusNode: c.titleFocusNode,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("简介", style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 10),
                              q.QuillEditor(
                                controller: c.profileQuillController,
                                focusNode: c.profileFocusNode,
                                scrollController: ScrollController(),
                                scrollable: false,
                                padding: EdgeInsets.all(0),
                                autoFocus: false,
                                readOnly: false,
                                expands: false,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              AbwBuilder(
                builder: (abw) {
                  return Row(
                    children: [
                      ...c.fragmentGroupTagAb(abw).map(
                        (e) {
                          return Card(
                            margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Text("#四级英语", style: TextStyle(color: Colors.blue)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      GestureDetector(
                        child: Card(
                          color: Colors.greenAccent,
                          margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Text("+ ", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                                Text("标签", style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          c.addTag();
                        },
                      ),
                    ],
                  );
                },
              ),
              AbwBuilder(
                builder: (abw) {
                  return c.isShowToolBar(abw)
                      ? q.QuillToolbar.basic(
                          multiRowsDisplay: false,
                          controller: c.profileQuillController,
                        )
                      : Container();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
