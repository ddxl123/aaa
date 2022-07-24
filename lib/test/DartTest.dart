
import 'package:uuid/uuid.dart';

void main() {
 final  f = Uuid().v4();
 print(f);
 print(f.codeUnits);
}
