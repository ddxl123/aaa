import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/drift/vo/FragmentOrGroupVO.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FragmentHomeGetController extends GetxController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  final List<FragmentOrGroupVO> fragmentOrGroupVOs = [];
}
