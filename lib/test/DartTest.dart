import 'dart:math';

void main() async {
  print(createId(userId: 1));
}

String createId({required int userId}) {
  String prefix = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toRadixString(36);
  String center = userId.toRadixString(36);
  String suffix = Random().nextInt(46655).toRadixString(36);
  prefix = '0' * (7 - prefix.length) + prefix;
  center = '0' * (7 - center.length) + center;
  suffix = '0' * (3 - suffix.length) + suffix;
  return prefix + center + suffix;
}
