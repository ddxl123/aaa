import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/page/list/FragmentGroupListPageAbController.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FragmentGroupGizmoEditPageAbController extends AbController {
  String title = '';

  Future<void> commit() async {
    final fragmentGroupModelAbController = Aber.findLast<FragmentGroupListPageAbController>();

    // 检查是否可提交
    if (title.trim() == '') {
      SmartDialog.showToast('已取消');
      Navigator.pop(context);
      return;
    }

    await fragmentGroupModelAbController.currentPart().addFragmentGroup(FragmentGroupsCompanion()
      ..title = title.value()
      ..fatherFragmentGroupId = (fragmentGroupModelAbController.currentPart().fatherFragmentGroup?.call().id).value());
    SmartDialog.showToast('创建成功');
    Navigator.pop(context);
  }

  void cancel() {
    if (title.trim() == '') {
      Navigator.pop(context);
    } else {
      // 编辑内容未保存。是否要 丢弃、存草稿、继续编辑？
      SmartDialog.showToast('有编辑内容');
    }
  }
}