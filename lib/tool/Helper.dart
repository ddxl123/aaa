import 'package:uuid/uuid.dart';

class Helper {
  static const Uuid _uuid = Uuid();

  static String get uuidV4 => _uuid.v4();
}
