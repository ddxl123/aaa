import 'package:aaa/global/GlobalAbController.dart';
import 'package:tools/tools.dart';

class MineHomeAbController extends AbController {
  final globalAbController = Aber.find<GlobalAbController>();

  final info = <String, int>{
    '关注': 1549,
    '被关注': 565,
  }.ab;
}
