import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:aaa/widget_model/MemoryGroupModelAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CreateMemoryGroupPageAbController extends AbController {
  String title = '';

  final selectedFragments = <Fragment>[].ab;

  @override
  void onInit() {
    obtainSelectedFragments();
  }

  Future<void> obtainSelectedFragments() async {
    final fs = await DriftDb.instance.singleDAO.queryFragmentsByIds(Aber.findLast<FragmentGroupModelAbController>().selectedFragmentIds().toList());
    selectedFragments.refreshInevitable((obj) => obj..addAll(fs));
  }

  Future<void> commit() async {
    final memoryGroupModelAbController = Aber.findLast<MemoryGroupModelAbController>();

    // 检查是否可提交
    if (title.trim() == '') {
      SmartDialog.showToast('已取消');
      Navigator.pop(context);
      return;
    }

    await memoryGroupModelAbController.addMemoryGroup(MemoryGroupsCompanion()..title = title.toDriftValue());
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
