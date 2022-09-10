final logicalO = ['|', '&'];
final relO = ['==', '!=', '<', '>', '<=', '>='];
final re = RegExp(r'[\(\)]');

/// 括号以及 index。
final list = <Bracket2Index>[];

class Bracket2Index {
  final String bracket;
  final int index;

  Bracket2Index({required this.bracket, required this.index});
}

void main() {
  String s = r'a | (b != c) & ((z <= v | n == m) & ((l < j) | (l+1)/2 > 0))';
  recursion(s);
}

void recursion(String s){
  for (var v in re.allMatches(s)) {
    final bra = s.substring(v.start, v.end);
    if (bra == '(') {
      list.add(Bracket2Index(bracket: bra, index: v.start));
    } else if (bra == ')') {
      final braInternal = s.substring(list.last.index + 1, v.start);
      if (braInternal.contains(RegExp('[${logicalO.map((e) => e).join('')}]'))) {}
    } else {
      throw '未知异常！';
    }
  }
}


