import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 展示是否退出当前本地已登录用户，同时当前用户在服务端下线。
Future<void> showIsLogoutCurrentUserDialog() async {
  final user = await driftDb.generalQueryDAO.queryUserOrNull();
  final clientSyncInfo = await driftDb.generalQueryDAO.queryClientSyncInfoOrNull();
  if (user == null) {
    logger.outError(show: "本地不存在用户！", print: "本地不存在用户，但却执行了退出登录！");
    return;
  }
  if (clientSyncInfo == null) {
    logger.outError(show: "本地不存在登录信息！", print: "本地存在用户，但是并不是登录信息，却执行了退出登录！");
    return;
  }
  if (clientSyncInfo.token == null) {
    logger.outError(show: "本地不存在登录用户！", print: "本地存在用户，但不存在 token，却执行了退出登录！");
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
            device_info: clientSyncInfo.device_info,
            token: clientSyncInfo.token!,
          );
          final result = await request(
            path: HttpPath.POST__REGISTER_OR_LOGIN_LOGOUT,
            dtoData: LogoutDto(
              be_active: true,
              current_device_and_token_bo: dt,
              device_and_token_bo: dt,
            ),
            parseResponseVoData: LogoutVo.fromJson,
          );
          await result.handleCode(
            otherException: (int? code, HttperException httperException, StackTrace st) async {
              logger.outError(show: httperException.showMessage, print: httperException.debugMessage, stackTrace: st);
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
              await driftDb.registerOrLoginDAO.clientLogout();
              Aber.find<GlobalAbController>().loggedInUser.refreshEasy((oldValue) => null);
              logger.outNormal(show: showMessage);
              SmartDialog.dismiss(status: SmartStatus.dialog);
              Navigator.pop(_);
            },
            code10205: (String showMessage) async {
              // 退出成功
              await driftDb.registerOrLoginDAO.clientLogout();
              Aber.find<GlobalAbController>().loggedInUser.refreshEasy((oldValue) => null);
              logger.outNormal(show: "退出成功！", print: "$showMessage\n但当前操作是【本地已登录，用户对其主动下线】的操作，因此给予权限。");
              SmartDialog.dismiss(status: SmartStatus.dialog);
              Navigator.pop(_);
            },
          );
        },
      );
    },
  );
}
