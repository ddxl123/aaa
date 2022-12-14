import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

import '../page/edit/MemoryGroupGizmoEditPage/MemoryGroupGizmoEditPage.dart';
import '../page/edit/MemoryModelGizmoEditPage.dart';
import '../page/edit/edit_page_type.dart';

Future<void> pushToMemoryModelGizmoEditPageOfCreate({required BuildContext context}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => MemoryModelGizmoEditPage(
        memoryModelGizmo: Ab(null),
        editPageType: MemoryModelGizmoEditPageType.create.ab,
      ),
    ),
  );
}

Future<void> pushToMemoryGroupGizmoEditPageOfModify({
  required BuildContext context,
  required Ab<MemoryGroup> memoryGroupAb,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MemoryGroupGizmoEditPage(
        editPageType: MemoryGroupGizmoEditPageType.modify,
        memoryGroupAb: memoryGroupAb,
      ),
    ),
  );
}
