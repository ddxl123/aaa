void main() async {
  print('object');
  print([].map((e) => '($e)').join('|'));
  print('大苏打'.replaceAllMapped(
    RegExp(''==''?'null':'eee'),
    (match) {
      print(match.start);
      return '';
    },
  ));
}
