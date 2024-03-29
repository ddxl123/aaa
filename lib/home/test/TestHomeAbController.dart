import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';

class TestHomeAbController extends AbController {
  final textEditingController = TextEditingController();

  final analysisResult = '无结果'.ab;

  final imageUnit8List = Ab<Uint8List?>(null);

  @override
  bool get isEnableLoading => true;

  @override
  Widget loadingWidget() {
    return const Center(
      child: Text('加载中...'),
    );
  }

  Future<void> inserts() async {
    await insertTests();
    // await insertsOther();
  }

  Future<void> insertTests() async {
    // for (int i = 0; i < 5; i++) {
    //   final t = await db.into(db.tests).insertReturning(
    //         TestsCompanion.insert(client_content: Random().nextInt(10).toString(), created_at: DateTime.now(), updated_at: DateTime.now(), client_a: ''),
    //       );
    //   // await Future.delayed(const Duration(milliseconds: 1000));
    //   print(t);
    // }
    // for (int i = 0; i < 5; i++) {
    //   final t = await db.into(db.test2s).insertReturning(
    //         Test2sCompanion.insert(client_content: Random().nextInt(10).toString(), created_at: DateTime.now(), updated_at: DateTime.now()),
    //       );
    //   // await Future.delayed(const Duration(milliseconds: 1000));
    //   print(t);
    // }
    print('-------------');
    // final selOnly = db.select(db.tests)
    //   ..groupBy([db.tests.client_content]);
    // final result = await selOnly.get();
    // logger.d(result.map((e) => e.rawData.data).toList().length);
  }

//   Future<void> insertsOther() async {
//     final globalAbController = Aber.find<GlobalAbController>();
//     await globalAbController.checkIsLoggedIn();
//     if (globalAbController.loggedInUser() == null) {
//       final user = await DriftDb.instance.rawDAO.rawInsertUser(
//         newUsersCompanion: Crt.usersCompanion(
//           age: null.toValue(),
//           email: null.toValue(),
//           password: null.toValue(),
//           phone: null.toValue(),
//           username: "username",
//         ),
//       );
//       globalAbController.loggedInUser.refreshEasy((oldValue) => user);
//     }
//
//     const count = 5;
//     final st = await SyncTag.create();
//     Future<List<FragmentGroup>> foreach({required FragmentGroup? fatherFragmentGroup}) async {
//       await Future.delayed(const Duration(seconds: 1));
//       final subGroup = <FragmentGroup>[];
//       for (int i = 0; i < count; i++) {
//         final fg = await DriftDb.instance.insertDAO.insertFragmentGroup(
//           willFragmentGroupsCompanion: Crt.fragmentGroupsCompanion(
//             creator_user_id: globalAbController.loggedInUser()!.id,
//             title: 'test ${Random().nextInt(999999)}',
//             father_fragment_groups_id: (fatherFragmentGroup?.id).toValue(),
//             client_be_selected: false,
//           ),
//           syncTag: st,
//         );
//         subGroup.add(fg);
//         for (int i = 0; i < count; i++) {
//           await DriftDb.instance.insertDAO.insertFragment(
//             willFragmentsCompanion: Crt.fragmentsCompanion(
//               creator_user_id: globalAbController.loggedInUser()!.id,
//               father_fragment_id: null.toValue(),
//               fragment_template_id: null.toValue(),
//               title: '标题 ${Random().nextInt(999999)}',
//               content: '内容 ${Random().nextInt(999999)}',
//               client_be_selected: false,
//               note_id: null.toValue(),
//             ),
//             whichFragmentGroups: [null],
//             syncTag: st,
//           );
//         }
//         for (int i = 0; i < count; i++) {
//           await DriftDb.instance.insertDAO.insertFragment(
//             willFragmentsCompanion: Crt.fragmentsCompanion(
//               creator_user_id: globalAbController.loggedInUser()!.id,
//               father_fragment_id: null.toValue(),
//               fragment_template_id: null.toValue(),
//               title: '标题 ${Random().nextInt(999999)}',
//               content: '内容 ${Random().nextInt(999999)}',
//               client_be_selected: false,
//               note_id: null.toValue(),
//             ),
//             whichFragmentGroups: [fg],
//             syncTag: st,
//           );
//         }
//       }
//       return subGroup;
//     }
//
//     final ones = await foreach(fatherFragmentGroup: null);
//
//     final twos = <FragmentGroup>[];
//     await Future.forEach<FragmentGroup>(
//       ones,
//       (element) async {
//         twos.addAll(await foreach(fatherFragmentGroup: element));
//       },
//     );
//
//     final threes = <FragmentGroup>[];
//     await Future.forEach<FragmentGroup>(
//       twos,
//       (element) async {
//         threes.addAll(await foreach(fatherFragmentGroup: element));
//       },
//     );
//
// // for (int i = 0; i < count; i++) {
// //   await DriftDb.instance.insertDAO.insertMemoryModelWithRef(
// //     WithCrts.memoryModelsCompanion(
// //       title: 'test ${Random().nextInt(999999)}',
// //       familiarityAlgorithm: '',
// //       nextTimeAlgorithm: '',
// //       buttonAlgorithm: '',
// //       applicableGroups: '',
// //       applicableFields: '',
// //       stimulateAlgorithm: '',
// //     ),
// //   );
// // }
//   }
}
