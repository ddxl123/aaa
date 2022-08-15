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
  /// 如果只传入 [memoryGroupGizmo] 的话，会缺少 [selectedMemoryModel]、[selectedFragments] 等，修改它们后， gizmo 外的数据并没有被刷新。
  MemoryGroupGizmoEditPageAbController({required this.editPageType, required this.memoryGroupGizmo});

  final titleTextEditingController = TextEditingController();

  final MemoryGroupGizmoEditPageType editPageType;

  final Ab<MemoryGroup>? memoryGroupGizmo;

  /// 标题
  final title = ''.ab..initVerify(initIsOk: (v) => v().trim() != '', failMessage: '标题不能为空！');

  /// 记忆模型
  final selectedMemoryModel = Ab<MemoryModel?>(null)..initVerify(initIsOk: (v) => v() != null, failMessage: '记忆模型不能为空！');

  /// 记忆类型
  final type = MemoryGroupType.inApp.ab;

  /// 记忆组状态
  final status = MemoryGroupStatus.notInit.ab;

  /// 已存碎片
  final selectedFragments = <Ab<Fragment>>[].ab;

  ///

  /// 新学数量
  final newLearnCount = 100.ab;

  /// 复习区间
  /// TODO: 进行 [Verify]
  final reviewInterval = ''.ab;

  /// 过滤碎片
  /// TODO: 进行 [Verify]
  final filterOut = ''.ab;

  /// 展示优先级
  final displayPriority = DisplayPriority.minx.ab;

  VerifyMany get verifyInitCheck => VerifyMany(
        verifyMany: [
          title.verify,
          selectedMemoryModel.verify,
        ],
      );

  /// TODO: [reviewInterval]/[filterOut]
  VerifyMany get verifyModifyOtherCheck => VerifyMany(
        verifyMany: [],
      );

  @override
  void onInit() {
    filter(
      from: editPageType,
      targets: {
        [MemoryGroupGizmoEditPageType.initCheck]: () async {
          await initInitCheck();
        },
        [MemoryGroupGizmoEditPageType.modifyOtherCheck]: () async {
          await initModifyOtherCheck();
        }
      },
      orElse: null,
    );
  }

  Future<void> initInitCheck() async {
    final mgg = memoryGroupGizmo!();
    final fs = await DriftDb.instance.singleDAO.queryFragmentInMemoryGroup(mgg.id);
    final mm = await DriftDb.instance.singleDAO.queryMemoryModelInsideMemoryGroup(memoryModelId: mgg.memoryModelId);

    title.refreshEasy((oldValue) => mgg.title);
    titleTextEditingController.text = mgg.title;
    selectedMemoryModel.refreshEasy((obj) => mm);
    type.refreshEasy((oldValue) => mgg.type);
    status.refreshEasy((oldValue) => mgg.status);
    selectedFragments.refreshInevitable((obj) => obj..addAll(fs.map((e) => e.ab)));
  }

  Future<void> initModifyOtherCheck() async {
    final mgg = memoryGroupGizmo!();
    newLearnCount.refreshEasy((obj) => mgg.newLearnCount);
    reviewInterval.refreshEasy((oldValue) => mgg.reviewInterval);
    filterOut.refreshEasy((oldValue) => mgg.filterOut);
    displayPriority.refreshEasy((oldValue) => mgg.displayPriority);
  }

  Future<void> commitModifyInitCheck() async {
    if (await verifyInitCheck.isVerifyAllOk) {
      await memoryGroupGizmo!.refreshComplex(
        (obj) async {
          final st = await SyncTag.create();
          await withRefs(
            () => RefMemoryGroups(
              self: (table) async {
                // 修改并写入。
                await obj.reset(
                  id: absent(),
                  createdAt: absent(),
                  updatedAt: absent(),
                  memoryModelId: (selectedMemoryModel()?.id).value(),
                  title: title().value(),
                  type: type().value(),
                  // TODO: 变更状态
                  status: absent(),
                  writeSyncTag: st,
                  newLearnCount: absent(),
                  reviewInterval: absent(),
                  filterOut: absent(),
                  displayPriority: absent(),
                );
              },
              // TODO:
              fragmentPermanentMemoryInfos: null,
              // TODO:
              rFragment2MemoryGroups: null,
            ),
          );
          SmartDialog.showToast('修改成功！');
          Navigator.pop(context);
          return true;
        },
      );
      SmartDialog.showToast(await verifyInitCheck.failMessage);
    }
  }

  /// TODO: 要注意修改前与修改后的兼容提示。
  Future<void> commitModifyModifyOtherCheck() async {
    if (await verifyModifyOtherCheck.isVerifyAllOk) {
      await memoryGroupGizmo!.refreshComplex(
        (obj) async {
          final st = await SyncTag.create();
          await withRefs(
            () => RefMemoryGroups(
              self: (table) async {
                // 修改并写入。
                await obj.reset(
                  id: absent(),
                  createdAt: absent(),
                  updatedAt: absent(),
                  memoryModelId: absent(),
                  title: absent(),
                  type: absent(),
                  // TODO: 变更状态
                  status: absent(),
                  writeSyncTag: st,
                  newLearnCount: newLearnCount().value(),
                  reviewInterval: reviewInterval().value(),
                  filterOut: filterOut().value(),
                  displayPriority: displayPriority().value(),
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
      SmartDialog.showToast('启动成功！');
      Navigator.pop(context);
    }
    SmartDialog.showToast(await verifyModifyOtherCheck.failMessage);
  }

  void cancel() {
    showDialogCustom(
      context: context,
      title: '是否要丢弃？',
      okText: '丢弃',
      cancelText: '继续编辑',
      okBack: () => OkBackType.dismissAndPop,
    );
  }
}
