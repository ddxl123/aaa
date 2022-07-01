import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/dialog.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:aaa/widget_model/MemoryGroupModelAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'CreateOrModifyType.dart';

class CreateModifyMemoryGroupPageAbController extends AbController {
  CreateModifyMemoryGroupPageAbController(this.createOrModifyType);

  final CreateModifyCheckType createOrModifyType;

  /// 标题
  final title = ''.ab;

  /// 记忆模型
  final selectedMemoryModel = Ab<MemoryModel?>(null);

  /// 记忆类型
  final type = MemoryGroupType.normal.ab;

  /// 记忆组状态
  final statusForNormal = MemoryGroupStatusForNormal.notStart.ab;

  /// 记忆组状态
  final statusForNormalPart = MemoryGroupStatusForNormalPart.disabled.ab;

  /// 记忆组状态
  final statusForFullFloating = MemoryGroupStatusForFullFloating.notStarted.ab;

  /// 已选碎片
  final selectedFragments = <Fragment>[].ab;

  /// [title] 是否ok
  bool isTitleOk([Abw? abw]) => title(abw).trim() != '';

  @override
  void onInit() {
    querySelectedFragments();
  }

  Future<void> querySelectedFragments() async {
    final fs = await DriftDb.instance.singleDAO.queryFragmentsByIds(Aber.findLast<FragmentGroupModelAbController>().selectedFragmentIds().toList());
    selectedFragments.refreshInevitable((obj) => obj..addAll(fs));
  }

  /// 只检查 [title]。
  Future<void> commitForCreate() async {
    if (!isTitleOk()) {
      SmartDialog.showToast('标题不能为空！');
      return;
    }

    await DriftDb.instance.transaction(
      () async {
        await DriftDb.instance.singleDAO.insertMemoryGroupWith(
          MemoryGroupsCompanion()
            ..title = title().toDriftValue()
            ..type = type().toDriftValue()
            ..normalStatus = statusForNormal().toDriftValue()
            ..normalPartStatus = statusForNormalPart().toDriftValue()
            ..fullFloatingStatus = statusForFullFloating().toDriftValue(),
          selectedFragments(),
          selectedMemoryModel(),
        );
        await Aber.findOrNullLast<MemoryGroupModelAbController>()?.refreshPage();

        SmartDialog.showToast('创建成功');
        Navigator.pop(context);
      },
    );
  }

  Future<void> commitForModify() async {}

  void cancel() {
    showDialogOkCancel(
      context: context,
      title: '是否要丢弃？',
      okText: '丢弃',
      cancelText: '继续编辑',
    );
  }
}
