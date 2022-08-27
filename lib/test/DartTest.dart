void main() {
  C()..i(222);
}

class C {
  C() {
    i(1111);
  }

  void i(int i) {
    print(i.toString());
  }
}
