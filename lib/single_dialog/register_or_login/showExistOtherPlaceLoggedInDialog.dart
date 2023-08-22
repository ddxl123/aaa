import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 存在其他地方已登录。
///
/// 返回当前是否继续执行登录操作。
Future<bool> showExistOtherPlaceLoggedInDialog({
  required SendOrVerifyVo vo,
}) async {
  bool isContinue = false;
  await showCustomDialog(
    backDismiss: false,
    clickMaskDismiss: false,
    builder: (_) => StatefulBuilder(
      builder: (_, reBuild) {
        return DialogWidget(
          title: "该用户已存在登录！",
          mainVerticalWidgets: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(color: Colors.amber), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("将登录用户：${vo.user_entity!.username}")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: Text("是否为会员用户：是")),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            ...vo.device_and_token_bo_list!.map(
              (e) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(DeviceInfoSingle.getDevice(deviceInfo: e.device_info))),
                        TextButton(
                          child: const Text("下线", style: TextStyle(color: Colors.red)),
                          onPressed: () async {
                            final result = await request(
                              path: HttpPath.POST__REGISTER_OR_LOGIN_LOGOUT,
                              dtoData: LogoutDto(
                                be_active: false,
                                current_device_and_token_bo: vo.current_device_and_token_bo,
                                device_and_token_bo: e,
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
                                // 下线成功
                                vo.device_and_token_bo_list?.remove(e);
                                logger.outNormal(show: showMessage);
                                reBuild(() {});
                              },
                              code10203: (String showMessage) async {
                                throw ShouldNotExecuteHereHttperException();
                              },
                              code10204: (String showMessage) async {
                                throw ShouldNotExecuteHereHttperException();
                              },
                              code10205: (String showMessage) async {
                                // 下线失败
                                logger.outNormal(show: showMessage, print: showMessage);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ],
          bottomKeepWidget: Row(
            children: [
              TextButton(
                style: const ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: Colors.pinkAccent))),
                child: const Text("继续登录(会员)", style: TextStyle(color: Colors.pinkAccent)),
                onPressed: () {
                  isContinue = true;
                  SmartDialog.dismiss(status: SmartStatus.dialog);
                },
              ),
              const SizedBox(width: 10),
              TextButton(
                style: const ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: Colors.grey))),
                child: const Text("下线全部并登录", style: TextStyle(color: Colors.red)),
                onPressed: () async {
                  final result = await request(
                    path: HttpPath.POST__REGISTER_OR_LOGIN_LOGOUT,
                    dtoData: LogoutDto(
                      be_active: false,
                      current_device_and_token_bo: vo.current_device_and_token_bo,
                      device_and_token_bo: null,
                    ),
                    parseResponseVoData: LogoutVo.fromJson,
                  );
                  await result.handleCode(
                    otherException: (int? code, HttperException httperException, StackTrace st) async {
                      logger.outError(show: httperException.showMessage, print: httperException.debugMessage, stackTrace: st);
                    },
                    code10201: (String showMessage) async {
                      logger.outNormal(show: "$showMessage\n本次登录成功！");
                      isContinue = true;
                      SmartDialog.dismiss(status: SmartStatus.dialog);
                    },
                    code10202: (String showMessage) async {
                      throw ShouldNotExecuteHereHttperException();
                    },
                    code10203: (String showMessage) async {
                      throw ShouldNotExecuteHereHttperException();
                    },
                    code10204: (String showMessage) async {
                      throw ShouldNotExecuteHereHttperException();
                    },
                    code10205: (String showMessage) async {
                      // 下线失败
                      logger.outNormal(show: showMessage, print: showMessage);
                    },
                  );
                },
              ),
            ],
          ),
          bottomHorizontalButtonWidgets: [
            TextButton(
              child: const Text("取消本次登录", style: TextStyle(color: Colors.grey)),
              onPressed: () async {
                final result = await request(
                  path: HttpPath.POST__REGISTER_OR_LOGIN_LOGOUT,
                  dtoData: LogoutDto(
                    be_active: false,
                    current_device_and_token_bo: vo.current_device_and_token_bo,
                    device_and_token_bo: vo.current_device_and_token_bo,
                  ),
                  parseResponseVoData: LogoutVo.fromJson,
                );
                await result.handleCode(
                  otherException: (int? code, HttperException httperException, StackTrace st) async {
                    isContinue = false;
                    SmartDialog.dismiss(status: SmartStatus.dialog);
                    logger.outError(show: httperException.showMessage, print: httperException.debugMessage, stackTrace: st);
                  },
                  code10201: (String showMessage) async {
                    throw ShouldNotExecuteHereHttperException();
                  },
                  code10202: (String showMessage) async {
                    throw ShouldNotExecuteHereHttperException();
                  },
                  code10203: (String showMessage) async {
                    isContinue = false;
                    logger.outNormal(show: showMessage);
                    SmartDialog.dismiss(status: SmartStatus.dialog);
                  },
                  code10204: (String showMessage) async {
                    throw ShouldNotExecuteHereHttperException();
                  },
                  code10205: (String showMessage) async {
                    logger.outNormal(show: "已取消本次登录！", print: "$showMessage\n但当前操作是【取消本次登录】操作，因此给予权限。");
                  },
                );
              },
            ),
          ],
        );
      },
    ),
  );
  return isContinue;
}
