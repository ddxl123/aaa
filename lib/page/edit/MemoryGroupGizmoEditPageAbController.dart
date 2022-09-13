import 'package:aaa/other/verify_parse.dart';
import 'package:aaa/page/stage/InAppStage.dart';
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

  /// ========== 可操作-基础配置部分 ==========

  /// [MemoryGroups.title]
  final title = ''.ab;
  String _title = '';
  final titleTextEditingController = TextEditingController();

  /// [MemoryGroups.memoryModelId]
  final selectedMemoryModel = Ab<MemoryModel?>(null);
  MemoryModel? _selectedMemoryModel;

  /// [MemoryGroups.type]
  final type = MemoryGroupType.inApp.ab;
  MemoryGroupType _type = MemoryGroupType.inApp;

  /// [MemoryGroups.status]
  final status = MemoryGroupStatus.notStart.ab;
  MemoryGroupStatus _status = MemoryGroupStatus.notStart;

  final selectedFragments = <Ab<Fragment>>[].ab;

  /// ========== 可操作-基础配置部分 ==========

  ///

  /// ========== 可操作-当前周期配置部分 ==========

  /// [MemoryGroups.willNewLearnCount]
  final willNewLearnCount = 0.ab;
  int _willNewLearnCount = 0;

  /// [MemoryGroups.reviewInterval]
  /// TODO: 进行 [AbVerify]
  final reviewInterval = DateTime
      .now()
      .ab;
  DateTime _reviewInterval = DateTime.now();
  final reviewIntervalTextEditingController = TextEditingController();

  /// [MemoryGroups.filterOut]
  /// TODO: 进行 [AbVerify]
  final filterOut = ''.ab;
  String _filterOut = '';

  /// [MemoryGroups.newReviewDisplayOrder]
  final newReviewDisplayOrder = NewReviewDisplayOrder.mix.ab;
  NewReviewDisplayOrder _newReviewDisplayOrder = NewReviewDisplayOrder.mix;

  /// [MemoryGroups.newDisplayOrder]
  final newDisplayOrder = NewDisplayOrder.random.ab;
  NewDisplayOrder _newDisplayOrder = NewDisplayOrder.random;

  /// ========== 可操作-当前周期配置部分 ==========

  ///

  /// ========== 不可操作-其他部分 ==========

  /// 当前记忆组剩余未学习的数量。
  final notLearnCount = 0.ab;

  /// 是否全部展开
  final isExpandAll = false.ab;

  final isBasicConfigRedErr = false.ab;

  final isCurrentCycleRedErr = false.ab;

  /// ========== 不可操作-其他部分 ==========

  @override
  void initComplexVerifies() {
    title.initVerify(
          (abV) {
        if (abV().trim() == '') return VerifyResult(isOk: false, message: '标题不能为空！');
        return null;
      },
    );

    selectedMemoryModel.initVerify(
          (abV) async {
        if (abV() == null) return VerifyResult(isOk: false, message: '记忆模型不能为空！');

        final result = await DriftDb.instance.queryDAO.queryMemoryModelById(memoryModelId: abV()!.id);
        if (result == null) return VerifyResult(isOk: false, message: '未查询到所选记忆模型的数据实体！');

        final vResult = await vMemoryModelButtonDataVerifyKey(verifyValue: result.buttonData);
        return vResult.t1.isOk ? vResult.t1 : VerifyResult(isOk: false, message: '记忆模型不符合规范！\n可以尝试修改模型配置或更换模型！');
      },
    );

    reviewInterval.initVerify(
          (abV) async {
        if (abV().millisecondsSinceEpoch < 0) return VerifyResult(isOk: false, message: '复习区间存在不规范字符！');
        if (abV().isBefore(DateTime.now().add(const Duration(minutes: 10))))
          return VerifyResult(isOk: false, message: '复习区间太短啦，至少10分钟以上哦~');
        return null;
      },
    );
  }

  Future<bool> get basicConfigRedErrVerify async =>
      await AbVerify.checkMany(
        [
          title.verify,
          selectedMemoryModel.verify,
        ],
      );

  Future<bool> get currentCycleConfigRedErrVerify async =>
      await AbVerify.checkMany(
        [
          reviewInterval.verify,
        ],
      );

  Future<bool> get saveVerify async =>
      await AbVerify.checkMany(
        [
          title.verify,
        ],
      );

  Future<bool> get analyzeVerify async =>
      await AbVerify.checkMany(
        [
          title.verify,
          selectedMemoryModel.verify,
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

    _title = mgg.title;
    _selectedMemoryModel = mm;
    _type = mgg.type;
    _status = mgg.status;

    _willNewLearnCount = mgg.newLearnCount;
    _reviewInterval = mgg.reviewInterval;
    _filterOut = mgg.filterOut;
    _newReviewDisplayOrder = mgg.newReviewDisplayOrder;
    _newDisplayOrder = mgg.newDisplayOrder;

    title.refreshEasy((oldValue) => _title);
    selectedMemoryModel.refreshEasy((obj) => _selectedMemoryModel);
    type.refreshEasy((oldValue) => _type);
    status.refreshEasy((oldValue) => _status);
    selectedFragments.refreshInevitable((obj) =>
    obj
      ..clear_(this)
      ..addAll(fs.map((e) => e.ab)));

    willNewLearnCount.refreshEasy((obj) => _willNewLearnCount);
    reviewInterval.refreshEasy((oldValue) => _reviewInterval);
    filterOut.refreshEasy((oldValue) => _filterOut);
    newReviewDisplayOrder.refreshEasy((oldValue) => _newReviewDisplayOrder);
    newDisplayOrder.refreshEasy((oldValue) => _newDisplayOrder);

    await DriftDb.instance.queryDAO.queryFragmentsInMemoryGroupForNotLearnCount(memoryGroupId)
    notLearnCount.refreshEasy((oldValue) => 345);

    titleTextEditingController.text = _title;
    reviewIntervalTextEditingController.text = _reviewInterval
        .difference(DateTime.now())
        .inMinutes
        .toString();
  }

  void save() {
    _save().then(
          (value) {
        isBasicConfigRedErr.refreshEasy(
              (oldValue) async {
            await title.verify.check();
            return !title.verify.isOk;
          },
        );
        if (value.t1) {
          SmartDialog.showToast('保存成功！');
          Navigator.pop(context);
        } else {
          SmartDialog.showToast(value.t2);
        }
      },
    );
  }

  /// 返回的 [Tuple2]：是否成功-消息。
  Future<Tuple2<bool, String>> _save() async {
    if (await saveVerify) {
      await memoryGroupGizmo!.refreshComplex(
            (obj) async {
          await DriftDb.instance.updateDAO.resetMemoryGroup(
            oldMemoryGroupReset: (resetSyncTag) async {
              await obj.reset(
                id: absent(),
                createdAt: absent(),
                updatedAt: absent(),
                memoryModelId: (selectedMemoryModel()?.id).value(),
                title: titleTextEditingController.text.value(),
                type: type().value(),
                status: MemoryGroupStatus.notStart.value(),
                newLearnCount: willNewLearnCount().value(),
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
      return Tuple2(t1: false, t2: '保存失败！');
    }
  }

  void analyze() {
    _analyze().then(
          (value) {
        isBasicConfigRedErr.refreshEasy((oldValue) async => !await basicConfigRedErrVerify);
        isCurrentCycleRedErr.refreshEasy((oldValue) async => !await currentCycleConfigRedErrVerify);
        SmartDialog.showToast(value.t2);
      },
    );
  }

  /// 返回的 [Tuple2]：是否成功-消息。
  ///
  /// TODO: 要注意修改前与修改后的兼容提示。
  Future<Tuple2<bool, String>> _analyze() async {
    if (await analyzeVerify) {
      return Tuple2(t1: true, t2: '分析成功！');
    } else {
      return Tuple2(t1: false, t2: '分析失败！');
    }
  }

  void applyAndStart() {
    _applyAndStart().then(
          (value) {
        isBasicConfigRedErr.refreshEasy((oldValue) async => !await basicConfigRedErrVerify);
        isCurrentCycleRedErr.refreshEasy((oldValue) async => !await currentCycleConfigRedErrVerify);
        if (value.t1) {
          SmartDialog.showToast(value.t2);
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (_) => InAppStage(memoryGroupGizmo: memoryGroupGizmo!)));
        } else {
          SmartDialog.showToast(value.t2);
        }
      },
    );
  }

  /// 返回的 [Tuple2]：是否成功-消息。
  Future<Tuple2<bool, String>> _applyAndStart() async {
    final analyzeResult = await _analyze();
    if (!analyzeResult.t1) {
      return analyzeResult;
    }
    final saveResult = await _save();
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
