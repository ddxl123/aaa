import 'dart:async';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/page/login_register/LoginVerifyPage.dart';
import 'package:aaa/single_dialog/data_sync/showDataSyncDialog.dart';
import 'package:aaa/single_dialog/register_or_login/showExistOtherPlaceLoggedInDialog.dart';
import 'package:aaa/single_dialog/register_or_login/showExistUserHandleDialog.dart';
import 'package:aaa/single_dialog/register_or_login/showLoginAgreeDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

enum LoginType {
  phone,
  email,
}

abstract class BaseLoginWrapper {
  BaseLoginWrapper({required this.loginType});

  LoginType loginType;

  bool get isPhone => loginType == LoginType.phone;

  bool get isEmail => loginType == LoginType.email;

  String getEditContent();
}

class PhoneLoginWrapper extends BaseLoginWrapper {
  PhoneLoginWrapper() : super(loginType: LoginType.phone);
  final phoneTextEditingController = TextEditingController();
  final currentNumberPre = 86.ab;
  final phones = [
    86, // 中国大陆
    852, // 中国香港
    853, // 中国澳门
    886, // 中国台湾
  ];

  @override
  String getEditContent() => '+${currentNumberPre()}${phoneTextEditingController.text}';
}

class EmailLoginWrapper extends BaseLoginWrapper {
  EmailLoginWrapper() : super(loginType: LoginType.email);
  final emailTextEditingController = TextEditingController();

  @override
  String getEditContent() => emailTextEditingController.text;
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
        data: RegisterOrLoginDto(
          register_or_login_type: RegisterOrLoginType.email_send,
          email: lw.getEditContent(),
          phone: null,
          verify_code: null,
          device_info: null,
        ),
        parseResponseData: (responseData) => RegisterOrLoginVo.fromJson(responseData),
      );
      return await result.handleCode<bool>(
        otherException: (code, msg, st) async {
          logger.out(show: msg.showMessage, print: msg.debugMessage, stackTrace: st);
          return false;
        },
        code100: (String message) async {
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
        code101: (String message) async {
          throw HttperMessage(showMessage: '请求异常！', debugMessage: '不应该执行这里！');
        },
        code102: (String message, RegisterOrLoginVo vo) async {
          throw HttperMessage(showMessage: '请求异常！', debugMessage: '不应该执行这里！');
        },
      );
    } else {
      throw "未处理类型: ${lw.loginType}";
    }
  }

  /// 检查本地是否已存在用一个，并弹出操作模块。
  ///
  /// 返回是否存在，
  Future<bool> checkCurrentLoggedIn() async {
    final userOrNull = await db.generalQueryDAO.queryUserOrNull();
    final clientSyncInfoOrNull = await db.generalQueryDAO.queryClientSyncInfoOrNull();
    if (clientSyncInfoOrNull != null) {
      throw "不应该执行登录,但是执行了登录!";
    }
    if (userOrNull == null) {
      return false;
    }
    final lw = loginWrapper();
    if (lw is EmailLoginWrapper) {
      if (lw.getEditContent() == userOrNull.email) return true;
    } else if (lw is PhoneLoginWrapper) {
      if (lw.getEditContent() == userOrNull.phone) return true;
    } else {
      throw "存在 user,但 loginType 未知";
    }
    return false;
    // TODO:
    // return await showExistUserHandleDialog();
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
        data: RegisterOrLoginDto(
          register_or_login_type: RegisterOrLoginType.email_verify,
          email: lw.getEditContent(),
          phone: null,
          verify_code: verifyCode,
          device_info: deviceInfo,
        ),
        parseResponseData: RegisterOrLoginVo.fromJson,
      );
      await result.handleCode(
        otherException: (int? code, HttperMessage httperException, StackTrace st) async {
          logger.out(show: httperException.showMessage, print: httperException.debugMessage, stackTrace: st, level: LogLevel.error);
        },
        code100: (String showMessage) async {
          throw HttperMessage(showMessage: '请求异常！', debugMessage: '不应该执行这里！');
        },
        code101: (String showMessage) async {
          logger.out(show: showMessage);
        },
        code102: (String showMessage, RegisterOrLoginVo vo) async {
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
  Future<void> doClientLogin({required BuildContext context, required RegisterOrLoginVo vo}) async {
    final isLoginSuccess = await db.rawDAO.clientLogin(
      usersCompanion: vo.user_entity!.toCompanion(false),
      deviceInfo: vo.device_and_token_bo.deviceInfo,
      token: vo.device_and_token_bo.token,
      loginTypeName: loginWrapper().loginType.name,
      loginEditContent: loginWrapper().getEditContent(),
      isClearDbWhenUserDiff: () async {
        return await showExistClientLoggedInHandleDialog();
      },
    );
    if (isLoginSuccess) {
      final user = await db.generalQueryDAO.queryUserOrNull();
      Aber.find<GlobalAbController>().loggedInUser.refreshEasy((oldValue) => user!);
      SmartDialog.showToast(vo.be_new_user ? "注册成功!" : "登录成功!");
      Navigator.pop(context);
      Navigator.pop(context);
      await showDataSyncDialog();
    } else {
      SmartDialog.showToast("已取消!");
      Navigator.pop(context);
    }
  }
}
