part of drift_db;

extension DriftValueExt<T> on T {
  /// drift.Value('value') 的快捷方法。
  ///
  /// 使用方法： '123'.value()。
  Value<T> value() {
    return Value<T>(this);
  }

  /// drift.Value.absent() 的快捷方法。
  ///
  /// 使用方法：直接在任意对象中调用 absent()。
  Value<A> absent<A>() {
    return Value<A>.absent();
  }
}
