import 'dart:async';
import 'dart:math';

import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';

class TestHomeAbController extends AbController {
  final user = Ab<User?>(null);

  final textEditingController = TextEditingController();

  final analysisResult = '无结果'.ab;

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await getUser();
  }

  @override
  Widget loadingWidget() {
    return const Center(
      child: Text('加载中...'),
    );
  }

  Future<void> getUser() async {
    final result = await DriftDb.instance.generalQueryDAO.queryUserOrNull();
    user.refreshInevitable((obj) => result);
  }

  // Future<void> inserts() async {
  //   const count = 5;
  //   for (int i = 0; i < count; i++) {
  //     final fg = await DriftDb.instance.insertDAO.insertFragmentGroupWithRef(
  //       WithCrts.fragmentGroupsCompanion(
  //         fatherFragmentGroupId: null.toValue(),
  //         title: 'test ${Random().nextInt(999999)}',
  //       ),
  //     );
  //     for (int i = 0; i < count; i++) {
  //       await DriftDb.instance.insertDAO.insertFragmentWithRef(
  //         willFragment: WithCrts.fragmentsCompanion(
  //           fatherFragmentId: null.toValue(),
  //           title: 'test ${Random().nextInt(999999)}',
  //           priority: 0,
  //         ),
  //       );
  //     }
  //
  //     for (int i = 0; i < count; i++) {
  //       final fg1 = await DriftDb.instance.insertDAO.insertFragmentGroupWithRef(
  //         WithCrts.fragmentGroupsCompanion(
  //           fatherFragmentGroupId: fg.id.toValue(),
  //           title: 'test ${Random().nextInt(999999)}',
  //         ),
  //       );
  //       for (int i = 0; i < count; i++) {
  //         await DriftDb.instance.insertDAO.insertFragmentWithRef(
  //           willFragment: WithCrts.fragmentsCompanion(
  //             fatherFragmentId: fg.id.toValue(),
  //             title: 'test ${Random().nextInt(999999)}',
  //             priority: 0,
  //           ),
  //         );
  //       }
  //
  //       for (int i = 0; i < count; i++) {
  //         final fg2 = await DriftDb.instance.insertDAO.insertFragmentGroupWithRef(
  //           WithCrts.fragmentGroupsCompanion(
  //             fatherFragmentGroupId: fg1.id.toValue(),
  //             title: 'test ${Random().nextInt(999999)}',
  //           ),
  //         );
  //         for (int i = 0; i < count; i++) {
  //           await DriftDb.instance.insertDAO.insertFragmentWithRef(
  //             willFragment: WithCrts.fragmentsCompanion(
  //               fatherFragmentId: fg1.id.toValue(),
  //               title: 'test ${Random().nextInt(999999)}',
  //               priority: 0,
  //             ),
  //           );
  //         }
  //
  //         for (int i = 0; i < count; i++) {
  //           await DriftDb.instance.insertDAO.insertFragmentWithRef(
  //             willFragment: WithCrts.fragmentsCompanion(
  //               fatherFragmentId: fg2.id.toValue(),
  //               title: 'test ${Random().nextInt(999999)}',
  //               priority: 0,
  //             ),
  //           );
  //         }
  //       }
  //     }
  //   }
  //
  //   for (int i = 0; i < count; i++) {
  //     await DriftDb.instance.insertDAO.insertMemoryModelWithRef(
  //       WithCrts.memoryModelsCompanion(
  //         title: 'test ${Random().nextInt(999999)}',
  //         familiarityAlgorithm: '',
  //         nextTimeAlgorithm: '',
  //         buttonAlgorithm: '',
  //         applicableGroups: '',
  //         applicableFields: '',
  //         stimulateAlgorithm: '',
  //       ),
  //     );
  //   }
  // }
}
