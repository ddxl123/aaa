import 'package:drift_main/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'edit_page_type.dart';

class MemoryGroupGizmoEditPageAbController extends AbController {
  /// 把 gizmo 内所以信息打包成一个对象进行传入。
  /// 如果只传入 [memoryGroupGizmo] 的话，会缺少 [selectedMemoryModel]、[selectedFragments] 等，修改它们后， gizmo 外的数据并没有被刷新。
  MemoryGroupGizmoEditPageAbController({required this.editPageType, required this.memoryGroupGizmo});

  final MemoryGroupGizmoEditPageType editPageType;

  final Ab<MemoryGroup>? memoryGroupGizmo;

  /// 查看 [MemoryGroups.title]。
  final title = ''.ab..initVerify({(v) => v().trim() == '': '标题不能为空！'});

  final titleTextEditingController = TextEditingController();

  /// 查看 [MemoryGroups.memoryModelId]。
  final selectedMemoryModel = Ab<MemoryModel?>(null)..initVerify({(v) => v() == null: '记忆模型不能为空！'});

  /// 查看 [MemoryGroups.type]。
  final type = MemoryGroupType.inApp.ab;

  /// 查看 [MemoryGroups.status]。
  final status = MemoryGroupStatus.notStart.ab;

  /// 已存碎片
  final selectedFragments = <Ab<Fragment>>[].ab;

  /// =====

  /// 查看 [MemoryGroups.newLearnCount]。
  final newLearnCount = 0.ab;

  /// 查看 [MemoryGroups.reviewInterval]
  /// TODO: 进行 [Verify]
  final reviewInterval = DateTime.now().ab
    ..initVerify(
      {
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

  /// 当前记忆组剩余未学习的数量。
  final notLearnCount = 0.ab;

  VerifyMany get saveVerify => VerifyMany(
        [
          title.verify,
        ],
      );

  /// TODO:
  VerifyMany get analyzeVerify => VerifyMany(
        [
          saveVerify,
          reviewInterval.verify,
        ],
      );

  @override
  bool get isEnableLoading => true;

  @override
  Widget loadingWidget() => const Material(child: Center(child: Text('加载中...')));

  @override
  Future<void> loadingFuture() async {
    final mgg = memoryGroupGizmo!();
    final fs = await DriftDb.instance.queryDAO.queryFragmentsInMemoryGroup(mgg.id);
    final mm = await DriftDb.instance.queryDAO.queryMemoryModelById(memoryModelId: mgg.memoryModelId);

    title.refreshEasy((oldValue) => mgg.title);
    titleTextEditingController.text = title();
    selectedMemoryModel.refreshEasy((obj) => mm);
    type.refreshEasy((oldValue) => mgg.type);
    status.refreshEasy((oldValue) => mgg.status);
    selectedFragments.refreshInevitable((obj) => obj
      ..clear_(this)
      ..addAll(fs.map((e) => e.ab)));

    newLearnCount.refreshEasy((obj) => mgg.newLearnCount);
    reviewInterval.refreshEasy((oldValue) => mgg.reviewInterval);
    filterOut.refreshEasy((oldValue) => mgg.filterOut);
    newReviewDisplayOrder.refreshEasy((oldValue) => mgg.newReviewDisplayOrder);
    newDisplayOrder.refreshEasy((oldValue) => mgg.newDisplayOrder);
    totalCount.refreshEasy((oldValue) => 567);
    notLearnCount.refreshEasy((oldValue) => 345);
  }

  /// 返回的 [Tuple2]：是否成功-消息。
  Future<Tuple2<bool, String>> save() async {
    if (await saveVerify.isVerifyAllOk) {
      await memoryGroupGizmo!.refreshComplex(
        (obj) async {
          await DriftDb.instance.updateDAO.resetMemoryGroup(
            oldMemoryGroupReset: (resetSyncTag) async {
              await obj.reset(
                id: absent(),
                createdAt: absent(),
                updatedAt: absent(),
                memoryModelId: selectedMemoryModel()!.id.value(),
                title: titleTextEditingController.text.value(),
                type: type().value(),
                status: MemoryGroupStatus.notStart.value(),
                newLearnCount: newLearnCount().value(),
                reviewInterval: reviewInterval().value(),
                filterOut: filterOut().value(),
                newReviewDisplayOrder: newReviewDisplayOrder().value(),
                newDisplayOrder: newDisplayOrder().value(),
                writeSyncTag: resetSyncTag,
              );
              title.refreshEasy((oldValue) => titleTextEditingController.text);
            },
          );
          return true;
        },
      );
      return Tuple2(t1: true, t2: '保存成功！');
    } else {
      return Tuple2(t1: false, t2: await saveVerify.failMessage);
    }
  }

  /// 返回的 [Tuple2]：是否成功-消息。
  ///
  /// TODO: 要注意修改前与修改后的兼容提示。
  Future<Tuple2<bool, String>> analyze() async {
    if (await analyzeVerify.isVerifyAllOk) {
      return Tuple2(t1: true, t2: '分析成功！');
    } else {
      return Tuple2(t1: false, t2: await analyzeVerify.failMessage);
    }
  }

  /// 返回的 [Tuple2]：是否成功-消息。
  Future<Tuple2<bool, String>> applyAndStart() async {
    final analyzeResult = await analyze();
    if (!analyzeResult.t1) {
      return analyzeResult;
    }
    final saveResult = await save();
    if (!saveResult.t1) {
      return saveResult;
    }
    return Tuple2(t1: true, t2: '应用并开始成功！');
  }

  void cancel() {
    showOkAndCancel(
      context: context,
      title: '是否要丢弃？',
      okText: '丢弃',
      cancelText: '继续编辑',
      onOk: () {
        SmartDialog.dismiss();
        Navigator.pop(context);
      },
      text: null,
      onCancel: () {
        SmartDialog.dismiss();
      },
    );
  }
}
