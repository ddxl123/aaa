import 'dart:math';

void main() async {
  final list = <int>[];
  for (int i = 0; i < 777; i++) {
    final f = Random().nextInt(1679615);
    if (list.contains(f)) {
      print('重复');
    } else {
      list.add(f);
    }
  }
}
