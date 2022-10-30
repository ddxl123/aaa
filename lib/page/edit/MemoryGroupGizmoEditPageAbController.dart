import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/stage/InAppStage.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'edit_page_type.dart';

class Storage<V> {
  final Ab<V> abObj;

  /// 存储未修改前的值，该值的用途是恢复未修改前的值。
  V tempValue;

  Storage({required this.abObj, required this.tempValue});
}

class MemoryGroupGizmoEditPageAbController extends AbController {
  /// 把 gizmo 内所以信息打包成一个对象进行传入。
  /// 如果只传入 [memoryGroupGizmo] 的话，会缺少 [selectedMemoryModel]、[selectedFragments] 等，修改它们后， gizmo 外的数据并没有被刷新。
  MemoryGroupGizmoEditPageAbController({required this.editPageType, required this.memoryGroupGizmo});

  final MemoryGroupGizmoEditPageType editPageType;

  final Ab<MemoryGroup>? memoryGroupGizmo;

  /// ========== 可操作-基础配置部分 ==========

  /// [MemoryGroups.title]
  final title = Storage<String>(abObj: ''.ab, tempValue: '');
  final titleTextEditingController = TextEditingController();

  /// [MemoryGroups.memoryModelId]
  final selectedMemoryModel = Storage<MemoryModel?>(abObj: Ab<MemoryModel?>(null), tempValue: null);

  /// [MemoryGroups.type]
  final type = Storage<MemoryGroupType>(abObj: MemoryGroupType.inApp.ab, tempValue: MemoryGroupType.inApp);

  /// [MemoryGroups.status]
  final status = Storage<MemoryGroupStatus>(abObj: MemoryGroupStatus.notStart.ab, tempValue: MemoryGroupStatus.notStart);

  final selectedFragments = <Ab<Fragment>>[].ab;

  /// ========== 可操作-基础配置部分 ==========

  ///

  /// ========== 可操作-当前周期配置部分 ==========

  /// [MemoryGroups.willNewLearnCount]
  final willNewLearnCount = Storage<int>(abObj: 0.ab, tempValue: 0);

  /// [MemoryGroups.reviewInterval]
  /// TODO: 进行 [AbVerify]
  final reviewInterval = Storage<int>(abObj: 0.ab, tempValue: 0);
  final reviewIntervalTextEditingController = TextEditingController();

  /// [MemoryGroups.filterOut]
  /// TODO: 进行 [AbVerify]
  final filterOut = Storage<String>(abObj: ''.ab, tempValue: '');

  /// [MemoryGroups.newReviewDisplayOrder]
  final newReviewDisplayOrder = Storage<NewReviewDisplayOrder>(abObj: NewReviewDisplayOrder.mix.ab, tempValue: NewReviewDisplayOrder.mix);

  /// [MemoryGroups.newDisplayOrder]
  final newDisplayOrder = Storage<NewDisplayOrder>(abObj: NewDisplayOrder.random.ab, tempValue: NewDisplayOrder.random);

  /// ========== 可操作-当前周期配置部分 ==========

  ///

  /// ========== 不可操作-其他部分 ==========

  /// 当前记忆组剩余未学习的数量。
  final Ab<int> remainNewFragmentsCount = 0.ab;

  /// 是否全部展开
  final isExpandAll = false.ab;

  final isBasicConfigRedErr = false.ab;

  final isCurrentCycleRedErr = false.ab;

  /// ========== 不可操作-其他部分 ==========

  @override
  void initComplexVerifies() {
    title.abObj.initVerify(
      (abV) async {
        if (abV().trim() == '') return VerifyResult(isOk: false, message: '标题不能为空！');
        return null;
      },
    );

    selectedMemoryModel.abObj.initVerify(
      (abV) async {
        if (abV() == null) return VerifyResult(isOk: false, message: '记忆模型不能为空！');
        final mm = await DriftDb.instance.generalQueryDAO.queryMemoryModelById(memoryModelId: abV()!.id);
        if (mm == null) return VerifyResult(isOk: false, message: '未查询到对应的记忆模型！');

        // TODO: 模拟校验
        final fa = await AlgorithmParser().parse(
          state: FamiliarityState(
            useContent: mm.familiarityAlgorithm,
            simulationType: SimulationType.syntaxCheck,
            externalResultHandler: null,
          ),
        );
        final ff = await AlgorithmParser().parse(
          state: NextShowTimeState(
            useContent: mm.nextTimeAlgorithm,
            simulationType: SimulationType.syntaxCheck,
            externalResultHandler: null,
          ),
        );
        final bd = await AlgorithmParser().parse(
          state: ButtonDataState(
            useContent: mm.buttonAlgorithm,
            simulationType: SimulationType.syntaxCheck,
            externalResultHandler: null,
          ),
        );
        return (fa.exceptionContent != null || ff.exceptionContent != null || bd.exceptionContent != null)
            ? VerifyResult(isOk: false, message: '记忆模型不符合规范！\n可以尝试修改模型配置或更换模型！')
            : null;
      },
    );

    reviewInterval.abObj.initVerify(
      (abV) async {
        if (abV() < 0) return VerifyResult(isOk: false, message: '复习区间存在不规范字符！');
        if (abV() < 600) return VerifyResult(isOk: false, message: '复习区间太短啦，至少10分钟(600秒)以上哦~');
        return null;
      },
    );
  }

  Future<bool> get basicConfigRedErrVerify async => await AbVerify.checkMany(
        [
          title.abObj.verify,
          selectedMemoryModel.abObj.verify,
        ],
      );

  Future<bool> get currentCycleConfigRedErrVerify async => await AbVerify.checkMany(
        [
          reviewInterval.abObj.verify,
        ],
      );

  Future<bool> get saveVerify async => await AbVerify.checkMany(
        [
          title.abObj.verify,
        ],
      );

  Future<bool> get analyzeVerify async => await AbVerify.checkMany(
        [
          title.abObj.verify,
          selectedMemoryModel.abObj.verify,
          reviewInterval.abObj.verify,
        ],
      );

  @override
  bool get isEnableLoading => true;

  @override
  Widget loadingWidget() => const Material(child: Center(child: Text('加载中...')));

  @override
  Future<void> loadingFuture() async {
    final mgg = memoryGroupGizmo!();
    final fs = await DriftDb.instance.generalQueryDAO.queryAllFragmentsInMemoryGroup(mgg.id);
    final mm = await DriftDb.instance.generalQueryDAO.queryMemoryModelById(memoryModelId: mgg.memoryModelId);

    title.tempValue = mgg.title;
    selectedMemoryModel.tempValue = mm;
    type.tempValue = mgg.type;
    status.tempValue = mgg.status;

    willNewLearnCount.tempValue = mgg.willNewLearnCount;
    reviewInterval.tempValue = mgg.reviewInterval;
    filterOut.tempValue = mgg.filterOut;
    newReviewDisplayOrder.tempValue = mgg.newReviewDisplayOrder;
    newDisplayOrder.tempValue = mgg.newDisplayOrder;

    title.abObj.refreshEasy((oldValue) => title.tempValue);
    selectedMemoryModel.abObj.refreshEasy((obj) => selectedMemoryModel.tempValue);
    type.abObj.refreshEasy((oldValue) => type.tempValue);
    status.abObj.refreshEasy((oldValue) => status.tempValue);
    selectedFragments.refreshInevitable((obj) => obj
      ..clear_(this)
      ..addAll(fs.map((e) => e.ab)));

    willNewLearnCount.abObj.refreshEasy((obj) => willNewLearnCount.tempValue);
    reviewInterval.abObj.refreshEasy((oldValue) => reviewInterval.tempValue);
    filterOut.abObj.refreshEasy((oldValue) => filterOut.tempValue);
    newReviewDisplayOrder.abObj.refreshEasy((oldValue) => newReviewDisplayOrder.tempValue);
    newDisplayOrder.abObj.refreshEasy((oldValue) => newDisplayOrder.tempValue);

    final count = await DriftDb.instance.generalQueryDAO.getNewFragmentsCount(mg: mgg);
    remainNewFragmentsCount.refreshEasy((oldValue) => count);

    titleTextEditingController.text = title.tempValue;
    reviewIntervalTextEditingController.text = reviewInterval.tempValue.toString();
  }

  /// 仅保存。
  void save() {
    _save(isApply: false).then(
      (value) async {
        await title.abObj.verify.check();
        isBasicConfigRedErr.refreshEasy((oldValue) => !title.abObj.verify.isOk);
        if (value.t1) {
          SmartDialog.showToast('保存成功！');
          Navigator.pop(context);
        } else {
          SmartDialog.showToast(value.t2);
        }
      },
    );
  }

  /// 仅保存。
  ///
  /// 返回的 [Tuple2]：是否成功-消息。
  Future<Tuple2<bool, String>> _save({required bool isApply}) async {
    if (await saveVerify) {
      await DriftDb.instance.updateDAO.resetMemoryGroup(
        syncTag: null,
        oldMemoryGroupReset: (resetSyncTag) async {
          await memoryGroupGizmo!().reset(
            startTime: isApply ? DateTime.now().toValue() : toAbsent(),
            memoryModelId: (selectedMemoryModel.abObj()?.id).toValue(),
            title: titleTextEditingController.text.toValue(),
            type: type.abObj().toValue(),
            status: MemoryGroupStatus.notStart.toValue(),
            willNewLearnCount: willNewLearnCount.abObj().toValue(),
            reviewInterval: reviewInterval.abObj().toValue(),
            filterOut: filterOut.abObj().toValue(),
            newReviewDisplayOrder: newReviewDisplayOrder.abObj().toValue(),
            newDisplayOrder: newDisplayOrder.abObj().toValue(),
            writeSyncTag: resetSyncTag,
          );
          title.abObj.refreshEasy((oldValue) => titleTextEditingController.text);
        },
      );
      memoryGroupGizmo!.refreshForce();
      return Tuple2(t1: true, t2: '保存成功！');
    } else {
      return Tuple2(t1: false, t2: '保存失败！');
    }
  }

  void analyze() {
    _analyze().then(
      (value) async {
        final ibcre = !await basicConfigRedErrVerify;
        final iccre = !await currentCycleConfigRedErrVerify;
        isBasicConfigRedErr.refreshEasy((oldValue) => ibcre);
        isCurrentCycleRedErr.refreshEasy((oldValue) => iccre);
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

  /// 保存并开始。
  Future<void> applyAndStart() async {
    await _applyAndStart().then(
      (value) async {
        final ibcre = !await basicConfigRedErrVerify;
        final iccre = !await currentCycleConfigRedErrVerify;
        isBasicConfigRedErr.refreshEasy((oldValue) => ibcre);
        isCurrentCycleRedErr.refreshEasy((oldValue) => iccre);
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

  /// 保存并开始。
  ///
  /// 返回的 [Tuple2]：是否成功-消息。
  Future<Tuple2<bool, String>> _applyAndStart() async {
    final analyzeResult = await _analyze();
    if (!analyzeResult.t1) {
      return analyzeResult;
    }
    final saveResult = await _save(isApply: true);
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
