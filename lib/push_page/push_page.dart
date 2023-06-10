import 'package:aaa/page/edit/ShorthandGizmoEditPage.dart';
import 'package:aaa/page/login_register/LoginPage.dart';
import 'package:aaa/page/stage/InAppStage.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

import '../page/edit/FragmentGizmoEditPage/FragmentGizmoEditPage.dart';
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

Future<void> pushToFragmentEditPage({
  required BuildContext context,
  required List<Ab<Fragment>> initSomeBefore,
  required List<Ab<Fragment>> initSomeAfter,
  required Ab<Fragment>? initFragmentAb,
  required List<FragmentGroup>? initFragmentGroupChain,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => FragmentGizmoEditPage(
        initSomeBefore: initSomeBefore,
        initSomeAfter: initSomeAfter,
        initFragmentAb: initFragmentAb,
        initFragmentGroupChain: initFragmentGroupChain,
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
