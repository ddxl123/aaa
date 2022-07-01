import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class Helper {
  static const Uuid _uuid = Uuid();

  static String get uuidV4 => _uuid.v4();

  static Logger logger = Logger(printer: SimplePrinter());

  /// [e] - 输入要筛选的值。
  static R? filterOrNull<E, R>({required E from, required Map<List<E>, R?> targets, required Object? Function()? orElse}) {
    bool isEver = false;
    for (var key in targets.keys) {
      if (key.contains(from)) {
        if (isEver) throw '不能在不同的key中多次使用相同的值！';
        isEver = true;
        return targets[key];
      }
    }
    return orElse?.call() as R?;
  }

  static R filter<E, R>({
    required E from,
    required Map<List<E>, R> targets,
    required Object? Function() orElse,
  }) =>
      filterOrNull(from: from, targets: targets, orElse: orElse)!;
}
