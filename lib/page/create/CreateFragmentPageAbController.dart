import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';

class CreateFragmentPageAbController extends AbController {
  /// 最近的一个 [FragmentGroupModelAbController]。
  late FragmentGroupModelAbController fragmentGroupModelAbController;

  String title = '';

  String content = '';

  @override
  void onInit() {
    fragmentGroupModelAbController = Aber.findLast<FragmentGroupModelAbController>();
  }
}
