import 'package:drift_main/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/dialog.dart';
import 'package:aaa/page/list/FragmentGroupListPageAbController.dart';
import 'package:aaa/page/list/MemoryGroupListPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

import 'EditPageType.dart';

class MemoryGroupGizmoEditPageAbController extends AbController {
  /// 把 gizmo 内所以信息打包成一个对象进行传入。
  /// 如果只传入 [memoryGroupGizmo] 的话，会缺少 [selectedMemoryModel]、[fragments] 等，修改它们后， gizmo 外的数据并没有被刷新。
  MemoryGroupGizmoEditPageAbController({required this.configPageType, required this.memoryGroupGizmo});

  final titleTextEditingController = TextEditingController();

  final EditPageType configPageType;

  final Ab<MemoryGroup>? memoryGroupGizmo;

  /// 标题
  final title = ''.ab..initVerify(initIsOk: (v) => v().trim() != '', failMessage: '标题不能为空！');

  /// 记忆模型
  final selectedMemoryModel = Ab<MemoryModel?>(null)..initVerify(initIsOk: (v) => v() != null, failMessage: '记忆模型不能为空！');

  /// 记忆类型
  final type = MemoryGroupType.inApp.ab;

  /// 记忆组状态
  final statusForNormal = MemoryGroupStatusForInApp.notStart.ab;

  /// 记忆组状态
  final statusForNormalPart = MemoryGroupStatusForInAppPart.disabled.ab;

  /// 记忆组状态
  final statusForFullFloating = MemoryGroupStatusForAllFloating.notStarted.ab;

  /// 已存碎片
  final fragments = <Ab<Fragment>>[].ab;

  VerifyMany get verifyMany => VerifyMany(
        verifyMany: [
          title.verify,
          selectedMemoryModel.verify,
        ],
      );

  @override
  void onInit() {
    filter(
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
    final fs =
        await DriftDb.instance.singleDAO.queryFragmentsByIds(Aber.findLast<FragmentGroupListPageAbController>().selectedFragmentIds().toList());
    fragments.refreshInevitable((obj) => obj..addAll(fs.map((e) => e.ab)));
  }

  Future<void> initForModify() async {
    final mgg = memoryGroupGizmo!();
    final fs = await DriftDb.instance.singleDAO.queryFragmentInMemoryGroup(mgg.id);
    final mm = await DriftDb.instance.singleDAO.queryMemoryModelInsideMemoryGroup(memoryModelId: mgg.memoryModelId);

    title.refreshEasy((oldValue) => mgg.title);
    titleTextEditingController.text = mgg.title;
    selectedMemoryModel.refreshEasy((obj) => mm);
    type.refreshEasy((oldValue) => mgg.type);
    statusForNormal.refreshEasy((oldValue) => mgg.normalStatus);
    statusForNormalPart.refreshEasy((oldValue) => mgg.normalPartStatus);
    statusForFullFloating.refreshEasy((oldValue) => mgg.fullFloatingStatus);
    fragments.refreshInevitable((obj) => obj..addAll(fs.map((e) => e.ab)));
  }

  /// 只创建，不检查。
  Future<void> commitCreate() async {
    if (title.verify.isNotOk) {
      SmartDialog.showToast(title.verify.failMessage);
      return;
    }

    await DriftDb.instance.transaction(
      () async {
        await DriftDb.instance.singleDAO.insertMemoryGroupWithOther(
          WithCrts.memoryGroupsCompanion(
            id: absent(),
            createdAt: absent(),
            updatedAt: absent(),
            memoryModelId: (selectedMemoryModel()?.id).value(),
            title: title().value(),
            type: type().value(),
            normalStatus: statusForNormal().value(),
            normalPartStatus: statusForNormalPart().value(),
            fullFloatingStatus: statusForFullFloating().value(),
          ),
          fragments().map((e) => e()).toList(),
        );
      },
    );

    await Aber.findOrNullLast<MemoryGroupListPageAbController>()?.refreshPage();
    SmartDialog.showToast('创建成功！');
    Navigator.pop(context);
  }

  /// 仅修改
  /// TODO: 要注意修改前与修改后的兼容提示。
  Future<void> commitModify({required bool isShowTip, required bool isPop}) async {
    await memoryGroupGizmo!.refreshComplex(
      (obj) async {
        final st = await SyncTag.create();
        await withRefs(
          RefMemoryGroups(
            self: (table) async {
              // 修改并写入。
              await obj.reset(
                id: absent(),
                createdAt: absent(),
                updatedAt: absent(),
                memoryModelId: (selectedMemoryModel()?.id).value(),
                title: title().value(),
                type: type().value(),
                normalStatus: statusForNormal().value(),
                normalPartStatus: statusForNormalPart().value(),
                fullFloatingStatus: statusForFullFloating().value(),
                writeSyncTag: st,
              );
            },
            // TODO:
            fragmentPermanentMemoryInfos: null,
            // TODO:
            rFragment2MemoryGroups: null,
          ),
        );
        return true;
      },
    );
    if (isShowTip) {
      SmartDialog.showToast('修改成功！');
    }
    if (isPop) {
      Navigator.pop(context);
    }
  }

  /// 修改并检查。
  ///
  /// 返回是否修改并检查成功。
  Future<void> commitModifyCheck() async {
    if (verifyMany.isVerifyAllOk) {
      await commitModify(isShowTip: false, isPop: false);
      SmartDialog.showToast('启动成功！');
      Navigator.pop(context);
      return;
    }
    SmartDialog.showToast(verifyMany.failMessage);
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
