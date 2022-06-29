import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/Helper.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/dialog.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:aaa/widget_model/MemoryGroupModelAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CreateMemoryGroupPageAbController extends AbController {
  final title = ''.ab;

  final selectedMemoryModel = Ab<MemoryModel?>(null);

  final type = MemoryGroupType.none.ab;

  final selectedFragments = <Fragment>[].ab;

  bool isTitleOk([Abw? abw]) => title(abw).trim() != '';

  bool get isAllOk => isTitleOk();

  bool get isAllNotOk => !isTitleOk();

  @override
  void onInit() {
    querySelectedFragments();
  }

  Future<void> querySelectedFragments() async {
    final fs = await DriftDb.instance.singleDAO.queryFragmentsByIds(Aber.findLast<FragmentGroupModelAbController>().selectedFragmentIds().toList());
    selectedFragments.refreshInevitable((obj) => obj..addAll(fs));
  }

  Future<void> commit() async {
    if (!isAllOk) {
      SmartDialog.showToast('存在未填项！');
      return;
    }

    await DriftDb.instance.transaction(
      () async {
        await DriftDb.instance.singleDAO.insertMemoryGroupWith(
          MemoryGroupsCompanion()..title = title().toDriftValue(),
          selectedFragments(),
          selectedMemoryModel(),
        );
        Aber.findOrNullLast<MemoryGroupModelAbController>()?.refreshPage();

        SmartDialog.showToast('创建成功');
        Navigator.pop(context);
      },
    );
  }

  void cancel() {
    if (isAllNotOk) {
      Navigator.pop(context);
      return;
    }
    showDialogOkCancel(
      context: context,
      title: '存在修改内容，是否要丢弃？',
      okText: '丢弃',
      cancelText: '继续编辑',
    );
  }
}
