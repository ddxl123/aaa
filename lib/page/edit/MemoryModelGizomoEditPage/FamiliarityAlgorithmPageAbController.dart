import 'package:tools/tools.dart';

import 'MemoryModelGizmoEditPageAbController.dart';

class FamiliarityAlgorithmPageAbController extends AbController {
  @override
  Future<bool> backListener(bool hasRoute) async {
    final memoryModelGizmoEditPageAbController = Aber.findLast<MemoryModelGizmoEditPageAbController>();

    return false;
  }
}
