import 'dart:convert';

import 'package:aaa/single_dialog/showFragmentGroupTagSearchDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FragmentGroupGizmoEditPageAbController extends AbController {
  FragmentGroupGizmoEditPageAbController({
    required this.currentDynamicFragmentGroupAb,
  });

  final Ab<FragmentGroup?> currentDynamicFragmentGroupAb;

  final fragmentGroupTagsAb = <FragmentGroupTag>[].ab;
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

    titleTextEditingController.text = currentDynamicFragmentGroupAb()!.title;
    profileQuillController.document =
        Document.fromJson(jsonDecode(currentDynamicFragmentGroupAb()!.profile.trim() == "" ? jsonEncode(Document().toDelta().toJson()) : currentDynamicFragmentGroupAb()!.profile));

    final tags = await db.generalQueryDAO.queryFragmentGroupTagsByFragmentGroupId(fragmentGroupId: currentDynamicFragmentGroupAb()!.id);
    fragmentGroupTagsAb.refreshInevitable((oldValue) => oldValue
      ..clear()
      ..addAll(tags));
  }

  Future<void> addTag() async {
    await showFragmentGroupTagSearchDialog(initTags: fragmentGroupTagsAb, fragmentGroup: currentDynamicFragmentGroupAb()!);
  }

  /// 返回是否被修改。
  Future<
      ({
        bool isModify,
        ({bool isTitleModify, String now}) title,
        ({bool isProfileModify, String now}) profile,
        ({bool isFragmentGroupTagModify, List<FragmentGroupTag> now, List<FragmentGroupTag> saved}) fragmentGroupTag,
      })> isModifyContent() async {
    final saved = await db.generalQueryDAO.queryFragmentGroupById(id: currentDynamicFragmentGroupAb()!.id);
    final nowTitle = titleTextEditingController.text;
    final nowProfile = jsonEncode(profileQuillController.document.toDelta().toJson());
    bool isTitleModify = false;
    bool isProfileModify = false;
    bool isFragmentGroupTagModify = false;

    if (saved!.title != nowTitle) {
      isTitleModify = true;
    }
    if (saved.profile != nowProfile) {
      isProfileModify = true;
    }

    final savedTags = await db.generalQueryDAO.queryFragmentGroupTagsByFragmentGroupId(fragmentGroupId: currentDynamicFragmentGroupAb()!.id);
    savedTags.sort((a, b) => a.tag.compareTo(b.tag));
    fragmentGroupTagsAb().sort((a, b) => a.tag.compareTo(b.tag));
    if (!listEquals(savedTags, fragmentGroupTagsAb())) {
      isFragmentGroupTagModify = true;
    }

    return (
      isModify: isTitleModify || isProfileModify || isFragmentGroupTagModify,
      title: (isTitleModify: isTitleModify, now: nowTitle),
      profile: (isProfileModify: isProfileModify, now: nowProfile),
      fragmentGroupTag: (isFragmentGroupTagModify: isFragmentGroupTagModify, now: fragmentGroupTagsAb(), saved: savedTags),
    );
  }

  Future<void> save() async {
    if (titleTextEditingController.text.isEmpty) {
      SmartDialog.showToast("标题不能为空！");
      return;
    }
    final modify = await isModifyContent();
    if (modify.isModify) {
      final st = await SyncTag.create();
      await RefFragmentGroups(
        self: () async {
          if (modify.title.isTitleModify || modify.profile.isProfileModify) {
            await currentDynamicFragmentGroupAb()!.reset(
              be_publish: toAbsent(),
              client_be_selected: toAbsent(),
              creator_user_id: toAbsent(),
              father_fragment_groups_id: toAbsent(),
              jump_to_fragment_groups_id: toAbsent(),
              title: modify.title.now.toValue(),
              profile: modify.profile.now.toValue(),
              syncTag: st,
              isCloudTableWithSync: true,
            );
          }
        },
        fragmentGroupTags: RefFragmentGroupTags(
          self: () async {
            if (modify.fragmentGroupTag.isFragmentGroupTagModify) {
              for (var fTag in modify.fragmentGroupTag.saved) {
                await fTag.delete(
                  syncTag: st,
                  isCloudTableWithSync: true,
                );
              }
              for (var fTag in modify.fragmentGroupTag.now) {
                await fTag.toCompanion(false).insert(
                      syncTag: st,
                      isCloudTableWithSync: true,
                      isCloudTableAutoId: true,
                      isReplaceWhenIdSame: false,
                    );
              }
            }
          },
          order: 0,
        ),
        rFragment2FragmentGroups: null,
        fragmentGroups_father_fragment_groups_id: null,
        fragmentGroups_jump_to_fragment_groups_id: null,
        userComments: null,
        userLikes: null,
        order: 0,
      ).run();
      SmartDialog.showToast("更新成功！");
    }
    abBack();
  }
}
