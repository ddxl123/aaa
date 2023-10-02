import 'dart:convert';

import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../global/GlobalAbController.dart';
import '../page/list/FragmentGroupListSelfPageController.dart';

/// 向 [dynamicGroupEntity] 中添加新的碎片组。
Future<void> showCreateFragmentGroupDialog({required FragmentGroup? dynamicGroupEntity}) async {
  await showCustomDialog(
    builder: (_) {
      return TextField1DialogWidget(
        title: '创建碎片组：',
        okText: '创建',
        cancelText: '取消',
        inputDecoration: const InputDecoration(hintText: '请输入名称'),
        text: null,
        onCancel: () {
          SmartDialog.dismiss();
        },
        onOk: (tec) async {
          if (tec.text.trim().isEmpty) {
            SmartDialog.showToast('名称不能为空！');
            return;
          }
          await requestSingleRowInsert(
            isLoginRequired: true,
            singleRowInsertDto: SingleRowInsertDto(
              table_name: driftDb.fragmentGroups.actualTableName,
              row: Crt.fragmentGroupEntity(
                be_publish: false,
                cover_cloud_path: null,
                creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
                father_fragment_groups_id: dynamicGroupEntity?.id,
                jump_to_fragment_groups_id: null,
                profile: jsonEncode(Document().toDelta().toJson()),
                title: tec.text.trim(),
              ),
            ),
            onSuccess: (String showMessage, SingleRowInsertVo vo) async {
              await Aber.findOrNullLast<FragmentGroupListSelfPageController>()?.refreshCurrentGroup();
              SmartDialog.dismiss();
              SmartDialog.showToast('创建成功！');
            },
            onError: (a, b, c) async {
              logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
            },
          );
        },
      );
    },
  );
}
