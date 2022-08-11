import 'package:flutter/foundation.dart';
import 'package:tools/tools.dart';

extension AnyExt2<T> on T {
  void withPrint(String Function(T t) current) {
    if (kDebugMode) {
      Helper.logger.i(current(this));
    }
  }
}
