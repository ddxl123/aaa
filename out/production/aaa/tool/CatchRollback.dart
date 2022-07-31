// ignore_for_file: constant_identifier_names
import 'dart:async';

import 'package:catcher/core/catcher.dart';

class CatchRollback {
  /// 在 [_setCatcherParam] 函数中记录 tag 的 key。
  ///
  /// 在 [Catcher] 输出记录前，该 key 会被移除（重置），以便进行下一次 [Catcher] 记录。
  static const String TEMPORARY_NULL_TAGS = '临时回滚嵌套标签';

  /// 在 [_setCatcherParam] 函数中记录 tag 的 key。
  ///
  /// 在 [Catcher] 输出记录前，该 key 会被保留，可根据 tag 来辨别哪些嵌套已被回滚。
  static const String NULL_TAGS = '回滚嵌套标签';

  /// 如果 [body] 函数抛出了异常，则可以通过 [rollback] 函数进行回滚。
  ///
  /// 注意：异常仍然会向上层 rethrow。
  ///
  /// 如果捕获到了 [body] 函数的异常，则会先执行 [rollback] 函数后进行 rethrow，并传递给 [Catcher] 进行处理。
  /// 也就是说，就算 [body] 函数发生了异常，也会执行 [rollback] 函数。
  ///
  /// 返回值只接收 [body] 的返回值。
  /// 而 [rollback] 的返回值为当前的回滚标签，有几个嵌套回滚，[Catcher] 的 [NULL_TAGS] 参数就会得到几个标签。
  static FutureOr<T> call<T>({
    required FutureOr<T> Function() body,
    required FutureOr<String?> Function() rollback,
  }) async {
    try {
      return await body();
    } catch (e) {
      String? tag = await rollback();
      _setCatcherParam(tag);
      rethrow;
    }
  }

  /// 设置 [TEMPORARY_NULL_TAGS] 参数，以便设置 [NULL_TAGS] 参数。
  static void _setCatcherParam(String? tag) {
    final currentConfig = Catcher.getInstance().getCurrentConfig()!;
    if (currentConfig.customParameters[TEMPORARY_NULL_TAGS] is! List<String>) {
      currentConfig.customParameters[TEMPORARY_NULL_TAGS] = <String>[];
    }
    (currentConfig.customParameters[TEMPORARY_NULL_TAGS] as List<String>).add(tag.toString());
  }
}
