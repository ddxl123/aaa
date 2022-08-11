extension TccExt on String {
  /// 把 UserInfos 转成 userInfos。
  String get toCamelCase => this[0].toLowerCase() + substring(1, length);
}
