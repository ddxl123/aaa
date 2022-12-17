import 'dart:convert';

import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';

class FragmentGizmoEditPageAbController extends AbController {
  FragmentGizmoEditPageAbController({required this.fragmentAb});

  /// 若为 null，则表示创建，否则为修改。
  final Ab<Fragment>? fragmentAb;
  late final q.QuillController quillController;

  @override
  void onInit() {
    super.onInit();
    if (fragmentAb == null) {
      _createInit();
    } else {
      _updateInit();
    }
  }

  void _createInit() {
    quillController = q.QuillController.basic();
  }

  void _updateInit() {
    quillController = q.QuillController(
      document: q.Document.fromJson(jsonDecode(fragmentAb!().content)),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  String richToJson() => jsonEncode(quillController.document.toDelta().toJson());

  Future<void> create() async {
    // await db.insertDAO.insertFragmentWithRef(willFragment: willFragment, willFragmentGroup: willFragmentGroup, syncTag: syncTag)
  }
}
