import 'dart:async';

import 'package:tools/tools.dart';

/// 本文档的用途：验证与解析 。

@Deprecated('可能不需要')
class VMemoryModelButtonDataVerifyResult {
  double? first;
  double? last;
  final List<double> center;

  VMemoryModelButtonDataVerifyResult({required this.first, required this.last, required this.center});
}

@Deprecated('可能不需要')
FutureOr<Tuple2<VerifyResult, VMemoryModelButtonDataVerifyResult?>> vMemoryModelButtonDataVerifyKey({required String verifyValue}) {
  String failValue() => ''
      '按钮数值分配不符合规范！\n'
      '正确示例：\n'
      '- 不可滑动：1,2,3 (按钮将分配3个，每个数值分别为1,2,3)\n'
      '- 可滑动：0 1,2,3 5 (中间部分同上，0与5为按钮可滑动范围即0~5)\n'
      '- 可以为小数，不可存在多余空格，逗号必须为小写字符","而不是"，"';

  Tuple2<VerifyResult, VMemoryModelButtonDataVerifyResult?> isTryParseCenterFail(String s) {
    final sfs = s.split(',');
    final sfsList = <double>[];
    for (var value in sfs) {
      final d = double.tryParse(value);
      if (d == null) return Tuple2(t1: VerifyResult(isOk: false, message: failValue()), t2: null);
      sfsList.add(d);
    }
    return Tuple2(t1: VerifyResult(isOk: true, message: null), t2: VMemoryModelButtonDataVerifyResult(first: null, last: null, center: sfsList));
  }

  final s = verifyValue.split(' ');
  if (s.length == 1) {
    return isTryParseCenterFail(s.first);
  } else if (s.length == 3) {
    final f = double.tryParse(s.first);
    final l = double.tryParse(s.last);
    if (f == null) return Tuple2(t1: VerifyResult(isOk: false, message: failValue()), t2: null);
    if (l == null) return Tuple2(t1: VerifyResult(isOk: false, message: failValue()), t2: null);
    final c = isTryParseCenterFail(s[1]);
    if (!c.t1.isOk) return c;
    return c
      ..t2!.first = f
      ..t2!.last = l;
  }
  return Tuple2(t1: VerifyResult(isOk: false, message: failValue()), t2: null);
}
