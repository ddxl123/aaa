import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/tool/Helper.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/dialog.dart';
import 'package:aaa/widget_model/FragmentGroupPageAbController.dart';
import 'package:aaa/widget_model/MemoryGroupPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'CreateOrModifyType.dart';

class MemoryGroupGizmoConfigPageAbController extends AbController {
  MemoryGroupGizmoConfigPageAbController(this.configPageType);

  final ConfigPageType configPageType;

  /// 标题
  final title = ''.ab;

  /// 记忆模型
  final selectedMemoryModel = Ab<MemoryModel?>(null);

  /// 记忆类型
  final type = MemoryGroupType.inApp.ab;

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
    Helper.filter(
      from: configPageType,
      targets: {
        [ConfigPageType.create, ConfigPageType.createCheck]: () {
          querySelectedFragments();
        },
      },
      orElse: null,
    );
    querySelectedFragments();
  }

  Future<void> querySelectedFragments() async {
    final fs = await DriftDb.instance.singleDAO.queryFragmentsByIds(Aber.findLast<FragmentGroupPageAbController>().selectedFragmentIds().toList());
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
        await DriftDb.instance.singleDAO.insertMemoryGroupWithOther(
          MemoryGroupsCompanion()
            ..title = title().toDriftValue()
            ..type = type().toDriftValue()
            ..normalStatus = statusForNormal().toDriftValue()
            ..normalPartStatus = statusForNormalPart().toDriftValue()
            ..fullFloatingStatus = statusForFullFloating().toDriftValue(),
          selectedFragments(),
          selectedMemoryModel(),
        );
        await Aber.findOrNullLast<MemoryGroupPageAbController>()?.refreshPage();

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
