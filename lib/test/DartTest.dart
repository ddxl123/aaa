late final List f;

void main() {
  final obj1 = test();
  final ff = f;
  print(obj1.toString() + ff.toString());
}

OOO test() {
  f = [Obj(OOO()), Obj(OOO()), Obj(OOO())];
  final l = f;
  return l.first.i;
}

class Obj {
  Obj(this.i);

  final OOO i;
}

class OOO {}
