import 'dart:async';

import 'package:tools/tools.dart';

class VerifyResult {
  final bool isOk;
  final String? message;

  VerifyResult({required this.isOk, required this.message});
}

class AbVerify<V> {
  final Ab<V> abV;
  VerifyResult _verify = VerifyResult(isOk: false, message: '未 check 就进行了调用！');

  /// 返回值为 null 将会自动设置一个成功的 [VerifyResult]。
  final FutureOr<VerifyResult?> Function(Ab<V> abV) verifyCallBack;

  final Set<void Function()> checkCallBacks = {};

  AbVerify({required this.abV, required this.verifyCallBack});

  bool get isOk => _verify.isOk;

  String get message => _verify.message ?? '成功时调用了message！';

  Future<void> check() async {
    try {
      _verify = await verifyCallBack(abV) ?? VerifyResult(isOk: true, message: null);
      for (var checkCallBack in checkCallBacks) {
        checkCallBack();
      }
    } catch (e, st) {
      _verify = VerifyResult(isOk: false, message: 'check 内部异常：$e');
    }
  }

  static Future<bool> checkMany(List<AbVerify> verifies) async {
    bool? isAllOk;
    // 就算存在一个不ok的也要全部check一遍。
    for (var v in verifies) {
      await v.check();
      if (!v.isOk) {
        isAllOk = false;
      }
    }
    return isAllOk ?? true;
  }
}
