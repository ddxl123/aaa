import 'dart:math';
import 'package:aaa/algorithm_parser/parser.dart';
import 'package:aaa/page/stage/InAppStageAbController.dart';
import 'package:drift/drift.dart';
import 'package:drift/extensions/json1.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';

class PerformerQuery {
  /// 获取新的表演者，获取到的碎片信息是该碎片的最后一次记录。
  ///
  /// [Fragment] 表示当前新展示的碎片。
  ///
  /// [FragmentMemoryInfo]s 为当前记忆组当前碎片的全部记忆信息（不包含当前新展示的信息，因为当前新展示的信息未被创建）。
  /// 按照时间顺序排序，last 为 [FragmentMemoryInfo.isLatestRecord] 为 true 的记录。
  ///
  /// 若 [FragmentMemoryInfo]s 数组为空，则当前碎片是新碎片。
  ///
  /// 为 null 时表示没有下一个了，即已完成学习。
  Future<Performer?> getNewPerformer({required MemoryGroup mg}) async {
    final newPerformer = await getOneNewFragment(mg: mg);
    final learnedFragment = await getOneLearnedFragment(mg: mg);

    logger.d('获取到的新碎片：\n${newPerformer?.fragmentMemoryInfo}\n${newPerformer?.fragment}');
    logger.d('获取到的复习碎片：\n${learnedFragment?.fragmentMemoryInfo}\n${learnedFragment?.fragment}');

    if (newPerformer == null && learnedFragment == null) return null;

    late final Performer? performer;
    if (mg.newReviewDisplayOrder == NewReviewDisplayOrder.mix) {
      performer = Random().nextBool() == true ? (newPerformer ?? learnedFragment) : (learnedFragment ?? newPerformer);
    } else if (mg.newReviewDisplayOrder == NewReviewDisplayOrder.reviewNew) {
      performer = learnedFragment ?? newPerformer;
    } else if (mg.newReviewDisplayOrder == NewReviewDisplayOrder.newReview) {
      performer = newPerformer ?? learnedFragment;
    } else {
      throw '未处理 ${mg.newReviewDisplayOrder}';
    }
    if (performer!.fragmentMemoryInfo.nextPlanShowTime == null) {
      logger.d('最终展示了新碎片！');
    } else {
      logger.d('最终展示了复习碎片！');
    }
    return performer;
  }

  /// 获取新碎片。
  Future<Performer?> getOneNewFragment({required MemoryGroup mg}) async {
    // 识别是否还需要学习新碎片。
    if (mg.willNewLearnCount == 0) {
      return null;
    }
    final selInfo = db.select(db.fragmentMemoryInfos);
    selInfo.where((tbl) => tbl.memoryGroupId.equals(mg.id) & tbl.nextPlanShowTime.isNull());
    if (mg.newDisplayOrder == NewDisplayOrder.random) {
      selInfo.orderBy([(_) => OrderingTerm.random()]);
    } else {
      throw '未处理 ${mg.newDisplayOrder}';
    }
    selInfo.limit(1);

    final infoResult = await selInfo.getSingleOrNull();
    if (infoResult == null) return null;

    final selF = db.select(db.fragments)..where((tbl) => tbl.id.equals(infoResult.fragmentId));
    final fResult = await selF.getSingleOrNull();
    if (fResult == null) throw '碎片已经被删除，但是仍然残留了记忆信息！';

    return Performer(fragment: fResult, fragmentMemoryInfo: infoResult);
  }

  /// 获取要复习的碎片。
  Future<Performer?> getOneLearnedFragment({required MemoryGroup mg}) async {
    final lastNextShowTime = db.fragmentMemoryInfos.nextPlanShowTime.jsonExtract<int>(r'$[#-1]');
    final selInfo = db.select(db.fragmentMemoryInfos);
    selInfo.addColumns([lastNextShowTime]);
    selInfo.where((tbl) => tbl.memoryGroupId.equals(mg.id) & tbl.nextPlanShowTime.isNotNull());
    selInfo.orderBy([(o) => OrderingTerm(expression: lastNextShowTime, mode: OrderingMode.asc)]);
    selInfo.limit(1);

    final infoResult = await selInfo.getSingleOrNull();
    if (infoResult == null) return null;

    final selF = db.select(db.fragments)..where((tbl) => tbl.id.equals(infoResult.fragmentId));
    final fResult = await selF.getSingleOrNull();
    if (fResult == null) throw '碎片已经被删除，但是仍然残留了记忆信息！';

    return Performer(fragment: fResult, fragmentMemoryInfo: infoResult);
  }

  /// ========================================================================================

  /// 仅结束当前表演。
  ///
  /// [isNew] - 将产生碎片信息的碎片是否为 新碎片（非复习碎片），
  /// 若为新的，则需要将 [MemoryGroup.willNewLearnCount] 减去 1。
  Future<void> finish({
    required ResetFutureFunction<FragmentMemoryInfo> originalFragmentMemoryInfoReset,
    required MemoryGroup originalMemoryGroup,
    required bool isNew,
    required SyncTag? syncTag,
  }) async {
    await db.updateDAO.resetFragmentMemoryInfoForFinishPerform(
      originalFragmentMemoryInfoReset: originalFragmentMemoryInfoReset,
      originalMemoryGroup: originalMemoryGroup,
      isNew: isNew,
      syncTag: syncTag,
    );
  }

  /// ========================================================================================

  /// [InternalVariableConstant.countAllConst]
  Future<List<int>> getCountAll({required MemoryGroup memoryGroup}) async {
    return [await db.generalQueryDAO.getFragmentsCount(memoryGroup: memoryGroup)];
  }

  /// [InternalVariableConstant.countNewConst]
  Future<List<int>> getCountNew({required MemoryGroup memoryGroup}) async {
    return [await db.generalQueryDAO.getNewFragmentsCount(memoryGroup: memoryGroup)];
  }

  /// TODO:
  // Future<List<int>> getCountLearned({required MemoryGroup memoryGroup}) async {
  //   return [await db.generalQueryDAO.getNewFragmentsCount(memoryGroup: memoryGroup)];
  // }

  /// [InternalVariableConstant.timesConst]
  Future<List<int>> getTimes({required Performer performer}) async {
    return [performer.fragmentMemoryInfo.clickTime?.split(',').length ?? 0];
  }

  /// [InternalVariableConstant.currentActualShowTimeConst]
  Future<List<int>> getCurrentActualShowTimes({
    required Performer performer,
    required int currentShowTime,
  }) async {
    // 最后一个是当前未写入的数据。
    return [
      ...performer.fragmentMemoryInfo.currentActualShowTime == null ? [] : performer.fragmentMemoryInfo.currentActualShowTime!.toIntArray(),
      currentShowTime,
    ];
  }

  /// [InternalVariableConstant.nextPlanedShowTimeConst]
  Future<List<int?>> getNextPlanedShowTime({
    required Performer performer,
    required int? currentNextPlanedShowTime,
  }) async {
    return [
      ...performer.fragmentMemoryInfo.nextPlanShowTime == null ? [] : performer.fragmentMemoryInfo.nextPlanShowTime!.toIntArray(),
      currentNextPlanedShowTime,
    ];
  }

  /// [InternalVariableConstant.showFamiliarConst]
  Future<List<double?>> getShowFamiliar({
    required Performer performer,
    required double? currentShowFamiliar,
  }) async {
    return [
      ...performer.fragmentMemoryInfo.showFamiliarity == null ? [] : performer.fragmentMemoryInfo.showFamiliarity!.toDoubleArray(),
      currentShowFamiliar,
    ];
  }

  Future<List<int?>> getClickTime({
    required Performer performer,
    required int? currentClickTime,
  }) async {
    return [
      ...performer.fragmentMemoryInfo.clickTime == null ? [] : performer.fragmentMemoryInfo.clickTime!.toIntArray(),
      currentClickTime,
    ];
  }

  Future<List<double?>> getClickValue({
    required Performer performer,
    required double? currentClickValue,
  }) async {
    return [
      ...performer.fragmentMemoryInfo.clickValue == null ? [] : performer.fragmentMemoryInfo.clickValue!.toDoubleArray(),
      currentClickValue,
    ];
  }
}
