void main() async {
  print(await B().a.f(111));
}

class A {
  final Future<int> Function(int) f;

  A(this.f);
}

class B {
  int i = 1;
  late final A a = A((v) async => v + i);
}
