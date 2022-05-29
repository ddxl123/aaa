import 'package:aaa/tool/aber/Aber.dart';

/// 调用该类以快捷导入当前文件，以便快速使用当前文件的扩展函数。
///
/// 其他文件在未导入当前文件前，无法快速引用当前文件的扩展函数，
/// 在其他文件中调用这个类时，编辑器会自动导入当前文件（然后删除这个类而不删除其自动引入的包），
/// 这样就可以方便直接使
///
/// 用当前文件中的扩展函数了。
class Extensioner {}

extension ListExt on List {
  /// 自动将 [index] 角标上元素的类型转换成 [A] 或 [B]。
  R match<R, A, B>(int index, R Function(A a) aCall, R Function(B b) bCall) {
    dynamic element = this[index];
    if (element is A) {
      return aCall(element);
    }
    if (element is B) {
      return bCall(element);
    }
    throw 'Type mismatch: Need-${element.runtimeType}, A-${A.toString()}, B-${B.toString()}';
  }
}

extension AnyExt on Object? {
  /// 自动将当前对象的类型转换成 [A] 或 [B]。
  R match<R, A, B>(R Function(A a) aCall, R Function(B b) bCall) {
    final obj = this;
    if (obj is A) {
      return aCall(obj);
    }
    if (obj is B) {
      return bCall(obj);
    }
    throw 'Type mismatch: Need-${obj.runtimeType}, A-${A.toString()}, B-${B.toString()}';
  }
}
