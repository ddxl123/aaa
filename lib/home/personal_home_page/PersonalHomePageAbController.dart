import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/global/tool_widgets/CustomImageWidget.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/http_file_enum.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class PersonalHomePageAbController extends AbController {
  PersonalHomePageAbController({required this.userId});

  final int userId;

  final userName = Ab<String?>(null);

  /// 注意是可访问的完整路径
  final userAvatarCloudPath = Ab<String?>(null);

  /// 关注
  final follow = 0.ab;

  /// 被关注
  final beFollowed = 0.ab;

  /// 碎片创建量
  final createCount = 0.ab;

  /// 碎片收集量
  final collectionCount = 0.ab;

  late final TabController tabController;

  final fragmentsAb = <Fragment>[].ab;

  final fragmentGroupsAb = <FragmentGroup>[].ab;

  final publishFragmentGroupAb = <FragmentGroup>[].ab;

  /// 是否已关注
  final isFollowed = false.ab;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: Navigator.of(context));
    refreshPersonalHomePage();
  }

  /// 是否是当前登录用户
  bool get isSelf => userId == Aber.find<GlobalAbController>().loggedInUser()?.id;

  Future<void> refreshPersonalHomePage() async {
    queryUserInfo();
    queryFirstPage();
    queryPublishPage();
  }

  Future<void> queryUserInfo() async {
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_PERSONAL_HOME_PAGE_USER_INFO,
      dtoData: PersonalHomePageForUserInfoDto(
        user_id: userId,
        dto_padding_1: null,
      ),
      parseResponseVoData: PersonalHomePageForUserInfoVo.fromJson,
    );
    await result.handleCode(
      code70301: (String showMessage, PersonalHomePageForUserInfoVo vo) async {
        userName.refreshEasy((oldValue) => vo.user_info.username);
        userAvatarCloudPath.refreshEasy((oldValue) => vo.user_info.avatar_cloud_path);
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  Future<void> queryFirstPage() async {
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_GROUP_HANDLE_FRAGMENT_GROUP_ONE_SUB_QUERY,
      dtoData: FragmentGroupOneSubQueryDto(
        fragment_group_query_wrapper: FragmentGroupQueryWrapper(
          first_target_user_id: userId,
          is_contain_current_login_user_create: false,
          only_published: false,
          target_fragment_group_id: null,
        ),
        dto_padding_1: null,
      ),
      parseResponseVoData: FragmentGroupOneSubQueryVo.fromJson,
    );

    await result.handleCode(
      code30401: (String showMessage, vo) async {
        fragmentGroupsAb.refreshInevitable((obj) => obj
          ..clear()
          ..addAll(vo.fragment_groups_list));
        fragmentsAb.refreshInevitable(
          (obj) => obj
            ..clear()
            ..addAll(vo.fragments_list.map((e) => e.fragment)),
        );
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  Future<void> queryPublishPage() async {
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_PERSONAL_HOME_PAGE_PUBLISH_PAGE,
      dtoData: PersonalHomePageForPublishPageDto(
        user_id: userId,
        dto_padding_1: null,
      ),
      parseResponseVoData: PersonalHomePageForPublishPageVo.fromJson,
    );
    await result.handleCode(
      code70201: (String showMessage, PersonalHomePageForPublishPageVo vo) async {
        publishFragmentGroupAb.refreshInevitable((obj) => obj
          ..clear()
          ..addAll(vo.fragment_groups_list));
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  /// 头像
  ///
  /// TODO: 更换图片后，虽然重置了缓存和内存，但是显示的图片还是旧的。
  Future<void> showAvatar() async {
    await showCustomDialog(
      builder: (ctx) {
        return GestureDetector(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: DialogWidget(
                fullPadding: EdgeInsets.zero,
                mainVerticalWidgets: [
                  ForceCloudImageWidget(
                    size: null,
                    cloudPath: userAvatarCloudPath(),
                  ),
                ],
                bottomHorizontalButtonWidgets: [],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingRoundCornerButton(
              text: Text("修改头像"),
              onPressed: () async {
                final picker = ImagePicker();
                final result = await picker.pickImage(source: ImageSource.gallery);
                if (result != null) {
                  final cropResult = await ImageCropper().cropImage(
                    sourcePath: result.path,
                    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                  );
                  if (cropResult == null) return;

                  await requestFile(
                    httpFileEnum: HttpFileEnum.userAvatar,
                    filePathWrapper: FilePathWrapper(
                      fileUint8List: await cropResult.readAsBytes(),
                      oldCloudPath: userAvatarCloudPath(),
                    ),
                    fileRequestMethod: FileRequestMethod.upload,
                    isUpdateCache: true,
                    onSuccess: (FilePathWrapper filePathWrapper) async {
                      if (!filePathWrapper.isOldNewSame) {
                        // path 更新至 widget
                        userAvatarCloudPath.refreshInevitable((oldValue) => filePathWrapper.newCloudPath);
                        // path 更新至本地
                        throw "TODO";
                        // (db.update(db.users)..where((tbl) => tbl.id.equals(userId))).write(
                        //   UsersCompanion(
                        //     avatar_cloud_path: filePathWrapper.newCloudPath.toValue(),
                        //   ),
                        // );
                        // 因为当前是修改自己User上的头像，因此刷新全部带有自己的User
                        Aber.find<GlobalAbController>().loggedInUser.refreshInevitable((obj) => obj!..avatar_cloud_path = filePathWrapper.newCloudPath);

                        // path 更新至云端
                        final result = await request(
                          path: HttpPath.POST__LOGIN_REQUIRED_SINGLE_FIELD_MODIFY,
                          dtoData: SingleFieldModifyDto(
                            table_name: db.users.actualTableName,
                            field_name: db.users.avatar_cloud_path.name,
                            row_id: userId,
                            modify_value: filePathWrapper.newCloudPath,
                          ),
                          parseResponseVoData: SingleFieldModifyVo.fromJson,
                        );
                        await result.handleCode(
                          code80101: (String showMessage) async {
                            // 无业务
                          },
                          otherException: (int? code, HttperException httperException, StackTrace st) async {
                            logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
                            throw httperException;
                          },
                        );
                      }
                    },
                    onError: (FilePathWrapper filePathWrapper, e, StackTrace st) async {
                      logger.outError(
                        show: "更改失败！",
                        print: "old:${filePathWrapper.oldCloudPath}, new:${filePathWrapper.newCloudPath}",
                        error: e,
                        stackTrace: st,
                      );
                    },
                  );
                }
              },
            ),
          ),
          onTap: () {
            SmartDialog.dismiss(status: SmartStatus.dialog);
          },
        );
      },
    );
  }
}
