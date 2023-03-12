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

    logger.outNormal(print: '获取到的新碎片：\n${newPerformer?.fragmentMemoryInfo}\n${newPerformer?.fragment}');
    logger.outNormal(print: '获取到的复习碎片：\n${learnedFragment?.fragmentMemoryInfo}\n${learnedFragment?.fragment}');

    if (newPerformer == null && learnedFragment == null) return null;

    late final Performer? performer;
    if (mg.new_review_display_order == NewReviewDisplayOrder.mix) {
      performer = Random().nextBool() == true ? (newPerformer ?? learnedFragment) : (learnedFragment ?? newPerformer);
    } else if (mg.new_review_display_order == NewReviewDisplayOrder.review_new) {
      performer = learnedFragment ?? newPerformer;
    } else if (mg.new_review_display_order == NewReviewDisplayOrder.new_review) {
      performer = newPerformer ?? learnedFragment;
    } else {
      throw '未处理 ${mg.new_review_display_order}';
    }
    if (performer!.fragmentMemoryInfo.next_plan_show_time == null) {
      logger.outNormal(print: '最终展示了新碎片！');
    } else {
      logger.outNormal(print: '最终展示了复习碎片！');
    }
    return performer;
  }

  /// 获取新碎片。
  Future<Performer?> getOneNewFragment({required MemoryGroup mg}) async {
    // 识别是否还需要学习新碎片。
    if (mg.will_new_learn_count == 0) {
      return null;
    }
    final selInfo = db.select(db.fragmentMemoryInfos);
    selInfo.where((tbl) => tbl.memory_group_id.equals(mg.id) & tbl.next_plan_show_time.isNull());
    if (mg.new_display_order == NewDisplayOrder.random) {
      selInfo.orderBy([(_) => OrderingTerm.random()]);
    } else {
      throw '未处理 ${mg.new_display_order}';
    }
    selInfo.limit(1);

    final infoResult = await selInfo.getSingleOrNull();
    if (infoResult == null) return null;

    final selF = db.select(db.fragments)..where((tbl) => tbl.id.equals(infoResult.fragment_id));
    final fResult = await selF.getSingleOrNull();
    if (fResult == null) throw '碎片已经被删除，但是仍然残留了记忆信息！';

    return Performer(fragment: fResult, fragmentMemoryInfo: infoResult);
  }

  /// 获取要复习的碎片。
  Future<Performer?> getOneLearnedFragment({required MemoryGroup mg}) async {
    final lastNextShowTime = db.fragmentMemoryInfos.next_plan_show_time.jsonExtract<int>(r'$[#-1]');
    final selInfo = db.select(db.fragmentMemoryInfos);
    selInfo.addColumns([lastNextShowTime]);
    selInfo.where((tbl) => tbl.memory_group_id.equals(mg.id) & tbl.next_plan_show_time.isNotNull());
    selInfo.orderBy([(o) => OrderingTerm(expression: lastNextShowTime, mode: OrderingMode.asc)]);
    selInfo.limit(1);

    final infoResult = await selInfo.getSingleOrNull();
    if (infoResult == null) return null;

    final selF = db.select(db.fragments)..where((tbl) => tbl.id.equals(infoResult.fragment_id));
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
  }) async {
    await db.updateDAO.resetFragmentMemoryInfoForFinishPerform(
      originalFragmentMemoryInfoReset: originalFragmentMemoryInfoReset,
      originalMemoryGroup: originalMemoryGroup,
      isNew: isNew,
      syncTag: await SyncTag.create(),
    );
  }

  /// ========================================================================================

  /// [InternalVariableConstant.countAllConst]
  Future<List<int>> getCountAll({required MemoryGroup memoryGroup}) async {
    return [await db.generalQueryDAO.queryFragmentsCount(memoryGroup: memoryGroup)];
  }

  /// [InternalVariableConstant.countNewConst]
  Future<List<int>> getCountNew({required MemoryGroup memoryGroup}) async {
    return [await db.generalQueryDAO.queryNewFragmentsCount(memoryGroup: memoryGroup)];
  }

  /// TODO:
  // Future<List<int>> getCountLearned({required MemoryGroup memoryGroup}) async {
  //   return [await db.generalQueryDAO.getNewFragmentsCount(memoryGroup: memoryGroup)];
  // }

  /// [InternalVariableConstant.timesConst]
  Future<List<int>> getTimes({required Performer performer}) async {
    return [performer.fragmentMemoryInfo.click_time?.split(',').length ?? 0];
  }

  /// [InternalVariableConstant.currentActualShowTimeConst]
  Future<List<int>> getCurrentActualShowTimes({
    required Performer performer,
    required int currentShowTime,
  }) async {
    // 最后一个是当前未写入的数据。
    return [
      ...performer.fragmentMemoryInfo.current_actual_show_time == null ? [] : performer.fragmentMemoryInfo.current_actual_show_time!.toIntArray(),
      currentShowTime,
    ];
  }

  /// [InternalVariableConstant.nextPlanedShowTimeConst]
  Future<List<int?>> getNextPlanedShowTime({
    required Performer performer,
    required int? currentNextPlanedShowTime,
  }) async {
    return [
      ...performer.fragmentMemoryInfo.next_plan_show_time == null ? [] : performer.fragmentMemoryInfo.next_plan_show_time!.toIntArray(),
      currentNextPlanedShowTime,
    ];
  }

  /// [InternalVariableConstant.showFamiliarConst]
  Future<List<double?>> getShowFamiliar({
    required Performer performer,
    required double? currentShowFamiliar,
  }) async {
    return [
      ...performer.fragmentMemoryInfo.show_familiarity == null ? [] : performer.fragmentMemoryInfo.show_familiarity!.toDoubleArray(),
      currentShowFamiliar,
    ];
  }

  Future<List<int?>> getClickTime({
    required Performer performer,
    required int? currentClickTime,
  }) async {
    return [
      ...performer.fragmentMemoryInfo.click_time == null ? [] : performer.fragmentMemoryInfo.click_time!.toIntArray(),
      currentClickTime,
    ];
  }

  Future<List<double?>> getClickValue({
    required Performer performer,
    required double? currentClickValue,
  }) async {
    return [
      ...performer.fragmentMemoryInfo.click_value == null ? [] : performer.fragmentMemoryInfo.click_value!.toDoubleArray(),
      currentClickValue,
    ];
  }
}
