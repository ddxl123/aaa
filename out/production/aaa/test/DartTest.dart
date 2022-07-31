
import 'dart:async';

import 'package:uuid/uuid.dart';
import 'package:build/build.dart';

void main() {
 final  f = Uuid().v4();
 print(f);
 print(f.codeUnits);
}



class A extends Builder{
  @override
  FutureOr<void> build(BuildStep buildStep) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  // TODO: implement buildExtensions
  Map<String, List<String>> get buildExtensions => throw UnimplementedError();

}