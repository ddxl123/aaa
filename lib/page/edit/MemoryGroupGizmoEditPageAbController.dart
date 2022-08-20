import 'package:aaa/page/stage/InAppStage.dart';
import 'package:aaa/tool/annotation.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/dialog.dart';
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

  /// 查看 [MemoryGroups.title]。
  final title = ''.ab
    ..initVerify(
      isNotOk2FailMessage: {
        (v) => v().trim() == '': '标题不能为空！',
      },
    );

  /// 查看 [MemoryGroups.memoryModelId]。
  final selectedMemoryModel = Ab<MemoryModel?>(null)
    ..initVerify(
      isNotOk2FailMessage: {
        (v) => v() == null: '记忆模型不能为空！',
      },
    );

  /// 查看 [MemoryGroups.type]。
  final type = MemoryGroupType.inApp.ab;

  /// 查看 [MemoryGroups.status]。
  final status = MemoryGroupStatus.notInit.ab;

  /// 已存碎片
  final selectedFragments = <Ab<Fragment>>[].ab;

  ///

  /// 查看 [MemoryGroups.newLearnCount]。
  final newLearnCount = 0.ab;

  /// 查看 [MemoryGroups.reviewInterval]
  /// TODO: 进行 [Verify]
  final reviewInterval = DateTime.now().ab
    ..initVerify(
      isNotOk2FailMessage: {
        (v) => v().millisecondsSinceEpoch < 0: '复习区间存在不规范字符！',
        (v) => v().isBefore(DateTime.now().add(const Duration(minutes: 10))): '复习区间太短啦~',
      },
    );

  /// 查看 [MemoryGroups.filterOut]
  /// TODO: 进行 [Verify]
  final filterOut = ''.ab;

  final newReviewDisplayOrder = NewReviewDisplayOrder.mix.ab;

  /// 查看 [MemoryGroups.newReviewDisplayOrder]
  final newDisplayOrder = NewDisplayOrder.random.ab;

  /// =====

  /// 当前记忆组碎片总数。
  final totalCount = 0.ab;

  /// 当前记忆组未学习的数量。
  final notLearnCount = 0.ab;

  VerifyMany get verifyInitCheck => VerifyMany(
        verifyMany: [
          title.verify,
          selectedMemoryModel.verify,
        ],
      );

  /// TODO: [reviewInterval]/[filterOut]
  VerifyMany get verifyModifyOtherCheck => VerifyMany(
        verifyMany: [
          reviewInterval.verify,
        ],
      );

  @override
  bool get isEnableLoading => true;

  @override
  Widget loadingWidget() => const Material(child: Center(child: Text('加载中...')));

  @override
  Future<void> loadingFuture() async {
    await filterFuture(
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
    final fs = await DriftDb.instance.singleDAO.queryFragmentsInMemoryGroup(mgg.id);
    final mm = await DriftDb.instance.singleDAO.queryMemoryModelById(memoryModelId: mgg.memoryModelId);

    title.refreshEasy((oldValue) => mgg.title);
    titleTextEditingController.text = mgg.title;
    selectedMemoryModel.refreshEasy((obj) => mm);
    type.refreshEasy((oldValue) => mgg.type);
    status.refreshEasy((oldValue) => mgg.status);
    selectedFragments.refreshInevitable((obj) => obj
      ..clear_(this)
      ..addAll(fs.map((e) => e.ab)));
  }

  Future<void> initModifyOtherCheck() async {
    final mgg = memoryGroupGizmo!();
    newLearnCount.refreshEasy((obj) => mgg.newLearnCount);
    reviewInterval.refreshEasy((oldValue) => mgg.reviewInterval);
    filterOut.refreshEasy((oldValue) => mgg.filterOut);
    newReviewDisplayOrder.refreshEasy((oldValue) => mgg.newReviewDisplayOrder);

    // TODO:
    totalCount.refreshEasy((oldValue) => 567);
    notLearnCount.refreshEasy((oldValue) => 345);
  }

  Future<void> commitModifyInitCheck() async {
    if (await verifyInitCheck.isVerifyAllOk) {
      await memoryGroupGizmo!.refreshComplex(
        (obj) async {
          final st = await SyncTag.create();
          await withRefs(
            () async {
              return RefMemoryGroups(
                self: (table) async {
                  // 修改并写入。
                  await obj.reset(
                    id: absent(),
                    createdAt: absent(),
                    updatedAt: absent(),
                    memoryModelId: (selectedMemoryModel()?.id).value(),
                    title: title().value(),
                    type: type().value(),
                    status: MemoryGroupStatus.notStart.value(),
                    writeSyncTag: st,
                    newLearnCount: absent(),
                    reviewInterval: absent(),
                    filterOut: absent(),
                    newReviewDisplayOrder: absent(),
                    newDisplayOrder: absent(),
                  );
                },
                // TODO:
                fragmentPermanentMemoryInfos: null,
                // TODO:
                rFragment2MemoryGroups: null,
              );
            },
          );
          return true;
        },
      );

      SmartDialog.showToast('初始化成功！');
      Navigator.pop(context);
      return;
    }
    SmartDialog.showToast(await verifyInitCheck.failMessage);
  }

  /// TODO: 要注意修改前与修改后的兼容提示。
  Future<void> commitModifyModifyOtherCheck() async {
    SmartDialog.showLoading(msg: '验证中...', backDismiss: false);
    await Future.delayed(const Duration(milliseconds: 500));
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
                  newReviewDisplayOrder: newReviewDisplayOrder().value(),
                  newDisplayOrder: newDisplayOrder().value(),
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

      SmartDialog.dismiss();
      SmartDialog.showToast('启动成功！');
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => InAppStage(memoryGroupGizmo: memoryGroupGizmo!)));
      return;
    }
    SmartDialog.dismiss();
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
