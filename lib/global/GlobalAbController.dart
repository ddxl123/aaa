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

class GlobalAbController extends AbController {
  final loggedInUser = Ab<User?>(null);
  final status = Status.normal.ab;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await checkIsLoggedIn();
    uploadSingleGroupSync();
  }

  /// 检查是否已登录，未登录则弹出登录框。
  ///
  /// 返回是否已登录，若返回 null，则检查失败。
  /// 若未登录，则会弹出登录框，如果在登录框中进行了登录或取消了登录，该函数同样返回对应是否登录。
  Future<bool?> checkIsLoggedIn() async {
    final userOrNull = await db.generalQueryDAO.queryUserOrNull();
    final clientSyncInfoOrNull = await db.generalQueryDAO.queryClientSyncInfoOrNull();
    if (userOrNull == null || clientSyncInfoOrNull == null) {
      await db.deleteDAO.clearDb();
      loggedInUser.refreshEasy((oldValue) => null);
    } else {
      if (clientSyncInfoOrNull.token == null) {
        loggedInUser.refreshEasy((oldValue) => null);
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
            dto_padding_2: null,
          ),
          parseResponseVoData: CheckLoginVo.fromJson,
        );
        final isLoggedIn = await result.handleCode<bool?>(
          otherException: (int? code, HttperException httperException, StackTrace st) async {
            logger.outError(show: httperException.showMessage, print: httperException.debugMessage, stackTrace: st);
            return null;
          },
          code10301: (String showMessage) async {
            return true;
          },
          code10302: (String showMessage) async {
            return false;
          },
        );
        if (isLoggedIn == null) return null;
        if (isLoggedIn) {
          loggedInUser.refreshEasy((oldValue) => userOrNull);
          return true;
        }
      }
    }

    // 检查到未登录后的操作
    if (loggedInUser.isAbEmpty()) {
      SmartDialog.showToast('请先登录哦~');
      await showAskLoginDialog();

      final resultUserOrNull = await db.generalQueryDAO.queryUserOrNull();
      final resultClientSyncInfoOrNull = await db.generalQueryDAO.queryClientSyncInfoOrNull();
      if (resultClientSyncInfoOrNull?.token != null) {
        loggedInUser.refreshEasy((oldValue) => resultUserOrNull!);
        return true;
      }
      return false;
    }

    logger.outError(show: "发生异常！", print: "检查结果为用户已登录，但 loggedInUser() 却为 null！");
    return null;
  }

  /// 上传 tag 最小的一组 sync 数据
  Future<void> uploadSingleGroupSync() async {
    final result = await db.generalQueryDAO.querySameSyncTagWithRow();
    if (result.isEmpty) {
      logger.outNormal(show: "上传全部数据成功！");
      // 当全部上传成功后，每5秒监听一次是否有新的数据需要上传。
      await Future.delayed(Duration(seconds: 5));
      await uploadSingleGroupSync();
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
        dto_padding_1: null,
        dto_padding_2: null,
      ),
      dtoDataList: result
          .map(
            (e) => DataUploadDto(
              sync_entity: e.t1,
              row_map: e.t2.toJson(),
              dto_padding_1: null,
              dto_padding_2: null,
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
