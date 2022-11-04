import 'package:tools/tools.dart';

class Storage<V> {
  final Ab<V> abObj;

  /// 存储未修改前的值，该值的用途是恢复未修改前的值。
  V tempValue;

  Storage({required this.abObj, required this.tempValue});
}
