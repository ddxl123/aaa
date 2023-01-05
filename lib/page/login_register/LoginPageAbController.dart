import 'dart:async';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/page/login_register/LoginVerifyPage.dart';
import 'package:aaa/single_dialog/showDownloadInitDataDialog.dart';
import 'package:aaa/single_dialog/showExistOtherPlaceLoggedInDialog.dart';
import 'package:aaa/single_dialog/showExistUserHandleDialog.dart';
import 'package:aaa/single_dialog/showLoginAgreeDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

enum LoginType {
  phone,
  email,
}

class LoginPageAbController extends AbController {
  final loginType = LoginType.phone.ab;
  final isAgree = false.ab;
  final isSending = false.ab;
  final isVerifying = false.ab;
  final phoneTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final verifyCodeTextEditingController = TextEditingController();
  final verifyCountdown = 0.ab;
  final currentNumberPre = 86.ab;

  final phones = [
    86, // 中国大陆
    852, // 中国香港
    853, // 中国澳门
    886, // 中国台湾
  ];

  String getPhone() => '+${currentNumberPre()}${phoneTextEditingController.text}';

  String getEmail() => emailTextEditingController.text;

  /// 发送验证码。
  Future<void> send() async {
    if (isSending()) {
      return;
    }

    if (loginType() == LoginType.phone) {
      if (!getPhone().isPhone()) {
        SmartDialog.showToast('手机号格式不正确！');
        return;
      }
    } else {
      if (!getEmail().isEmail()) {
        SmartDialog.showToast('邮箱格式不正确！');
        return;
      }
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
    final isContinue = await checkCurrentLogin();
    if (!isContinue) return false;
    isSending.refreshEasy((oldValue) => true);
    final isSuccess = await doSend();
    isSending.refreshEasy((oldValue) => false);
    return isSuccess;
  }

  /// 执行发送验证码。
  ///
  /// 返回是否发送成功。
  Future<bool> doSend() async {
    if (loginType() == LoginType.email) {
      final result = await request(
        path: HttpPath.REGISTER_OR_LOGIN_SEND_OR_VERIFY,
        data: RegisterOrLoginDto(
          register_or_login_type: RegisterOrLoginType.email_send,
          email: getEmail(),
          phone: null,
          verify_code: null,
          // TODO:
          device: '',
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
      logger.out(show: "存在未处理类型！", print: loginType());
      return false;
    }
  }

  /// 检查本地是否已存在登录用户，并弹出操作模块。
  ///
  /// 返回当前是否继续执行发送验证码任务。
  Future<bool> checkCurrentLogin() async {
    final result = await db.generalQueryDAO.queryUserOrNull();
    if (result == null || getEmail() == result.email || getPhone() == result.phone) {
      return true;
    }
    return await showExistUserHandleDialog();
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
    if (loginType() == LoginType.email) {
      int? verifyCode = int.tryParse(verifyCodeTextEditingController.text);
      if (verifyCode == null) {
        logger.out(show: '验证码输入格式不正确！');
        return;
      }
      final result = await request(
        path: HttpPath.REGISTER_OR_LOGIN_SEND_OR_VERIFY,
        data: RegisterOrLoginDto(
          register_or_login_type: RegisterOrLoginType.email_verify,
          email: getEmail(),
          phone: null,
          verify_code: verifyCode,
          // TODO:
          device: '',
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
            logger.out(show: "注册成功！");
            await doLogin(context: context, vo: vo);
          } else {
            // TODO:
            // if (vo.be_logged_in!) {
            //   logger.out(show: "用户已在其他地方登录！");
            //   final isContinue = await showExistOtherPlaceLoggedInDialog();
            //   if (!isContinue) {
            //     Navigator.pop(context);
            //     return;
            //   }
            // }
            logger.out(show: "登录成功！");
            await doLogin(context: context, vo: vo);
          }
        },
      );
    } else {
      logger.out(show: "未处理登录类型", print: loginType());
    }
  }
}

/// 存储用户和token。
Future<void> doLogin({required BuildContext context, required RegisterOrLoginVo vo}) async {
  final user = await db.rawInsertDAO.rawInsertUser(newUser: vo.user_entity!.toCompanion(false));
  Aber.find<GlobalAbController>().loggedInUser.refreshEasy((oldValue) => user);
  Navigator.pop(context);
  Navigator.pop(context);
  await showDownloadInitDataDialog();
}
