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
    for (int i = 0; i < 5; i++) {
      final t = await db.into(db.tests).insertReturning(
            TestsCompanion.insert(local_content: Random().nextInt(10).toString(), createdAt: DateTime.now(), updatedAt: DateTime.now()),
          );
      await Future.delayed(const Duration(milliseconds: 1000));
      print(t);
    }
    for (int i = 0; i < 5; i++) {
      final t = await db.into(db.test2s).insertReturning(
            Test2sCompanion.insert(local_content: Random().nextInt(10).toString(), createdAt: DateTime.now(), updatedAt: DateTime.now()),
          );
      await Future.delayed(const Duration(milliseconds: 1000));
      print(t);
    }
    print('-------------');
    // final selOnly = db.select(db.tests)
    //   ..groupBy([db.tests.local_content]);
    // final result = await selOnly.get();
    // logger.d(result.map((e) => e.rawData.data).toList().length);
  }

  Future<void> insertsOther() async {
    final globalAbController = Aber.find<GlobalAbController>();
    await globalAbController.getLoggedInUser();
    if (globalAbController.loggedInUser() == null) {
      final user = await DriftDb.instance.insertDAO.insertUser();
      globalAbController.loggedInUser.refreshEasy((oldValue) => user);
    }

    const count = 5;
    final st = await SyncTag.create();
    Future<List<FragmentGroup>> foreach({required FragmentGroup? fatherFragmentGroup}) async {
      await Future.delayed(const Duration(seconds: 1));
      final subGroup = <FragmentGroup>[];
      for (int i = 0; i < count; i++) {
        final fg = await DriftDb.instance.insertDAO.insertFragmentGroup(
          willFragmentGroupsCompanion: Crt.fragmentGroupsCompanion(
            creatorUserId: globalAbController.loggedInUser()!.id,
            title: 'test ${Random().nextInt(999999)}',
            fatherFragmentGroupsId: (fatherFragmentGroup?.id).toValue(),
            local_isSelected: false,
          ),
          syncTag: st,
        );
        subGroup.add(fg);
        for (int i = 0; i < count; i++) {
          await DriftDb.instance.insertDAO.insertFragment(
            willFragmentsCompanion: Crt.fragmentsCompanion(
              creatorUserId: globalAbController.loggedInUser()!.id,
              fatherFragmentId: null.toValue(),
              fragmentTemplateId: null.toValue(),
              title: '标题 ${Random().nextInt(999999)}',
              content: '内容 ${Random().nextInt(999999)}',
              local_isSelected: false,
              noteId: null.toValue(),
            ),
            whichFragmentGroups: [null],
            syncTag: st,
          );
        }
        for (int i = 0; i < count; i++) {
          await DriftDb.instance.insertDAO.insertFragment(
            willFragmentsCompanion: Crt.fragmentsCompanion(
              creatorUserId: globalAbController.loggedInUser()!.id,
              fatherFragmentId: null.toValue(),
              fragmentTemplateId: null.toValue(),
              title: '标题 ${Random().nextInt(999999)}',
              content: '内容 ${Random().nextInt(999999)}',
              local_isSelected: false,
              noteId: null.toValue(),
            ),
            whichFragmentGroups: [fg],
            syncTag: st,
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
