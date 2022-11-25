import 'package:aaa/page/edit/MemoryModelGizmoEditPage.dart';
import 'package:aaa/page/edit/edit_page_type.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';

class MemoryModelGizmoPage extends StatefulWidget {
  const MemoryModelGizmoPage({Key? key, required this.memoryModelGizmo}) : super(key: key);
  final Ab<MemoryModel?> memoryModelGizmo;

  @override
  State<MemoryModelGizmoPage> createState() => _MemoryModelGizmoPageState();
}

class _MemoryModelGizmoPageState extends State<MemoryModelGizmoPage> {
  @override
  Widget build(BuildContext context) {
    return MemoryModelGizmoEditPage(
      editPageType: MemoryModelGizmoEditPageType.look.ab,
      memoryModelGizmo: widget.memoryModelGizmo,
    );
  }
}
