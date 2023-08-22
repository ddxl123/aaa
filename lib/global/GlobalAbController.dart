import 'dart:ffi';
import 'dart:io';

import 'package:aaa/single_dialog/register_or_login/showAskLoginDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/http_file_enum.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

enum Status {
  normal,
  select,
  memory,
}

enum LoginStatus {
  /// 本地已登录，云端已登录
  localLoginedAndCloudLogined,

  /// 本地已登录，云端未登录
  localLoginedAndCloudNotLogined,

  /// 本地已登录，云端登录检查异常
  localLoginedButCloudException,

  /// 本地未登录
  localNotLogined,

  /// 本地登录检查异常
  localException,
}

class GlobalAbController extends AbController {
  final loggedInUser = Ab<User?>(null);
  final status = Status.normal.ab;

  final beExistUploadData = true.ab;

  late String applicationDocumentsDirectoryPath;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await _getApplicationDocumentsDirectoryPath();
    await checkAndShowIsLoggedIn();
    // uploadSingleGroupSync();
  }

  /// 当 [this] 是相对路径时，该函数将其转换成绝对路径。
  ///
  /// [getApplicationDocumentsDirectory] 是一个异步方法，它返回一个Future对象，该对象包含一个Directory对象，该对象表示应用程序的文档目录。
  ///   - 这个目录是应用程序专用的，只有应用程序本身可以访问。
  ///   - 这个目录通常用于存储应用程序的数据或配置文件。
  /// [Directory.current] 是一个同步方法，它返回一个Directory对象，该对象表示当前目录。
  ///   - 当前目录是指运行应用程序时所在的目录，它可能与应用程序的位置不同。
  ///   - 例如，如果我的应用程序在C:\my_app_folder中，而我使用终端从C:运行应用程序，执行my_app_folder\my_app.exe，那么Directory.current返回C:。
  Future<void> _getApplicationDocumentsDirectoryPath() async {
    applicationDocumentsDirectoryPath = (await getApplicationDocumentsDirectory()).path;
  }

  Future<bool> checkAndShowIsLoggedIn() async {
    SmartDialog.showLoading(msg: "正在检查登录状态...");
    await onlyCheckIsLoggedIn();
    SmartDialog.dismiss(status: SmartStatus.loading);

    // 检查到未登录后的操作
    if (loggedInUser.isAbEmpty()) {
      SmartDialog.showToast('请先登录哦~');
      await showAskLoginDialog();

      final resultUserOrNull = await db.generalQueryDAO.queryUserOrNull();
      final resultClientSyncInfoOrNull = await db.generalQueryDAO.queryClientSyncInfoOrNull();
      if (resultClientSyncInfoOrNull?.token != null) {
        loggedInUser.refreshEasy((oldValue) => resultUserOrNull);
        if (loggedInUser() == null) {
          return false;
        } else {
          return true;
        }
      }
      return false;
    }
    return true;
  }

  /// 返回是否已登录，若返回 null，则检查失败。
  /// 若未登录，则会弹出登录框，如果在登录框中进行了登录或取消了登录，该函数同样返回对应是否登录。
  Future<LoginStatus> onlyCheckIsLoggedIn() async {
    try {
      final userOrNull = await db.generalQueryDAO.queryUserOrNull();
      final clientSyncInfoOrNull = await db.generalQueryDAO.queryClientSyncInfoOrNull();
      if (userOrNull == null || clientSyncInfoOrNull == null) {
        // 只要有一个为空，都将清空数据库。
        await db.deleteDAO.clearDb();
        loggedInUser.refreshEasy((oldValue) => null);
        return LoginStatus.localNotLogined;
      } else {
        if (clientSyncInfoOrNull.token == null) {
          loggedInUser.refreshEasy((oldValue) => null);
          return LoginStatus.localNotLogined;
        } else {
          // 本地已登录，检查服务器端是否已登录。
          final result = await request(
            path: HttpPath.POST__REGISTER_OR_LOGIN_CHECK_LOGIN,
            dtoData: CheckLoginDto(
              device_and_token_bo: DeviceAndTokenBo(
                device_info: clientSyncInfoOrNull.device_info,
                token: clientSyncInfoOrNull.token!,
              ),
              dto_padding_1: null,
            ),
            parseResponseVoData: CheckLoginVo.fromJson,
          );
          return await result.handleCode<LoginStatus>(
            otherException: (int? code, HttperException httperException, StackTrace st) async {
              logger.outError(
                show: "登录检测异常，已切换成离线模式！",
                print: httperException.showMessage,
                error: httperException.debugMessage,
                stackTrace: st,
              );
              loggedInUser.refreshEasy((oldValue) => userOrNull);
              return LoginStatus.localLoginedButCloudException;
            },
            code10301: (String showMessage) async {
              loggedInUser.refreshEasy((oldValue) => userOrNull);
              return LoginStatus.localLoginedAndCloudLogined;
            },
            code10302: (String showMessage) async {
              loggedInUser.refreshEasy((oldValue) => null);
              return LoginStatus.localLoginedAndCloudNotLogined;
            },
          );
        }
      }
    } catch (e, st) {
      logger.outError(show: "检测本地登录异常！", error: e, stackTrace: st);
      loggedInUser.refreshEasy((oldValue) => null);
      return LoginStatus.localException;
    }
  }

  /// 上传全部离线文件
  ///
  /// [count] 单次上传数量
  ///
  /// TODO: 上传完文件后，要再次 [Sync] 才行，否则路径没有被上传。
  Future<void> uploadAllOfflineFiles({required int count}) async {
    throw "TODO";
    final result = await db.generalQueryDAO.queryManyFragmentGroupForCoverImageNeedUpload(count: count);
    if (result.isEmpty) {
      SmartDialog.showToast("已将全部离线文件上传成功！");
      return;
    }
    for (var v in result) {
      if (v.client_cover_local_path != null) {
        await requestFile(
          httpFileEnum: HttpFileEnum.fragmentGroupCover,
          filePathWrapper: FilePathWrapper(
            fileUint8List: await File(v.client_cover_local_path!).readAsBytes(),
            oldCloudPath: null,
          ),
          fileRequestMethod: FileRequestMethod.upload,
          isUpdateCache: false,
          onSuccess: (FilePathWrapper filePathWrapper) async {
            throw "TODO";
            // await v.reset(
            //   be_publish: toAbsent(),
            //   client_be_selected: toAbsent(),
            //   client_cover_local_path: toAbsent(),
            //   cover_cloud_path: filePathWrapper.newCloudPath.toValue(),
            //   creator_user_id: toAbsent(),
            //   father_fragment_groups_id: toAbsent(),
            //   jump_to_fragment_groups_id: toAbsent(),
            //   profile: toAbsent(),
            //   title: toAbsent(),
            //   client_be_cloud_path_upload: false.toValue(),
            //   syncTag: st,
            //   isCloudTableWithSync: true,
            // );
            SmartDialog.showToast("上传成功");
          },
          onError: (FilePathWrapper filePathWrapper, e, StackTrace st) async {
            SmartDialog.showToast("上传失败");
          },
        );
      }
    }
  }
}
