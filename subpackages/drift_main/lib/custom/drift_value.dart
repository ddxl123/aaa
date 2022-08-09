part of drift_db;

/// drift_helper.Value('value') 的快捷方法。
///
/// 使用方法 '123'.toDriftValue()。
extension DriftValueExt<T> on T {
  Value<T> toDriftValue() {
    return Value<T>(this);
  }
}
