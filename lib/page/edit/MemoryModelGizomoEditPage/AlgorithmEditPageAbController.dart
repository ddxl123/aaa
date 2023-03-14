import 'package:aaa/algorithm_parser/parser.dart';
import 'package:tools/tools.dart';

import 'MemoryModelGizmoEditPageAbController.dart';

class AlgorithmEditPageAbController extends AbController {
  AlgorithmEditPageAbController();

  final memoryModelGizmoEditPageAbController = Aber.findLast<MemoryModelGizmoEditPageAbController>();

  final freeBoxController = FreeBoxController();

  @override
  Future<bool> backListener(bool hasRoute) async {
    // final memoryModelGizmoEditPageAbController = Aber.findLast<MemoryModelGizmoEditPageAbController>();

    return false;
  }
}
