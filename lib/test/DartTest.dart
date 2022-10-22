void main() async {
  print('大苏打'.replaceAllMapped(
    RegExp('(${['1'].map((e) => '($e)').join('|')})'),
    (match) {
      print('match: ${match.start}');
      return '';
    },
  ));
}
