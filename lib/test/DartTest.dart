void main() async {
  print(RegExp(r'[0-9]').allMatches('dsad123d1').map((e) => e.group(0)));
}
