import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/MemoryGroupModelAbController.dart';
import 'package:flutter/material.dart';

class CreateMemoryGroupPageAbController extends AbController {
  String title = '';

  Future<void> commit() async {
    final memoryGroupModelAbController = Aber.findLast<MemoryGroupModelAbController>();

    // 检查是否可提交
    if (title.trim() == '') {
      Toaster.show(content: '已取消', milliseconds: 1000);
      Navigator.pop(context);
      return;
    }

    await memoryGroupModelAbController.addMemoryGroup(MemoryGroupsCompanion()..title = title.toDriftValue());
    Toaster.show(content: '创建成功', milliseconds: 1000);
    Navigator.pop(context);
  }

  void cancel() {
    if (title.trim() == '') {
      Navigator.pop(context);
    } else {
      // 编辑内容未保存。是否要 丢弃、存草稿、继续编辑？
      Toaster.show(content: '有编辑内容', milliseconds: 1000);
    }
  }
}
