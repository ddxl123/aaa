class Verify<VC> {
  final VC vc;
  final String failMessage;

  final bool Function(VC vc) initIsOk;

  Verify({required this.vc, required this.initIsOk, required this.failMessage});

  bool get isOk => initIsOk(vc);

  bool get isNotOk => !isOk;
}

class VerifyMany {
  final List<Verify> verifyMany;
  String _failMessage = 'no failMessage';

  VerifyMany({required this.verifyMany});

  bool get isVerifyAllOk {
    for (var verify in verifyMany) {
      if (verify.isNotOk) {
        _failMessage = verify.failMessage;
        return false;
      }
    }
    return true;
  }

  /// 调用时，会同时调用 [isVerifyAllOk]。
  String get failMessage {
    final isAllOk = isVerifyAllOk;
    if (isAllOk) {
      _failMessage = '不应该在验证成功时调用 failMessage';
    }
    return _failMessage;
  }
}
