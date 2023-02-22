import 'package:aaa/single_dialog/register_or_login/showAskLoginDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';
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

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await checkAndShowIsLoggedIn();
    // uploadSingleGroupSync();
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
            path: HttpPath.REGISTER_OR_LOGIN_CHECK_LOGIN,
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

  /// 上传 tag 最小的一组 sync 数据
  Future<void> uploadSingleGroupSync({bool isShowToast = true}) async {
    final result = await db.generalQueryDAO.querySameSyncTagWithRow();
    if (result.isEmpty) {
      if (isShowToast) {
        logger.outNormal(show: "上传全部数据成功！");
      }
      // 当全部上传成功后，每5秒监听一次是否有新的数据需要上传。
      await Future.delayed(Duration(seconds: 5));
      await uploadSingleGroupSync(isShowToast: false);
      return;
    }
    final requestResult = await request(
      path: HttpPath.LOGIN_REQUIRED_DATA_UPLOAD_ONCE_SYNCS,
      dtoData: DataUploadDto(
        sync_entity: Sync(
          row_id: "",
          sync_curd_type: SyncCurdType.u,
          sync_table_name: "",
          tag: 0,
          created_at: DateTime.now(),
          id: 0,
          updated_at: DateTime.now(),
        ),
        row_map: {},
      ),
      dtoDataList: result
          .map(
            (e) => DataUploadDto(
              sync_entity: e.t1,
              row_map: e.t2.toJson(),
            ),
          )
          .toList(),
      parseResponseVoData: DataUploadVo.fromJson,
    );
    await requestResult.handleCode(
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outError(show: httperException.showMessage, print: httperException.debugMessage, stackTrace: st);
      },
      code20101: (String showMessage) async {
        await db.deleteDAO.rowDeleteUploadedSync(syncs: result.map((e) => e.t1).toList());
        await uploadSingleGroupSync();
      },
    );
  }
}
