import 'dart:developer';

class A {
  void a() {
    print('aaaa');
  }
}

void main() {
  A? a = A();
  Set s = {a.a};
  a = null;
  print(a.toString());
  print(s.first.call());
}

void a() {}
