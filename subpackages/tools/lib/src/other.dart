import 'dart:async';

import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

String get uuidV4 => _uuid.v4();

Logger logger = Logger(printer: PrettyPrinter(methodCount: 1));

class Tuple2<T1, T2> {
  final T1 t1;
  final T2 t2;

  Tuple2({required this.t1, required this.t2});
}

/// ===
/// TODO: 在函数未调用玩前，函数不能再被调用，除非函数调用完成。
/// 创建一个全局 map
/// ===

/// 如果 [body] 函数抛出了异常，则可以通过 [rollback] 函数进行回滚。
///
/// 注意：异常仍然会向上层 rethrow。
///
/// 如果捕获到了 [body] 函数的异常，则会先执行 [rollback] 函数后进行 rethrow，并传递给 [Catcher] 进行处理。
/// 也就是说，就算 [body] 函数发生了异常，也会执行 [rollback] 函数。
///
/// 返回值只接收 [body] 的返回值。
FutureOr<T> catchRollback<T>({
  required FutureOr<T> Function() body,
  required FutureOr<String?> Function() rollback,
}) async {
  try {
    return await body();
  } catch (e) {
    String? tag = await rollback();
    rethrow;
  }
}

extension TccExt on String {
  /// 把 UserInfos 转成 userInfos。
  String get toCamelCase => this[0].toLowerCase() + substring(1, length);
}
