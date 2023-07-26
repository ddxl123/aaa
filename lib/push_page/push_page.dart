import 'package:aaa/page/edit/ShorthandGizmoEditPage.dart';
import 'package:aaa/page/login_register/LoginPage.dart';
import 'package:aaa/page/stage/InAppStage.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

import '../page/edit/FragmentGizmoEditPage/FragmentGizmoEditPage.dart';
import '../page/edit/FragmentGizmoEditPage/FragmentGizmoEditPageAbController.dart';
import '../page/edit/MemoryGroupGizmoEditPage/MemoryGroupGizmoEditPage.dart';
import '../page/edit/MemoryModelGizomoEditPage/MemoryModelGizmoEditPage.dart';
import '../page/edit/edit_page_type.dart';

Future<void> pushToMemoryModelGizmoEditPage({
  required BuildContext context,
  required Ab<MemoryModel> memoryModelAb,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => MemoryModelGizmoEditPage(
        memoryModelAb: memoryModelAb,
      ),
    ),
  );
}

Future<void> pushToMemoryGroupGizmoEditPageOfModify({
  required BuildContext context,
  required String memoryGroupId,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MemoryGroupGizmoEditPage(
        editPageType: MemoryGroupGizmoEditPageType.modify,
        memoryGroupId: memoryGroupId,
      ),
    ),
  );
}

Future<void> pushToFragmentPerformerPage({
  required BuildContext context,
  required List<Fragment> initSomeBefore,
  required List<Fragment> initSomeAfter,
  required Fragment? initFragmentAb,
  required List<FragmentGroup>? initFragmentGroupChain,
  required Ab<FragmentPerformerType> fragmentPerformerTypeAb,
  required bool isTailNew,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => FragmentGizmoEditPage(
        initSomeBefore: initSomeBefore,
        initSomeAfter: initSomeAfter,
        initFragment: initFragmentAb,
        initFragmentGroupChain: initFragmentGroupChain,
        fragmentPerformerTypeAb: fragmentPerformerTypeAb,
        isTailNew: isTailNew,
      ),
    ),
  );
}

Future<void> pushToLoginPage({required BuildContext context}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginPage(),
    ),
  );
}

Future<void> pushToShorthandGizmoEditPage({
  required BuildContext context,
  required Shorthand? initShorthand,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ShorthandGizmoEditPage(initShorthand: initShorthand),
    ),
  );
}

Future<void> pushToInAppStage({
  required BuildContext context,
  required String memoryGroupId,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => InAppStage(memoryGroupId: memoryGroupId),
    ),
  );
}
