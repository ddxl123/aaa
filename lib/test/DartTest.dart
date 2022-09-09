void main() {
  String s = r'zaaif:xxx use: yyyzaa if:xxy use: yyy';
  final vv = r'/if:/g';
  for (var v in RegExp(r'if:[\S\s]*').allMatches(s)) {
    print(s.substring(v.start, v.end));
    print('object');
  }
}
