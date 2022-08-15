import 'dart:async';

class Verify<VC> {
  final VC vc;
  final String failMessage;

  final FutureOr<bool> Function(VC vc) initIsOk;

  Verify({required this.vc, required this.initIsOk, required this.failMessage});

  FutureOr<bool> get isOk async => await initIsOk(vc);

  FutureOr<bool> get isNotOk async => !(await isOk);
}

class VerifyMany {
  final List<Verify> verifyMany;
  String _failMessage = 'no failMessage';

  VerifyMany({required this.verifyMany});

  FutureOr<bool> get isVerifyAllOk async {
    for (var verify in verifyMany) {
      if (await verify.isNotOk) {
        _failMessage = verify.failMessage;
        return false;
      }
    }
    return true;
  }

  /// 调用时，会同时调用 [isVerifyAllOk]。
  FutureOr<String> get failMessage async {
    final isAllOk = await isVerifyAllOk;
    if (isAllOk) {
      _failMessage = '不应该在验证成功时调用 failMessage';
    }
    return _failMessage;
  }
}
