import 'dart:async';
import 'dart:math';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift/drift.dart';
import 'package:drift/extensions/json1.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';

class TestHomeAbController extends AbController {
  final textEditingController = TextEditingController();

  final analysisResult = '无结果'.ab;

  @override
  bool get isEnableLoading => true;

  @override
  Widget loadingWidget() {
    return const Center(
      child: Text('加载中...'),
    );
  }

  Future<void> inserts() async {
    // await insertTests();
    await insertsOther();
  }

  Future<void> insertTests() async {
    for (int i = 0; i < 10; i++) {
      final t = await db.into(db.tests).insertReturning(
            TestsCompanion.insert(local_content: '["ddd",${Random().nextInt(100)},333]', createdAt: DateTime.now(), updatedAt: DateTime.now()),
          );
      print(t);
    }
    print('-------------');
    final secondValue = db.tests.local_content.jsonExtract<int>(r'$[1]');
    final selOnly = db.selectOnly(db.tests)
      ..addColumns([secondValue])
      ..where(secondValue.isSmallerOrEqualValue(50));
    final result = await selOnly.get();
    logger.d(result.map((e) => e.read(secondValue)));
  }

  Future<void> insertsOther() async {
    final globalAbController = Aber.find<GlobalAbController>();
    await globalAbController.getLoggedInUser();
    if (globalAbController.loggedInUser() == null) {
      final user = await DriftDb.instance.insertDAO.insertUser();
      globalAbController.loggedInUser.refreshEasy((oldValue) => user);
    }

    const count = 5;
    Future<List<FragmentGroup>> foreach({required FragmentGroup? fatherFragmentGroup}) async {
      await Future.delayed(const Duration(seconds: 1));
      final subGroup = <FragmentGroup>[];
      for (int i = 0; i < count; i++) {
        final fg = await DriftDb.instance.insertDAO.insertFragmentGroupWithRef(
          Crt.fragmentGroupsCompanion(
            creatorUserId: globalAbController.loggedInUser()!.id,
            title: 'test ${Random().nextInt(999999)}',
            fatherFragmentGroupsId: (fatherFragmentGroup?.id).toValue(),
            local_isSelected: false,
          ),
        );
        subGroup.add(fg);
        for (int i = 0; i < count; i++) {
          await DriftDb.instance.insertDAO.insertFragmentWithRef(
            willFragment: Crt.fragmentsCompanion(
              creatorUserId: globalAbController.loggedInUser()!.id,
              fatherFragmentId: null.toValue(),
              content: 'test ${Random().nextInt(999999)}',
              local_isSelected: false,
              noteId: null.toValue(),
            ),
            willFragmentGroup: null,
          );
        }
        for (int i = 0; i < count; i++) {
          await DriftDb.instance.insertDAO.insertFragmentWithRef(
            willFragment: Crt.fragmentsCompanion(
              creatorUserId: globalAbController.loggedInUser()!.id,
              fatherFragmentId: null.toValue(),
              content: 'test ${Random().nextInt(999999)}',
              local_isSelected: false,
              noteId: null.toValue(),
            ),
            willFragmentGroup: fg.toCompanion(false),
          );
        }
      }
      return subGroup;
    }

    final ones = await foreach(fatherFragmentGroup: null);

    final twos = <FragmentGroup>[];
    await Future.forEach<FragmentGroup>(
      ones,
      (element) async {
        twos.addAll(await foreach(fatherFragmentGroup: element));
      },
    );

    final threes = <FragmentGroup>[];
    await Future.forEach<FragmentGroup>(
      twos,
      (element) async {
        threes.addAll(await foreach(fatherFragmentGroup: element));
      },
    );

// for (int i = 0; i < count; i++) {
//   await DriftDb.instance.insertDAO.insertMemoryModelWithRef(
//     WithCrts.memoryModelsCompanion(
//       title: 'test ${Random().nextInt(999999)}',
//       familiarityAlgorithm: '',
//       nextTimeAlgorithm: '',
//       buttonAlgorithm: '',
//       applicableGroups: '',
//       applicableFields: '',
//       stimulateAlgorithm: '',
//     ),
//   );
// }
  }
}
