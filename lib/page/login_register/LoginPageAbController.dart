import 'dart:async';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/page/login_register/LoginVerifyPage.dart';
import 'package:aaa/single_dialog/data_sync/showDataSyncDialog.dart';
import 'package:aaa/single_dialog/register_or_login/showExistOtherPlaceLoggedInDialog.dart';
import 'package:aaa/single_dialog/register_or_login/showLoginAgreeDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../single_dialog/register_or_login/showExistClientLoggedInHandleDialog.dart';

enum LoginType {
  phone,
  email,
}

abstract class BaseLoginWrapper {
  BaseLoginWrapper({required this.loginType});

  LoginType loginType;

  final textEditingController = TextEditingController();

  bool isPhone([Abw? abw]) {
    return loginType == LoginType.phone;
  }

  bool isEmail([Abw? abw]) {
    return loginType == LoginType.email;
  }

  String getEditContent();
}

class PhoneLoginWrapper extends BaseLoginWrapper {
  PhoneLoginWrapper() : super(loginType: LoginType.phone);
  final currentNumberPre = 86.ab;
  final phones = [
    86, // 中国大陆
    852, // 中国香港
    853, // 中国澳门
    886, // 中国台湾
  ];

  @override
  String getEditContent() => '+${currentNumberPre()}${textEditingController.text}';
}

class EmailLoginWrapper extends BaseLoginWrapper {
  EmailLoginWrapper() : super(loginType: LoginType.email);

  @override
  String getEditContent() => textEditingController.text;
}

class LoginPageAbController extends AbController {
  final loginWrapper = Ab<BaseLoginWrapper>(PhoneLoginWrapper());
  final isAgree = false.ab;
  final isSending = false.ab;
  final isVerifying = false.ab;
  final verifyCodeTextEditingController = TextEditingController();
  final verifyCountdown = 0.ab;

  /// 发送验证码。
  Future<void> send() async {
    if (isSending()) {
      return;
    }
    final lw = loginWrapper();
    if (lw is PhoneLoginWrapper) {
      if (!lw.getEditContent().isPhone()) {
        SmartDialog.showToast('手机号格式不正确！');
        return;
      }
    } else if (lw is EmailLoginWrapper) {
      if (!lw.getEditContent().isEmail()) {
        SmartDialog.showToast('邮箱格式不正确！');
        return;
      }
    } else {
      throw "未处理类型: ${lw.loginType}";
    }

    if (verifyCountdown() != 0) {
      SmartDialog.showToast('请 ${verifyCountdown()}s 后再发送！');
      return;
    }

    if (!isAgree()) {
      await showLoginAgreeDialog(isAgree: isAgree);
      if (!isAgree()) {
        return;
      }
    }

    final result = await reSend();
    if (result) {
      if (!state.mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginVerifyPage()));
    }
  }

  /// 重新发送验证码。
  ///
  /// 返回是否成功发送。
  Future<bool> reSend() async {
    if (isSending()) {
      return false;
    }
    isSending.refreshEasy((oldValue) => true);
    final isSuccess = await doSend();
    isSending.refreshEasy((oldValue) => false);
    return isSuccess;
  }

  /// 执行发送验证码。
  ///
  /// 返回是否发送成功。
  Future<bool> doSend() async {
    final lw = loginWrapper();
    if (lw is EmailLoginWrapper) {
      final result = await request(
        path: HttpPath.REGISTER_OR_LOGIN_SEND_OR_VERIFY,
        data: SendOrVerifyDto(
          register_or_login_type: RegisterOrLoginType.email_send,
          email: lw.getEditContent(),
          phone: null,
          verify_code: null,
          device_info: null,
        ),
        parseResponseData: (responseData) => SendOrVerifyVo.fromJson(responseData),
      );
      return await result.handleCode<bool>(
        otherException: (code, msg, st) async {
          logger.out(show: msg.showMessage, print: msg.debugMessage, stackTrace: st);
          return false;
        },
        code10101: (String message) async {
          verifyCountdown.refreshEasy((oldValue) => 5);
          Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
              verifyCountdown.refreshEasy((oldValue) => oldValue - 1);
              if (verifyCountdown() == 0) {
                timer.cancel();
              }
            },
          );
          SmartDialog.showToast('验证码已发送，请注意查收！');
          return true;
        },
        code10102: (String message) async {
          throw ShouldNotExecuteHereHttperException();
        },
        code10103: (String message, SendOrVerifyVo vo) async {
          throw ShouldNotExecuteHereHttperException();
        },
      );
    } else {
      throw "未处理类型: ${lw.loginType}";
    }
  }

  /// 对验证码进行验证。
  Future<void> verify() async {
    if (isVerifying()) {
      return;
    }
    isVerifying.refreshEasy((oldValue) => true);
    await doVerify();
    isVerifying.refreshEasy((oldValue) => false);
  }

  /// 执行验证。
  Future<void> doVerify() async {
    final lw = loginWrapper();
    if (lw is EmailLoginWrapper) {
      int? verifyCode = int.tryParse(verifyCodeTextEditingController.text);
      if (verifyCode == null) {
        logger.out(show: '验证码输入格式不正确！');
        return;
      }

      final deviceInfo = await DeviceInfoSingle.info();

      final result = await request(
        path: HttpPath.REGISTER_OR_LOGIN_SEND_OR_VERIFY,
        data: SendOrVerifyDto(
          register_or_login_type: RegisterOrLoginType.email_verify,
          email: lw.getEditContent(),
          phone: null,
          verify_code: verifyCode,
          device_info: deviceInfo,
        ),
        parseResponseData: SendOrVerifyVo.fromJson,
      );
      await result.handleCode(
        otherException: (int? code, HttperException httperException, StackTrace st) async {
          logger.out(show: httperException.showMessage, print: httperException.debugMessage, stackTrace: st, level: LogLevel.error);
        },
        code10101: (String showMessage) async {
          throw ShouldNotExecuteHereHttperException();
        },
        code10102: (String showMessage) async {
          logger.out(show: showMessage);
        },
        code10103: (String showMessage, SendOrVerifyVo vo) async {
          if (vo.be_new_user) {
            await doClientLogin(context: context, vo: vo);
          } else {
            if (vo.device_and_token_bo_list!.isNotEmpty) {
              logger.out(show: "用户已在其他地方登录！");
              final isContinue = await showExistOtherPlaceLoggedInDialog(vo: vo);
              if (!isContinue) {
                Navigator.pop(context);
                return;
              }
            }
            await doClientLogin(context: context, vo: vo);
          }
        },
      );
    } else {
      throw "未处理类型: ${lw.loginType}";
    }
  }

  /// 存储用户和token。
  ///
  /// 返回是否本地登录成功.
  Future<void> doClientLogin({required BuildContext context, required SendOrVerifyVo vo}) async {
    final isLoginSuccess = await db.registerOrLoginDAO.clientLogin(
      usersCompanion: vo.user_entity!.toCompanion(false),
      deviceInfo: vo.current_device_and_token_bo.deviceInfo,
      token: vo.current_device_and_token_bo.token,
      loginTypeName: loginWrapper().loginType.name,
      loginEditContent: loginWrapper().getEditContent(),
      isClearDbWhenUserDiff: () async {
        return await showExistClientLoggedInHandleDialog();
      },
    );
    // 未取消登录
    if (isLoginSuccess) {
      final user = await db.generalQueryDAO.queryUserOrNull();
      Aber.find<GlobalAbController>().loggedInUser.refreshEasy((oldValue) => user!);
      logger.out(show: vo.be_new_user ? "注册成功!" : "登录成功!");
      Navigator.pop(context);
      Navigator.pop(context);
      await showDataSyncDialog();
    }
    // 取消了登录。把注销当前登录会话。
    else {
      final result = await request(
        path: HttpPath.REGISTER_OR_LOGIN_LOGOUT,
        data: LogoutDto(
          be_active: false,
          current_device_and_token_bo: vo.current_device_and_token_bo,
          device_and_token_bo: vo.current_device_and_token_bo,
        ),
        parseResponseData: LogoutVo.fromJson,
      );
      await result.handleCode(
        otherException: (int? code, HttperException httperException, StackTrace st) async {
          logger.out(show: httperException.showMessage, print: httperException.debugMessage, stackTrace: st, level: LogLevel.error);
          Navigator.pop(context);
        },
        code10201: (String showMessage) async {
          throw ShouldNotExecuteHereHttperException();
        },
        code10202: (String showMessage) async {
          throw ShouldNotExecuteHereHttperException();
        },
        code10203: (String showMessage) async {
          logger.out(show: showMessage);
          Navigator.pop(context);
        },
        code10204: (String showMessage) async {
          throw ShouldNotExecuteHereHttperException();
        },
        code10205: (String showMessage) async {
          logger.out(show: "已取消本次登录！", print: "$showMessage\n但当前操作是【本地登录失败】操作，因此给予权限。");
          Navigator.pop(context);
        },
      );
    }
  }
}
