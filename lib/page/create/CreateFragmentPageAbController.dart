import 'package:aaa/page/transition/FragmentGroupChoosePage.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CreateFragmentPageAbController extends AbController {
  String title = '';

  String content = '';

  void commit() {
    if (title.trim() == '' && content.trim() == '') {
      SmartDialog.showToast('没有内容');
      Navigator.pop(context);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => const FragmentGroupChoosePage()));
    }
  }

  void cancel() {
    if (title.trim() == '' && content.trim() == '') {
      Navigator.pop(context);
    } else {
      // 编辑内容未保存。是否要 丢弃、存草稿、继续编辑？
      SmartDialog.showToast('有编辑内容');
    }
  }
}
