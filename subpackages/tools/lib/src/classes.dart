import 'dart:async';

class Verify<VC> {
  final VC vc;
  String _failMessage = 'no failMessage';

  /// 会按照插入顺序进行验证。
  final Map<FutureOr<bool> Function(VC vc), String> isNotOk2FailMessage;

  Verify({required this.vc, required this.isNotOk2FailMessage});

  FutureOr<bool> get isNotOk async {
    for (var key in isNotOk2FailMessage.keys) {
      final isNotOk = await key(vc);
      if (isNotOk) {
        _failMessage = isNotOk2FailMessage[key].toString();
        return true;
      }
    }
    return false;
  }

  FutureOr<bool> get isOk async => !(await isNotOk);

  FutureOr<String> get failMessage async {
    if (await isOk) {
      return '不应该在验证成功时调用 failMessage';
    }
    return _failMessage;
  }
}

class VerifyMany {
  final List<Verify> verifyMany;
  String _failMessage = 'no failMessage';

  VerifyMany({required this.verifyMany});

  FutureOr<bool> get isVerifyAllOk async {
    for (var verify in verifyMany) {
      if (await verify.isNotOk) {
        _failMessage = await verify.failMessage;
        return false;
      }
    }
    return true;
  }

  /// 调用时，会同时调用 [isVerifyAllOk]。
  FutureOr<String> get failMessage async {
    if (await isVerifyAllOk) {
      _failMessage = '不应该在验证成功时调用 failMessage';
    }
    return _failMessage;
  }
}
