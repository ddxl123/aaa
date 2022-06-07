import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:flutter/material.dart';

class CreateFragmentPageAbController extends AbController {
  /// 最近的一个 [FragmentGroupModelAbController]。
  late FragmentGroupModelAbController fragmentGroupModelAbController;

  String title = '';

  String content = '';

  @override
  void onInit() {
    fragmentGroupModelAbController = Aber.findLast<FragmentGroupModelAbController>();
  }

  Future<void> commit() async {
    // 检查是否可提交
    if (title.trim() == '' && content == '') {
      Toaster.show(content: '已取消', milliseconds: 1000);
      Navigator.pop(context);
      return;
    }
    await fragmentGroupModelAbController.addFragment(FragmentsCompanion()..title = title.toDriftValue());
    Toaster.show(content: '创建成功', milliseconds: 1000);
    Navigator.pop(context);
  }
}
