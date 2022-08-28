import 'dart:async';

import 'package:tools/tools.dart';

class Verify {
  final bool isOk;
  final String? message;

  Verify({required this.isOk, required this.message});
}

class AbVerify<V> {
  final Ab<V> abV;
  Verify _verify = Verify(isOk: false, message: '未 check 就进行了调用！');

  /// 返回值为 null 将会自动设置一个成功的 [Verify]。
  final FutureOr<Verify?> Function(Ab<V> abV) verifyCallBack;

  final Set<void Function()> checkCallBacks = {};

  AbVerify({required this.abV, required this.verifyCallBack});

  bool get isOk => _verify.isOk;

  String get message => _verify.message ?? '成功时调用了message！';

  Future<void> check() async {
    _verify = await verifyCallBack(abV) ?? Verify(isOk: true, message: null);
    for (var checkCallBack in checkCallBacks) {
      checkCallBack();
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
