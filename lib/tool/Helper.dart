import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class Helper {
  static const Uuid _uuid = Uuid();

  static String get uuidV4 => _uuid.v4();

  static Logger logger = Logger(printer: SimplePrinter());

  /// [from] - 输入要筛选的值。
  ///
  /// [targets] - {[value1,value2]:returnValue}，如果 [from] 的值为 value1 或 value2，则返回 returnValue。
  ///
  /// [orElse] - 当 [targets] 未通过时，会返回 [orElse]。如果 [orElse] 为null，则抛出异常。
  static R filter<E, R>({
    required E from,
    required Map<List<E>, R Function()> targets,
    required R Function()? orElse,
  }) {
    bool isEver = false;
    for (var key in targets.keys) {
      if (key.contains(from)) {
        if (isEver) throw '不能在不同的key中多次使用相同的值！';
        isEver = true;
        return targets[key]!();
      }
    }
    if (orElse == null) throw '存在未处理筛查。';
    return orElse();
  }
}
