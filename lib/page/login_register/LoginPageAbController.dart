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

    await reSend();

    if (!state.mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginVerifyPage()));
  }

  Future<void> reSend() async {
    if (isSending()) {
      return;
    }
    isSending.refreshEasy((oldValue) => true);
    if (loginType() == LoginType.email) {
      final result = await request(
        path: HttpPath.REGISTER_OR_LOGIN_SEND_OR_VERIFY,
        data: RegisterAndLoginDto(
          register_and_login_type: RegisterAndLoginType.email_send,
          email: getEmail(),
          phone: null,
          verify_code: null,
        ),
        parseResponseData: (responseData) => RegisterAndLoginDto.fromJson(responseData),
      );
      await result.handleCode(
        otherException: (code, msg, st) async {
          logger.d("异常 $code", msg, st);
        },
        code100: (String message) async {
          SmartDialog.showToast(message);
        },
        code101: (String message) async {
          SmartDialog.showToast(message);
        },
        code102: (String message, RegisterAndLoginVo vo) async {
          SmartDialog.showToast(message);
        },
      );
    } else {
      logger.d("未处理 ${loginType()}");
    }
    isSending.refreshEasy((oldValue) => false);

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
  }
}
