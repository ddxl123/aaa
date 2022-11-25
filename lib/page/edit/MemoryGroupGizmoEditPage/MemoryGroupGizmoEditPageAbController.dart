import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/edit/MemoryGroupGizmoEditPage/Storage.dart';
import 'package:aaa/page/stage/InAppStage.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../edit_page_type.dart';

class MemoryGroupGizmoEditPageAbController extends AbController {
  /// 把 gizmo 内所以信息打包成一个对象进行传入。
  /// 如果只传入 [memoryGroupGizmo] 的话，会缺少 [bSelectedMemoryModel]、[bSelectedFragments] 等，修改它们后， gizmo 外的数据并没有被刷新。
  MemoryGroupGizmoEditPageAbController({required this.editPageType, required this.memoryGroupGizmo});

  final MemoryGroupGizmoEditPageType editPageType;

  final Ab<MemoryGroup>? memoryGroupGizmo;

  /// ========== 可操作-基础配置部分 ==========

  /// [MemoryGroups.title]
  final bTitle = Storage<String>(abObj: ''.ab, tempValue: '');
  final bcTitleTextEditingController = TextEditingController();

  /// [MemoryGroups.memoryModelId]
  final bSelectedMemoryModel = Storage<MemoryModel?>(abObj: Ab<MemoryModel?>(null), tempValue: null);

  final bSelectedFragments = <Ab<Fragment>>[].ab;

  /// ========== 可操作-基础配置部分 ==========

  ///

  /// ========== 可操作-当前周期配置部分 ==========

  /// [MemoryGroups.willNewLearnCount]
  final cWillNewLearnCount = Storage<int>(abObj: 0.ab, tempValue: 0);

  /// [MemoryGroups.reviewInterval]
  /// TODO: 进行 [AbVerify]
  final cReviewInterval = Storage<DateTime>(abObj: DateTime.now().ab, tempValue: DateTime.now());
  final ccReviewIntervalTextEditingController = TextEditingController();

  /// [MemoryGroups.newReviewDisplayOrder]
  final cNewReviewDisplayOrder = Storage<NewReviewDisplayOrder>(abObj: NewReviewDisplayOrder.mix.ab, tempValue: NewReviewDisplayOrder.mix);

  /// [MemoryGroups.newDisplayOrder]
  final cNewDisplayOrder = Storage<NewDisplayOrder>(abObj: NewDisplayOrder.random.ab, tempValue: NewDisplayOrder.random);

  /// =========================================================================================

  /// ========== 可操作-当前周期配置部分 ==========

  ///

  /// ========== 不可操作-其他部分 ==========

  /// 当前记忆组剩余未学习的数量。
  final Ab<int> remainNewFragmentsCount = 0.ab;

  /// 是否全部展开
  final isExpandAll = false.ab;

  /// 是否基础配置标题栏红字报错。
  final isBasicConfigRedErr = false.ab;

  /// 是否当前周期配置标题栏红字报错。
  final isCurrentCycleRedErr = false.ab;

  /// ========== 不可操作-其他部分 ==========

  @override
  void onDispose() {
    super.onDispose();
    bcTitleTextEditingController.dispose();
    ccReviewIntervalTextEditingController.dispose();
  }

  @override
  void initComplexVerifies() {
    bTitle.abObj.initVerify(
      (abV) async {
        if (abV().trim() == '') return VerifyResult(isOk: false, message: '标题不能为空！');
        return null;
      },
    );

    bSelectedMemoryModel.abObj.initVerify(
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

    cReviewInterval.abObj.initVerify(
      (abV) async {
        if (abV().difference(DateTime.now()).inSeconds < 600) return VerifyResult(isOk: false, message: '复习区间至少10分钟(600秒)以上哦~');
        return null;
      },
    );
  }

  Future<bool> get basicConfigRedErrVerify async => await AbVerify.checkMany(
        [
          bTitle.abObj.verify,
          bSelectedMemoryModel.abObj.verify,
        ],
      );

  Future<bool> get currentCycleConfigRedErrVerify async => await AbVerify.checkMany(
        [
          cReviewInterval.abObj.verify,
        ],
      );

  Future<bool> get saveVerify async => await AbVerify.checkMany(
        [
          bTitle.abObj.verify,
        ],
      );

  Future<bool> get analyzeVerify async => await AbVerify.checkMany(
        [
          bTitle.abObj.verify,
          bSelectedMemoryModel.abObj.verify,
          cReviewInterval.abObj.verify,
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

    // 保存初始值
    bTitle
      ..tempValue = mgg.title
      ..abObj.refreshEasy((oldValue) => mgg.title);
    bcTitleTextEditingController.text = mgg.title;
    bSelectedMemoryModel
      ..tempValue = mm
      ..abObj.refreshEasy((obj) => mm);
    bSelectedFragments.refreshInevitable((obj) => obj
      ..clear_(this)
      ..addAll(fs.map((e) => e.ab)));

    cWillNewLearnCount
      ..tempValue = mgg.willNewLearnCount
      ..abObj.refreshEasy((obj) => mgg.willNewLearnCount);
    cReviewInterval
      ..tempValue = mgg.reviewInterval
      ..abObj.refreshEasy((oldValue) => mgg.reviewInterval);
    ccReviewIntervalTextEditingController.text = timeDifference(target: mgg.reviewInterval, start: DateTime.now()).toString();
    cNewReviewDisplayOrder
      ..tempValue = mgg.newReviewDisplayOrder
      ..abObj.refreshEasy((oldValue) => mgg.newReviewDisplayOrder);
    cNewReviewDisplayOrder
      ..tempValue = mgg.newReviewDisplayOrder
      ..abObj.refreshEasy((oldValue) => mgg.newReviewDisplayOrder);
    cNewDisplayOrder
      ..tempValue = mgg.newDisplayOrder
      ..abObj.refreshEasy((oldValue) => mgg.newDisplayOrder);

    final count = await DriftDb.instance.generalQueryDAO.getNewFragmentsCount(mg: mgg);
    remainNewFragmentsCount.refreshEasy((oldValue) => count);
  }

  /// 仅保存。
  Future<void> save() async {
    await _save(isApply: false).then(
      (value) async {
        await bTitle.abObj.verify.check();
        isBasicConfigRedErr.refreshEasy((oldValue) => !bTitle.abObj.verify.isOk);
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
      // await DriftDb.instance.updateDAO.resetMemoryGroup(
      //   syncTag: null,
      //   oldMemoryGroupReset: (resetSyncTag) async {
      //     await memoryGroupGizmo!().reset(
      //       startTime: isApply ? DateTime.now().toValue() : toAbsent(),
      //       memoryModelId: (bSelectedMemoryModel.abObj()?.id).toValue(),
      //       title: bTitle.abObj().toValue(),
      //       willNewLearnCount: cWillNewLearnCount.abObj().toValue(),
      //       reviewInterval: cReviewInterval.abObj().toValue(),
      //       newReviewDisplayOrder: cNewReviewDisplayOrder.abObj().toValue(),
      //       newDisplayOrder: cNewDisplayOrder.abObj().toValue(),
      //       writeSyncTag: resetSyncTag,
      //     );
      //   },
      // );
      // memoryGroupGizmo!.refreshForce();
      return Tuple2(t1: true, t2: '保存成功！');
    } else {
      return Tuple2(t1: false, t2: '保存失败！');
    }
  }

  Future<void> analyze() async {
    await _analyze().then(
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
