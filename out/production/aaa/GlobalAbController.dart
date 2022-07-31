import 'package:aaa/tool/aber/Aber.dart';

enum Status {
  normal,
  select,
  memory,
}

class GlobalAbController extends AbController {
  final status = Status.normal.ab;
}
