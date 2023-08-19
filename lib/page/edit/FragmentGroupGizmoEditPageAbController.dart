import 'dart:convert';
import 'dart:io';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/single_dialog/showFragmentGroupTagSearchDialog.dart';
import 'package:aaa/tool/other.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/http_file_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
  final coverPath = Ab<FileMixPath>(FileMixPath(cloudPath: null, localPath: null));

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

    coverPath.refreshInevitable(
      (obj) => obj
        ..cloudPath = currentDynamicFragmentGroupAb()?.cover_cloud_path
        ..localPath = currentDynamicFragmentGroupAb()?.client_cover_local_path,
    );
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
        ({bool isCoverModify, FileMixPath now, FileMixPath saved}) cover,
      })> isModifyContent() async {
    final saved = await db.generalQueryDAO.queryFragmentGroupById(id: currentDynamicFragmentGroupAb()!.id);
    final nowTitle = titleTextEditingController.text;
    final nowProfile = jsonEncode(profileQuillController.document.toDelta().toJson());
    bool isTitleModify = false;
    bool isProfileModify = false;
    bool isFragmentGroupTagModify = false;
    bool isCoverModify = false;

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

    final coverNow = FileMixPath(localPath: coverPath().localPath, cloudPath: coverPath().cloudPath);
    final coverSave = FileMixPath(localPath: saved.client_cover_local_path, cloudPath: saved.cover_cloud_path);
    if (saved.client_cover_local_path != coverPath().localPath || saved.cover_cloud_path != coverPath().cloudPath) {
      isCoverModify = true;
    }

    return (
      isModify: isTitleModify || isProfileModify || isFragmentGroupTagModify || isCoverModify,
      title: (isTitleModify: isTitleModify, now: nowTitle),
      profile: (isProfileModify: isProfileModify, now: nowProfile),
      fragmentGroupTag: (isFragmentGroupTagModify: isFragmentGroupTagModify, now: fragmentGroupTagsAb(), saved: savedTags),
      cover: (isCoverModify: isCoverModify, now: coverNow, saved: coverSave),
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
          if (modify.cover.isCoverModify) {
            // 将裁剪的缓存图片永久存储到本地
            final file = File("${Aber.find<GlobalAbController>().applicationDocumentsDirectoryPath}/${HttpFileEnum.fragmentGroupCover.text}/$uuidV4.jpg");
            if (!await file.exists()) {
              await file.create(recursive: true);
            }
            await file.writeAsBytes(await File(coverPath().localPath!).readAsBytes());
            coverPath.refreshInevitable((obj) => obj..localPath = file.path);
          }

          await currentDynamicFragmentGroupAb()!.reset(
            be_publish: toAbsent(),
            client_be_selected: toAbsent(),
            creator_user_id: toAbsent(),
            father_fragment_groups_id: toAbsent(),
            jump_to_fragment_groups_id: toAbsent(),
            title: modify.title.now.toValue(),
            profile: modify.profile.now.toValue(),
            client_cover_local_path: coverPath().localPath.toValue(),
            cover_cloud_path: coverPath().cloudPath.toValue(),
            client_be_cloud_path_upload: modify.cover.isCoverModify.toValue(),
            syncTag: st,
            isCloudTableWithSync: true,
          );
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

  Future<void> clickCover() async {
    final pickResult = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickResult != null) {
      final cropResult = await ImageCropper().cropImage(
        sourcePath: pickResult.path,
        aspectRatio: CropAspectRatio(
          ratioX: globalFragmentGroupCoverRatio.width,
          ratioY: globalFragmentGroupCoverRatio.height,
        ),
      );
      if (cropResult != null) {
        coverPath.refreshInevitable((obj) => obj..localPath = cropResult.path);
      }
    }
  }
}
