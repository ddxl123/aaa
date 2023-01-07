import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<void> showIsLogoutCurrentUserDialog() async {
  final user = await db.generalQueryDAO.queryUserOrNull();
  final clientSyncInfo = await db.generalQueryDAO.queryClientSyncInfoOrNull();
  if (user == null) {
    logger.out(show: "本地不存在用户！", print: "本地不存在用户，但却执行了退出登录！", level: LogLevel.error);
    return;
  }
  if (clientSyncInfo == null) {
    logger.out(show: "本地不存在登录信息！", print: "本地存在用户，但是并不是登录信息，却执行了退出登录！", level: LogLevel.error);
    return;
  }
  if (clientSyncInfo.token == null) {
    logger.out(show: "本地不存在登录用户！", print: "本地存在用户，但不存在 token，却执行了退出登录！", level: LogLevel.error);
    return;
  }
  await showCustomDialog(
    builder: (_) {
      return OkAndCancelDialogWidget(
        title: "确定退出当前用户？",
        text: "@${user.username}",
        okText: "退出",
        cancelText: "取消",
        onCancel: () {
          SmartDialog.dismiss();
        },
        onOk: () async {
          final dt = DeviceAndTokenBo(
            deviceInfo: clientSyncInfo.deviceInfo,
            token: clientSyncInfo.token!,
          );
          final result = await request(
            path: HttpPath.REGISTER_OR_LOGIN_LOGOUT,
            data: LogoutDto(
              be_active: true,
              current_device_and_token_bo: dt,
              device_and_token_bo: dt,
            ),
            parseResponseData: LogoutVo.fromJson,
          );
          await result.handleCode(
            otherException: (int? code, HttperException httperException, StackTrace st) async {
              logger.out(show: httperException.showMessage, print: httperException.debugMessage, stackTrace: st, level: LogLevel.error);
            },
            code10201: (String showMessage) async {
              throw ShouldNotExecuteHereHttperException();
            },
            code10202: (String showMessage) async {
              throw ShouldNotExecuteHereHttperException();
            },
            code10203: (String showMessage) async {
              throw ShouldNotExecuteHereHttperException();
            },
            code10204: (String showMessage) async {
              // 退出成功
              await db.registerOrLoginDAO.clientLogout();
              Aber.find<GlobalAbController>().loggedInUser.refreshEasy((oldValue) => null);
              logger.out(show: showMessage);
              SmartDialog.dismiss(status: SmartStatus.dialog);
              Navigator.pop(_);
            },
            code10205: (String showMessage) async {
              // 退出成功
              Aber.find<GlobalAbController>().loggedInUser.refreshEasy((oldValue) => null);
              logger.out(show: "退出成功！", print: "$showMessage\n但当前操作是【本地已登录，用户对其主动下线】的操作，因此给予权限。");
              SmartDialog.dismiss(status: SmartStatus.dialog);
              Navigator.pop(_);
            },
          );
        },
      );
    },
  );
}
