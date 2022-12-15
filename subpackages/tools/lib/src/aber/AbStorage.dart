part of aber;

class AbStorage<V> {
  final Ab<V> abValue;

  /// 存储未修改前的值，该值的用途是恢复未修改前的值。
  V tempValue;

  /// 验证失败存储的消息，若为空则表示成功，或者未进行验证。
  final verifyErrorMessage = Ab<String?>(null);

  late final Future<String?> Function(V v) _runVerify;

  AbStorage({
    required this.abValue,
    required this.tempValue,
  });

  void recovery() {
    abValue.refreshEasy((oldValue) => tempValue);
    verifyErrorMessage();
  }

  void initVerify({required Future<String?> Function(V v) verifyCallback}) {
    _runVerify = verifyCallback;
  }

  /// 验证成功返回 true，否则返回 false。
  Future<bool> verify() async {
    try {
      final errMessage = await _runVerify(abValue());
      verifyErrorMessage.refreshEasy((oldValue) => errMessage);
      return errMessage == null ? true : false;
    } catch (s) {
      verifyErrorMessage.refreshEasy((oldValue) => s.toString());
      return false;
    }
  }

  void removeError() {
    verifyErrorMessage.refreshEasy((oldValue) => null);
  }
}
