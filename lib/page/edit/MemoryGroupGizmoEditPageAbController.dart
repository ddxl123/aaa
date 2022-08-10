import 'package:drift_main/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/dialog.dart';
import 'package:aaa/widget_model/FragmentGroupPageAbController.dart';
import 'package:aaa/widget_model/MemoryGroupPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'EditPageType.dart';

class MemoryGroupGizmoEditPageAbController extends AbController {
  MemoryGroupGizmoEditPageAbController({required this.configPageType, required this.memoryGroupGizmo});

  final EditPageType configPageType;

  final Ab<MemoryGroup>? memoryGroupGizmo;

  /// 标题
  final title = ''.ab;

  bool isTitleOk([Abw? abw]) => title(abw).trim() != '';

  /// 记忆模型
  final selectedMemoryModel = Ab<MemoryModel?>(null);

  bool isSelectedMemoryModelOk([Abw? abw]) => selectedMemoryModel(abw) != null;

  /// 记忆类型
  final type = MemoryGroupType.inApp.ab;

  /// 记忆组状态
  final statusForNormal = MemoryGroupStatusForNormal.notStart.ab;

  /// 记忆组状态
  final statusForNormalPart = MemoryGroupStatusForNormalPart.disabled.ab;

  /// 记忆组状态
  final statusForFullFloating = MemoryGroupStatusForFullFloating.notStarted.ab;

  /// 已存碎片
  final fragments = <Ab<Fragment>>[].ab;

  bool isAllOk([Abw? abw]) => isTitleOk(abw) && isSelectedMemoryModelOk(abw);

  @override
  void onInit() {
    Helper.filter(
      from: configPageType,
      targets: {
        [EditPageType.create, EditPageType.createCheck]: () async {
          await initForCreate();
        },
        [EditPageType.modify, EditPageType.modifyCheck]: () async {
          await initForModify();
        }
      },
      orElse: null,
    );
  }

  Future<void> initForCreate() async {
    final fs = await DriftDb.instance.singleDAO.queryFragmentsByIds(Aber.findLast<FragmentGroupPageAbController>().selectedFragmentIds().toList());
    fragments.refreshInevitable((obj) => obj..addAll(fs.map((e) => e.ab)));
  }

  Future<void> initForModify() async {
    final mgg = memoryGroupGizmo!();
    final fs = await DriftDb.instance.singleDAO.queryFragmentsByFragmentGroupId(mgg.id);
    final mm = await DriftDb.instance.singleDAO.queryMemoryModelInsideMemoryGroup(mgg.id);

    title.refreshEasy((oldValue) => mgg.title);
    selectedMemoryModel.refreshEasy((obj) => mm);
    type.refreshEasy((oldValue) => mgg.type);
    statusForNormal.refreshEasy((oldValue) => mgg.normalStatus);
    statusForNormalPart.refreshEasy((oldValue) => mgg.normalPartStatus);
    statusForFullFloating.refreshEasy((oldValue) => mgg.fullFloatingStatus);
    fragments.refreshInevitable((obj) => obj..addAll(fs.map((e) => e.ab)));
  }

  /// 只创建，不检查。
  Future<void> commitCreate() async {
    if (!isTitleOk()) {
      SmartDialog.showToast('标题不能为空！');
      return;
    }

    await DriftDb.instance.transaction(
      () async {
        await DriftDb.instance.singleDAO.insertMemoryGroupWithOther(
          WithCrts.memoryGroupsCompanion(
            id: absent(),
            createdAt: absent(),
            updatedAt: absent(),
            title: title().value(),
            type: type().value(),
            normalStatus: statusForNormal().value(),
            normalPartStatus: statusForNormalPart().value(),
            fullFloatingStatus: statusForFullFloating().value(),
          ),
          fragments().map((e) => e()).toList(),
          selectedMemoryModel(),
        );
      },
    );

    await Aber.findOrNullLast<MemoryGroupPageAbController>()?.refreshPage();
    SmartDialog.showToast('创建成功！');
    Navigator.pop(context);
  }

  /// 仅修改
  /// TODO: 要注意修改前与修改后的兼容提示。
  Future<void> commitModify() async {
    memoryGroupGizmo!.refreshComplex(
      (obj) {
        obj.reset(
          id: absent(),
          createdAt: absent(),
          updatedAt: absent(),
          title: title().value(),
          type: type().value(),
          normalStatus: statusForNormal().value(),
          normalPartStatus: statusForNormalPart().value(),
          fullFloatingStatus: statusForFullFloating().value(),
        );
        return true;
      },
    );
  }

  /// 修改并检查
  Future<void> commitModifyCheck() async {
    if (isAllOk()) {
      await commitModify();
    }
  }

  void cancel() {
    showDialogOkCancel(
      context: context,
      title: '是否要丢弃？',
      okText: '丢弃',
      cancelText: '继续编辑',
    );
  }
}
