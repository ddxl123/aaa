import 'dart:convert';

import 'package:aaa/page/list/FragmentGroupListPageController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../global/GlobalAbController.dart';

/// 向 [fragmentGroup] 中添加新的碎片组。
Future<void> showCreateFragmentGroupDialog({required FragmentGroup? fragmentGroup}) async {
  await showCustomDialog(
    builder: (_) {
      return TextField1DialogWidget(
        title: '创建碎片组：',
        okText: '创建',
        cancelText: '取消',
        inputDecoration: InputDecoration(hintText: '请输入名称'),
        text: null,
        onCancel: () {
          SmartDialog.dismiss();
        },
        onOk: (tec) async {
          if (tec.text.trim().isEmpty) {
            SmartDialog.showToast('名称不能为空！');
            return;
          }
          final st = await SyncTag.create();
          await RefFragmentGroups(
            self: () async {
              Crt.fragmentGroupsCompanion(
                creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
                father_fragment_groups_id: (fragmentGroup?.id).toValue(),
                client_be_selected: false,
                title: tec.text,
                profile: jsonEncode(Document().toDelta().toJson()),
                save_original_id: null.toValue(),
                be_private: false,
                be_publish: false,
              ).insert(
                syncTag: st,
                isCloudTableWithSync: true,
                isCloudTableAutoId: true,
                isReplaceWhenIdSame: false,
              );
            },
            fragmentGroupTags: null,
            rFragment2FragmentGroups: null,
            child_fragmentGroups: null,
            userComments: null,
            userLikes: null,
            order: 0,
          ).run();

          await Aber.findOrNullLast<FragmentGroupListPageController>()?.refreshCurrentGroup();

          SmartDialog.dismiss();
          SmartDialog.showToast('创建成功！');
        },
      );
    },
  );
}
