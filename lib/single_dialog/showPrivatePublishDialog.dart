import 'package:aaa/theme/theme.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:tools/tools.dart';

Future<void> showPrivatePublishDialog({required Ab<FragmentGroup?> currentFragmentGroupAb}) async {
  return await showCustomDialog(
    builder: (_) {
      return _PrivatePublishDialogWidget(
        currentFragmentGroupAb: currentFragmentGroupAb,
      );
    },
  );
}

class _PrivatePublishDialogWidget extends StatefulWidget {
  const _PrivatePublishDialogWidget({super.key, required this.currentFragmentGroupAb});

  final Ab<FragmentGroup?> currentFragmentGroupAb;

  @override
  State<_PrivatePublishDialogWidget> createState() => _PrivatePublishDialogWidgetState();
}

class _PrivatePublishDialogWidgetState extends State<_PrivatePublishDialogWidget> {
  final privateJustTheController = JustTheController();
  final publishJustTheController = JustTheController();

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      mainVerticalWidgets: [
        Row(
          children: [
            Text("是否发布", style: TextStyle(fontSize: 18)),
            SizedBox(width: 10),
            JustTheTooltip(
              controller: publishJustTheController,
              backgroundColor: Colors.grey.shade800,
              content: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("发布：会在首页中被推荐，也可被搜索到", style: TextStyle(color: Colors.white)),
                    Text("不发布：不会在首页中被推荐，也无法被搜索到", style: TextStyle(color: Colors.white)),
                    Text(
                      "\n私密和发布并不相互影响。\n\n当设为私密，但同时设为发布时，个人主页陌生人不可见，但是将会被首页推荐或搜索到。\n\n如果想要完全私密，请将私密启用，并将发布关闭。",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              child: GestureDetector(
                child: Icon(Icons.error, color: Colors.amber),
                onTap: () {
                  publishJustTheController.showTooltip();
                },
              ),
            ),
            SizedBox(width: 50),
            Switch(
              value: widget.currentFragmentGroupAb()!.be_publish,
              onChanged: (v) async {
                final st = await SyncTag.create();
                await db.updateDAO.resetFragmentGroup(
                  syncTag: st,
                  originalFragmentGroupReset: () async {
                    await widget.currentFragmentGroupAb()!.reset(
                          be_private: 0.toAbsent(),
                          be_publish: v.toValue(),
                          client_be_selected: 0.toAbsent(),
                          creator_user_id: 0.toAbsent(),
                          father_fragment_groups_id: 0.toAbsent(),
                          title: 0.toAbsent(),
                          profile: 0.toAbsent(),
                          save_original_id: 0.toAbsent(),
                          syncTag: st,
                          isCloudTableWithSync: true,
                        );
                  },
                );
                setState(() {});
                widget.currentFragmentGroupAb.refreshInevitable((obj) => obj!..be_publish = v);
              },
            ),
          ],
        ),
        widget.currentFragmentGroupAb()!.be_publish
            ? Row(
                children: [
                  SizedBox(width: 10),
                  // TODO:
                  Text("允许二次发布", style: TextStyle(fontSize: 16)),
                  Spacer(),
                  Switch(
                    value: widget.currentFragmentGroupAb()!.be_private,
                    onChanged: (v) async {
                      final st = await SyncTag.create();
                      await db.updateDAO.resetFragmentGroup(
                        syncTag: st,
                        originalFragmentGroupReset: () async {
                          await widget.currentFragmentGroupAb()!.reset(
                                be_private: v.toValue(),
                                be_publish: 0.toAbsent(),
                                client_be_selected: 0.toAbsent(),
                                creator_user_id: 0.toAbsent(),
                                father_fragment_groups_id: 0.toAbsent(),
                                title: 0.toAbsent(),
                                profile: 0.toAbsent(),
                                save_original_id: 0.toAbsent(),
                                syncTag: st,
                                isCloudTableWithSync: true,
                              );
                        },
                      );
                      setState(() {});
                      widget.currentFragmentGroupAb.refreshInevitable((obj) => obj!..be_private = v);
                    },
                  ),
                ],
              )
            : Container(),
        widget.currentFragmentGroupAb()!.be_publish
            ? Row(
                children: [
                  SizedBox(width: 10),
                  // TODO:
                  Text("允许碎片被克隆", style: TextStyle(fontSize: 16)),
                  Spacer(),
                  Switch(
                    value: widget.currentFragmentGroupAb()!.be_private,
                    onChanged: (v) async {
                      final st = await SyncTag.create();
                      await db.updateDAO.resetFragmentGroup(
                        syncTag: st,
                        originalFragmentGroupReset: () async {
                          await widget.currentFragmentGroupAb()!.reset(
                                be_private: v.toValue(),
                                be_publish: 0.toAbsent(),
                                client_be_selected: 0.toAbsent(),
                                creator_user_id: 0.toAbsent(),
                                father_fragment_groups_id: 0.toAbsent(),
                                title: 0.toAbsent(),
                                profile: 0.toAbsent(),
                                save_original_id: 0.toAbsent(),
                                syncTag: st,
                                isCloudTableWithSync: true,
                              );
                        },
                      );
                      setState(() {});
                      widget.currentFragmentGroupAb.refreshInevitable((obj) => obj!..be_private = v);
                    },
                  ),
                ],
              )
            : Container(),
        SizedBox(height: 20),
        Row(
          children: [
            Text("是否私密", style: TextStyle(fontSize: 18)),
            SizedBox(width: 10),
            JustTheTooltip(
              controller: privateJustTheController,
              backgroundColor: Colors.grey.shade800,
              content: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("私密：个人主页界面仅自己可见", style: TextStyle(color: Colors.white)),
                    Text("公开：个人主页界面陌生人也可见", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              child: GestureDetector(
                child: Icon(Icons.error, color: Colors.amber),
                onTap: () {
                  privateJustTheController.showTooltip();
                },
              ),
            ),
            Spacer(),
            Switch(
              value: widget.currentFragmentGroupAb()!.be_private,
              onChanged: (v) async {
                final st = await SyncTag.create();
                await db.updateDAO.resetFragmentGroup(
                  syncTag: st,
                  originalFragmentGroupReset: () async {
                    await widget.currentFragmentGroupAb()!.reset(
                          be_private: v.toValue(),
                          be_publish: 0.toAbsent(),
                          client_be_selected: 0.toAbsent(),
                          creator_user_id: 0.toAbsent(),
                          father_fragment_groups_id: 0.toAbsent(),
                          title: 0.toAbsent(),
                          profile: 0.toAbsent(),
                          save_original_id: 0.toAbsent(),
                          syncTag: st,
                          isCloudTableWithSync: true,
                        );
                  },
                );
                setState(() {});
                widget.currentFragmentGroupAb.refreshInevitable((obj) => obj!..be_private = v);
              },
            ),
          ],
        ),
        // Divider(),
        SizedBox(height: 20),
      ],
      bottomHorizontalButtonWidgets: [],
    );
  }
}
