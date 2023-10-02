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
  final followCountAb = 0.ab;

  /// 被关注
  final beFollowedCountAb = 0.ab;

  /// 碎片创建量
  final createCount = 0.ab;

  /// 碎片收集量
  final collectionCount = 0.ab;

  late final TabController tabController;

  final fragmentsAb = <Fragment>[].ab;

  final fragmentGroupsAb = <FragmentGroupWithJumpWrapper>[].ab;

  final publishFragmentGroupAb = <FragmentGroup>[].ab;

  /// 当前已登录 userId 是否关注了 [userId]
  ///
  /// not null - 已关注
  /// null - 未关注
  final followIdForIsExistAb = Ab<int?>(null);

  /// null - 当前页面是当前已登录用户的页面
  /// true - 已关注
  /// false - 未关注
  bool? isFollowed3([Abw? abw]) => followIdForIsExistAb(abw) != null ? true : (Aber.find<GlobalAbController>().loggedInUser()?.id == userId ? null : false);

  bool get isSelf => isFollowed3() == null;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: Navigator.of(context));
    refreshPersonalHomePage();
  }

  Future<void> refreshPersonalHomePage() async {
    queryUserInfo();
    queryFirstPage();
    queryPublishPage();
    queryIsFollowed();
    queryFollowAndBeFollowedCount();
  }

  Future<void> queryUserInfo() async {
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_PERSONAL_HOME_HANDLE_USER_INFO,
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
          ..addAll(vo.fragment_group_with_jump_wrappers_list));
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
      path: HttpPath.POST__NO_LOGIN_REQUIRED_PERSONAL_HOME_HANDLE_PUBLISH_PAGE,
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

  Future<void> queryFollowAndBeFollowedCount() async {
    final result = await request(
      path: HttpPath.GET__NO_LOGIN_REQUIRED_PERSONAL_HOME_HANDLE_FOLLOW_AND_BE_FOLLOWED_COUNT_QUERY,
      dtoData: FollowAndBeFollowedCountQueryDto(
        user_id: userId,
        dto_padding_1: null,
      ),
      parseResponseVoData: FollowAndBeFollowedCountQueryVo.fromJson,
    );
    await result.handleCode(
      code70401: (String showMessage, FollowAndBeFollowedCountQueryVo vo) async {
        followCountAb.refreshEasy((oldValue) => vo.follow_count);
        beFollowedCountAb.refreshEasy((oldValue) => vo.be_followed_count);
        print(vo.follow_count);
        print(vo.be_followed_count);
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
  }

  Future<void> queryIsFollowed() async {
    if (userId == Aber.find<GlobalAbController>().loggedInUser()?.id) {
      return;
    }
    final result = await request(
      path: HttpPath.GET__NO_LOGIN_REQUIRED_PERSONAL_HOME_HANDLE_BE_FOLLOW_QUERY,
      dtoData: BeFollowQueryDto(
        // 如果当前未有用户登录，则抛出当前登录用户未登录异常
        follow_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
        be_followed_user_id: userId,
      ),
      parseResponseVoData: BeFollowQueryVo.fromJson,
    );
    await result.handleCode(
      code70501: (String showMessage, BeFollowQueryVo vo) async {
        followIdForIsExistAb.refreshEasy((oldValue) => vo.user_follow_id);
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
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
            floatingActionButton: isSelf
                ? FloatingRoundCornerButton(
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
                                  table_name: driftDb.users.actualTableName,
                                  field_name: driftDb.users.avatar_cloud_path.name,
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
                  )
                : null,
          ),
          onTap: () {
            SmartDialog.dismiss(status: SmartStatus.dialog);
          },
        );
      },
    );
  }

  Future<void> clickFollowed() async {
    if (isFollowed3() == true) {
      await requestSingleRowDelete(
        isLoginRequired: true,
        singleRowDeleteDto: SingleRowDeleteDto(
          table_name: driftDb.userFollows.actualTableName,
          row_id: followIdForIsExistAb()!,
        ),
        onSuccess: (String showMessage) async {
          followIdForIsExistAb.refreshEasy((oldValue) => null);
          beFollowedCountAb.refreshEasy((oldValue) => oldValue - 1);
        },
        onError: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    } else if (isFollowed3() == false) {
      await requestSingleRowInsert(
        isLoginRequired: true,
        singleRowInsertDto: SingleRowInsertDto(
          table_name: driftDb.userFollows.actualTableName,
          row: Crt.userFollowEntity(
            follow_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
            be_followed_user_id: userId,
          ),
        ),
        onSuccess: (String showMessage, vo) async {
          followIdForIsExistAb.refreshEasy((oldValue) => UserFollow.fromJson(vo.row).id);
          beFollowedCountAb.refreshEasy((oldValue) => oldValue + 1);
        },
        onError: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    } else {
      // TODO: 个人资料编辑页
    }
  }
}
