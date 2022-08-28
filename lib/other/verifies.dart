import 'dart:async';

import 'package:tools/tools.dart';

/// 本文档的用途：验证与解析 。

FutureOr<Verify> vMemoryModelButtonDataVerifyKey({required String verifyValue}) {
  String failValue() => ''
      '按钮数值分配不符合规范！\n'
      '正确示例：\n'
      '- 不可滑动：1,2,3\n'
      '- 可滑动：0 1,2,3 5\n'
      '- 可以为小数，不可存在多余空格，逗号必须为小写字符","而不是"，"';

  Verify isTryParseCenterFail(String s) {
    final sfs = s.split(',');
    for (var value in sfs) {
      if (double.tryParse(value) == null) return Verify(isOk: false, message: failValue());
    }
    return Verify(isOk: true, message: null);
  }

  final s = verifyValue.split(' ');
  if (s.length == 1) {
    return isTryParseCenterFail(s.first);
  } else if (s.length == 3) {
    if (double.tryParse(s.first) == null) return Verify(isOk: false, message: failValue());
    if (double.tryParse(s.last) == null) return Verify(isOk: false, message: failValue());
    return isTryParseCenterFail(s.first);
  }
  return Verify(isOk: true, message: null);
}
