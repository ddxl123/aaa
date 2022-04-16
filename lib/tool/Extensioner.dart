import 'package:drift/drift.dart' as drift_helper;

/// 调用该类以快捷导入当前文件，以便快速使用当前文件的扩展函数。
///
/// 其他文件在未导入当前文件前，无法快速引用当前文件的扩展函数，
/// 在其他文件中调用这个类时，编辑器会自动导入当前文件（然后删除这个类而不删除其自动引入的包），
/// 这样就可以方便直接使用当前文件中的扩展函数了。
class Extensioner {}

/// drift_helper.Value('value') 的快捷方法。
///
/// 使用方法 '123'.toDriftValue()。
extension DriftValueExt on Object? {
  drift_helper.Value<T> toDriftValue<T>() {
    return drift_helper.Value<T>(this as T);
  }
}
