import 'dart:convert';
import 'dart:io';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/single_dialog/showFragmentGroupTagSearchDialog.dart';
import 'package:aaa/tool/other.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
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

  /// 封面是否被修改
  bool isCoverModified = false;

  String get getTitleToSave => titleTextEditingController.text.trim();

  String get getProfileToSave => jsonEncode(profileQuillController.document.toDelta().toJson());

  @override
  Future<bool> backListener(bool hasRoute) async {
    bool isBack = true;
    await showCustomDialog(
      builder: (ctx) {
        return OkAndCancelDialogWidget(
          title: "确定要返回？",
          text: "若存在修改，则修改会被丢弃",
          okText: "确定",
          cancelText: "取消",
          onOk: () {
            SmartDialog.dismiss(status: SmartStatus.dialog);
            isBack = false;
          },
          onCancel: () {
            SmartDialog.dismiss(status: SmartStatus.dialog);
            isBack = true;
          },
        );
      },
    );
    return isBack;
  }

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

    final tagsResult = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_TAG_BY_FRAGMENT_GROUP_ID,
      dtoData: QueryFragmentGroupTagByFragmentGroupIdDto(
        fragment_group_id: currentDynamicFragmentGroupAb()!.id,
        dto_padding_1: null,
      ),
      parseResponseVoData: QueryFragmentGroupTagByFragmentGroupIdVo.fromJson,
    );

    await tagsResult.handleCode(
      code50101: (String showMessage, QueryFragmentGroupTagByFragmentGroupIdVo vo) async {
        fragmentGroupTagsAb.refreshInevitable((oldValue) => oldValue
          ..clear()
          ..addAll(vo.fragment_group_tag_list));
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );

    coverPath.refreshInevitable(
      (obj) => obj
        ..cloudPath = currentDynamicFragmentGroupAb()?.cover_cloud_path
        ..localPath = currentDynamicFragmentGroupAb()?.client_cover_local_path,
    );
  }

  Future<void> addTag() async {
    await showFragmentGroupTagSearchDialog(initTags: fragmentGroupTagsAb, fragmentGroup: currentDynamicFragmentGroupAb()!);
  }

  Future<void> save() async {
    if (titleTextEditingController.text.isEmpty) {
      SmartDialog.showToast("标题不能为空！");
      return;
    }
    // 先上次图片，以获取云端图片链接

    if (isCoverModified) {
      if (coverPath().localPath != null) {
        bool isSuccessForCloudPath = false;
        final fileUint8List = await File(coverPath().localPath!).readAsBytes();
        await requestFile(
          httpFileEnum: HttpFileEnum.fragmentGroupCover,
          filePathWrapper: FilePathWrapper(
            fileUint8List: fileUint8List,
            oldCloudPath: currentDynamicFragmentGroupAb()?.cover_cloud_path,
          ),
          fileRequestMethod: FileRequestMethod.upload,
          isUpdateCache: true,
          onSuccess: (FilePathWrapper filePathWrapper) async {
            coverPath().cloudPath = filePathWrapper.newCloudPath;
            isSuccessForCloudPath = true;
          },
          onError: (FilePathWrapper filePathWrapper, e, StackTrace st) async {
            logger.outError(show: "图片上次失败！", error: e, stackTrace: st);
          },
        );
        if (!isSuccessForCloudPath) return;
      }
    }

    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_MODIFY_FRAGMENT_GROUP,
      dtoData: FragmentGroupModifyDto(
        fragment_group: currentDynamicFragmentGroupAb()!
          ..title = getTitleToSave
          ..profile = getProfileToSave
          ..cover_cloud_path = coverPath().cloudPath,
        fragment_group_tags_list: fragmentGroupTagsAb(),
      ),
      parseResponseVoData: FragmentGroupModifyVo.fromJson,
    );

    await result.handleCode(
      code150101: (String showMessage) async {
        SmartDialog.showToast("修改成功！");
        Navigator.pop(context);
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
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
        isCoverModified = true;
      }
    }
  }
}
