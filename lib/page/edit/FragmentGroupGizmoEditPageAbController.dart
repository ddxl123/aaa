import 'dart:convert';

import 'package:aaa/single_dialog/showFragmentGroupTagSearchDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FragmentGroupGizmoEditPageAbController extends AbController {
  FragmentGroupGizmoEditPageAbController({
    required this.fragmentGroupAb,
  });

  final Ab<FragmentGroup?> fragmentGroupAb;

  final fragmentGroupTagAb = <FragmentGroupTag>[].ab;
  final titleTextEditingController = TextEditingController();
  final titleFocusNode = FocusNode();
  final profileQuillController = QuillController.basic();
  final profileFocusNode = FocusNode();

  final isShowToolBar = false.ab;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    titleFocusNode.addListener(() {
      if (titleFocusNode.hasFocus) {
        isShowToolBar.refreshEasy((oldValue) => false);
      }
    });
    profileFocusNode.addListener(() {
      if (profileFocusNode.hasFocus) {
        isShowToolBar.refreshEasy((oldValue) => true);
      }
    });

    titleTextEditingController.text = fragmentGroupAb()!.title;
    profileQuillController.document =
        Document.fromJson(jsonDecode(fragmentGroupAb()!.profile.trim() == "" ? jsonEncode(Document().toDelta().toJson()) : fragmentGroupAb()!.profile));

    final tags = await db.generalQueryDAO.queryFragmentGroupTagByFragmentGroupId(fragmentGroupId: fragmentGroupAb()!.id);
    fragmentGroupTagAb.refreshEasy((oldValue) => oldValue
      ..clear()
      ..addAll(tags));
  }

  Future<void> addTag() async {
    await showFragmentGroupTagSearchDialog(initTags: fragmentGroupTagAb, fragmentGroup: fragmentGroupAb()!);
  }

  /// 返回是否被修改。
  Future<bool> isModifyContent() async {
    final saved = await db.generalQueryDAO.queryFragmentGroupById(id: fragmentGroupAb()!.id);
    if (saved!.title != titleTextEditingController.text) {
      return true;
    }
    if (saved.profile != jsonEncode(profileQuillController.document.toDelta().toJson())) {
      return true;
    }
    return false;
  }

  Future<void> save() async {
    if (titleTextEditingController.text.isEmpty) {
      SmartDialog.showToast("标题不能为空！");
      return;
    }
    final isModified = await isModifyContent();
    if (isModified) {
      final st = await SyncTag.create();
      await fragmentGroupAb()!.reset(
        be_private: toAbsent(),
        be_publish: toAbsent(),
        client_be_selected: toAbsent(),
        creator_user_id: toAbsent(),
        father_fragment_groups_id: toAbsent(),
        title: titleTextEditingController.text.toValue(),
        profile: jsonEncode(profileQuillController.document.toDelta().toJson()).toValue(),
        syncTag: st,
      );
      SmartDialog.showToast("更新成功！");
    }
    abBack();
  }
}
