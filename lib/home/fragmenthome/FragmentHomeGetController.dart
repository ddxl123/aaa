import 'package:aber/Aber.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FragmentHomeGetController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  final Ab<List<Ab<dynamic>>> sections = <Ab<dynamic>>[].ab;
}
