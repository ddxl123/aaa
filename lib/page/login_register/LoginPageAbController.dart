import 'dart:async';

import 'package:aaa/page/login_register/LoginVerifyPage.dart';
import 'package:aaa/single_dialog/showLoginAgreeDialog.dart';
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

  /// 返回是否发送成功。
  Future<bool> reSend() async {
    if (isSending()) {
      return false;
    }
    isSending.refreshEasy((oldValue) => true);
    if (loginType() == LoginType.email) {
      final result = await request(
        path: HttpPath.REGISTER_OR_LOGIN_SEND_OR_VERIFY,
        data: RegisterOrLoginDto(
          register_or_login_type: RegisterOrLoginType.email_send,
          email: getEmail(),
          phone: null,
          verify_code: null,
        ),
        parseResponseData: (responseData) => RegisterOrLoginVo.fromJson(responseData),
      );
      return await result.handleCode<bool>(
        otherException: (code, msg, st) async {
          logger.e(msg.showMessage, msg.debugMessage, st);
          isSending.refreshEasy((oldValue) => false);
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
          isSending.refreshEasy((oldValue) => false);
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
      logger.e('未处理 ${loginType()}');
      isSending.refreshEasy((oldValue) => false);
      return false;
    }
  }

  Future<void> verify() async {
    if (isVerifying()) {
      return;
    }
    if (loginType() == LoginType.email) {
      int? verifyCode = int.tryParse(verifyCodeTextEditingController.text);
      if (verifyCode == null) {
        logger.d('验证码输入格式不正确！');
        return;
      }
      final result = await request(
        path: HttpPath.REGISTER_OR_LOGIN_SEND_OR_VERIFY,
        data: RegisterOrLoginDto(
          register_or_login_type: RegisterOrLoginType.email_verify,
          email: getEmail(),
          phone: null,
          verify_code: verifyCode,
        ),
        parseResponseData: (responseData) => RegisterOrLoginVo.fromJson(responseData),
      );
      await result.handleCode(
        otherException: (int? code, HttperMessage httperException, StackTrace st) async {
          logger.e(httperException.showMessage, httperException.debugMessage, st);
        },
        code100: (String showMessage) async {
          throw HttperMessage(showMessage: '请求异常！', debugMessage: '不应该执行这里！');
        },
        code101: (String showMessage) async {
          logger.i(showMessage);
        },
        code102: (String showMessage, RegisterOrLoginVo vo) async {
          if (vo.be_registered) {
            logger.i('注册并登录成功！');
          } else {
            logger.i('登录成功！');
          }
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    } else {
      logger.e("未处理 ${loginType()}");
    }
  }
}
