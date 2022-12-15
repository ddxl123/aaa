import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/stage/InAppStage.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class MemoryGroupGizmoEditPageAbController extends AbController {
  /// 把 gizmo 内所以信息打包成一个对象进行传入。
  /// 如果只传入 [memoryGroupAb] 的话，会缺少 [bSelectedMemoryModelStorage]、[bSelectedFragments] 等，修改它们后， gizmo 外的数据并没有被刷新。
  MemoryGroupGizmoEditPageAbController({required this.memoryGroupAb});

  final Ab<MemoryGroup> memoryGroupAb;

  /// ========== 可操作-基础配置部分 ==========

  /// [MemoryGroups.title]
  final bTitleStorage = AbStorage<String>(abValue: ''.ab, tempValue: '');
  final bcTitleTextEditingController = TextEditingController();

  /// [MemoryGroups.memoryModelId]
  final bSelectedMemoryModelStorage = AbStorage<MemoryModel?>(abValue: Ab<MemoryModel?>(null), tempValue: null);

  final bSelectedFragments = <Ab<Fragment>>[].ab;

  /// ========== 可操作-基础配置部分 ==========

  ///

  /// ========== 可操作-当前周期配置部分 ==========

  /// [MemoryGroups.willNewLearnCount]
  final cWillNewLearnCountStorage = AbStorage<int>(abValue: 0.ab, tempValue: 0);

  /// [MemoryGroups.reviewInterval]
  /// TODO: 进行 [AbVerify]
  final cReviewIntervalStorage = AbStorage<DateTime>(abValue: DateTime.now().ab, tempValue: DateTime.now());
  final ccReviewIntervalTextEditingController = TextEditingController();

  /// [MemoryGroups.newReviewDisplayOrder]
  final cNewReviewDisplayOrderStorage = AbStorage<NewReviewDisplayOrder>(abValue: NewReviewDisplayOrder.mix.ab, tempValue: NewReviewDisplayOrder.mix);

  /// [MemoryGroups.newDisplayOrder]
  final cNewDisplayOrderStorage = AbStorage<NewDisplayOrder>(abValue: NewDisplayOrder.random.ab, tempValue: NewDisplayOrder.random);

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

  Future<void> initVerifies() async {
    bTitleStorage.initVerify(
      verifyCallback: (v) async {
        if (v.trim() == '') return '标题不能为空！';
        return null;
      },
    );

    bSelectedMemoryModelStorage.initVerify(
      verifyCallback: (v) async {
        final mm = await db.generalQueryDAO.queryMemoryModelInMemoryGroup(memoryGroup: memoryGroupAb());

        if (mm == null) return '记忆模型不能为空！';

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
        return (fa.exceptionContent != null || ff.exceptionContent != null || bd.exceptionContent != null) ? '记忆模型不符合规范！\n可以尝试修改模型配置或更换模型！' : null;
      },
    );

    cReviewIntervalStorage.initVerify(
      verifyCallback: (v) async {
        if (v.difference(DateTime.now()).inSeconds < 600) return '复习区间至少10分钟(600秒)以上哦~';
        return null;
      },
    );
  }

  @override
  bool get isEnableLoading => true;

  @override
  Widget loadingWidget() => const Material(child: Center(child: Text('加载中...')));

  @override
  Future<void> loadingFuture() async {
    final fs = await db.generalQueryDAO.queryFragmentsInMemoryGroup(memoryGroup: memoryGroupAb());
    final mm = await db.generalQueryDAO.queryMemoryModelInMemoryGroup(memoryGroup: memoryGroupAb());

    // 保存初始值
    bTitleStorage
      ..tempValue = memoryGroupAb().title
      ..abValue.refreshEasy((oldValue) => memoryGroupAb().title);
    bcTitleTextEditingController.text = memoryGroupAb().title;
    bSelectedMemoryModelStorage
      ..tempValue = mm
      ..abValue.refreshEasy((obj) => mm);
    bSelectedFragments.refreshInevitable((obj) => obj
      ..clearBroken(this)
      ..addAll(fs.map((e) => e.ab)));

    cWillNewLearnCountStorage
      ..tempValue = memoryGroupAb().willNewLearnCount
      ..abValue.refreshEasy((obj) => memoryGroupAb().willNewLearnCount);
    cReviewIntervalStorage
      ..tempValue = memoryGroupAb().reviewInterval
      ..abValue.refreshEasy((oldValue) => memoryGroupAb().reviewInterval);
    ccReviewIntervalTextEditingController.text = timeDifference(target: memoryGroupAb().reviewInterval, start: DateTime.now()).toString();
    cNewReviewDisplayOrderStorage
      ..tempValue = memoryGroupAb().newReviewDisplayOrder
      ..abValue.refreshEasy((oldValue) => memoryGroupAb().newReviewDisplayOrder);
    cNewDisplayOrderStorage
      ..tempValue = memoryGroupAb().newDisplayOrder
      ..abValue.refreshEasy((oldValue) => memoryGroupAb().newDisplayOrder);

    final count = await DriftDb.instance.generalQueryDAO.getNewFragmentsCount(mg: memoryGroupAb());
    remainNewFragmentsCount.refreshEasy((oldValue) => count);

    initVerifies();
  }

  /// 返回是否验证成功。
  Future<bool> _saveVerify() async {
    return await bTitleStorage.verify();
  }

  /// 返回是否验证成功。
  ///
  /// 包括了 [_saveVerify]。
  Future<bool> _analyzeVerify() async {
    return boolAllTrue([
      await bTitleStorage.verify(),
      await bSelectedMemoryModelStorage.verify(),
      await cWillNewLearnCountStorage.verify(),
      await cReviewIntervalStorage.verify(),
      await cNewDisplayOrderStorage.verify(),
      await cNewReviewDisplayOrderStorage.verify(),
    ]);
  }

  /// 仅保存数据。
  ///
  /// 若 [isStart] 为 true，则会将启动时间设置为当前时间，否则不变。
  Future<void> _saveMemoryGroup({required bool isStart}) async {
    await db.updateDAO.resetMemoryGroupForOnlySave(
      originalMemoryGroupReset: (st) async {
        return await memoryGroupAb().reset(
          creatorUserId: toAbsent(),
          startTime: isStart ? DateTime.now().toValue() : toAbsent(),
          memoryModelId: (bSelectedMemoryModelStorage.abValue()?.id).toValue(),
          title: bTitleStorage.abValue().toValue(),
          willNewLearnCount: cWillNewLearnCountStorage.abValue().toValue(),
          reviewInterval: cReviewIntervalStorage.abValue().toValue(),
          newReviewDisplayOrder: cNewReviewDisplayOrderStorage.abValue().toValue(),
          newDisplayOrder: cNewDisplayOrderStorage.abValue().toValue(),
          syncTag: st,
        );
      },
      syncTag: null,
    );
    memoryGroupAb.refreshForce();
  }

  /// 仅保存。
  Future<void> onlySave() async {
    final result = await _saveVerify();
    if (result) {
      await _saveMemoryGroup(isStart: false);
      SmartDialog.showToast('保存成功！');
      Navigator.pop(context);
    } else {
      SmartDialog.showToast('保存失败！');
    }
  }

  /// 仅分析
  Future<void> onlyAnalyze() async {
    final result = await _analyzeVerify();
    if (result) {
      SmartDialog.showToast('分析成功！');
    } else {
      SmartDialog.showToast('分析失败！');
    }
  }

  /// 启动
  Future<void> start() async {
    final result = await _analyzeVerify();
    if (result) {
      await _saveMemoryGroup(isStart: true);
      SmartDialog.showToast('分析通过，启动成功！');
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => InAppStage(memoryGroupGizmo: memoryGroupAb)));
    } else {
      SmartDialog.showToast('分析失败！');
    }
  }

  void cancel() {
    showCustomDialog(
      builder: () => OkAndCancelDialogWidget(
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
      ),
    );
  }
}
