import 'dart:async';
import 'dart:math';

import 'package:aaa/global/GlobalAbController.dart';
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
    final globalAbController = Aber.find<GlobalAbController>();
    await globalAbController.getLoggedInUser();
    if (globalAbController.loggedInUser() == null) {
      final user = await DriftDb.instance.insertDAO.insertUser();
      globalAbController.loggedInUser.refreshEasy((oldValue) => user);
    }

    const count = 5;
    Future<void> foreach({required FragmentGroup? fatherFragmentGroup}) async {
      for (int i = 0; i < count; i++) {
        final fg = await DriftDb.instance.insertDAO.insertFragmentGroupWithRef(
          WithCrts.fragmentGroupsCompanion(
            creatorUserId: globalAbController.loggedInUser()!.id,
            title: 'test ${Random().nextInt(999999)}',
            fatherFragmentGroupsId: (fatherFragmentGroup?.id).toValue(),
            isSelected: false,
          ),
        );
        for (int i = 0; i < count; i++) {
          await DriftDb.instance.insertDAO.insertFragmentWithRef(
            willFragment: WithCrts.fragmentsCompanion(
              creatorUserId: globalAbController.loggedInUser()!.id,
              fatherFragmentId: null.toValue(),
              content: 'test ${Random().nextInt(999999)}',
              isSelected: false,
              noteId: null.toValue(),
            ),
            willFragmentGroup: null,
          );
        }
        for (int i = 0; i < count; i++) {
          await DriftDb.instance.insertDAO.insertFragmentWithRef(
            willFragment: WithCrts.fragmentsCompanion(
              creatorUserId: globalAbController.loggedInUser()!.id,
              fatherFragmentId: null.toValue(),
              content: 'test ${Random().nextInt(999999)}',
              isSelected: false,
              noteId: null.toValue(),
            ),
            willFragmentGroup: fg.toCompanion(false),
          );
        }
      }
    }

    await foreach(fatherFragmentGroup: null);

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
