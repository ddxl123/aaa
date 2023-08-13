import 'package:aaa/global/GlobalAbController.dart';
import 'package:tools/tools.dart';

class MineHomeAbController extends AbController {
  final globalAbController = Aber.find<GlobalAbController>();

  /// 关注
  final follow = 0.ab;

  /// 被关注
  final beFollowed = 0.ab;
}
