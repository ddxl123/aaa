import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:flutter/material.dart';

class CreateFragmentGroupPageAbController extends AbController {
  /// 最近的一个 [FragmentGroupModelAbController]。
  late FragmentGroupModelAbController fragmentGroupModelAbController;

  String title = '';

  @override
  void onInit() {
    fragmentGroupModelAbController = Aber.findLast<FragmentGroupModelAbController>();
  }

  Future<void> commit() async {
    // 检查是否可提交
    if (title.trim() == '') {
      Toaster.show(content: '已取消', milliseconds: 1000);
      Navigator.pop(context);
      return;
    }
    await fragmentGroupModelAbController.addFragmentGroup(FragmentGroupsCompanion()..title = title.toDriftValue());
    Toaster.show(content: '创建成功', milliseconds: 1000);
    Navigator.pop(context);
  }

  void cancel() {
    if (title.trim() != '') {
      // 编辑内容未保存。是否要 丢弃、存草稿、继续编辑？
    }
  }
}
