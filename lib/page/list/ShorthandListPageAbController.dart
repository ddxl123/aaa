import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class ShorthandListPageAbController extends AbController {
  final refreshController = RefreshController(initialRefresh: true);
  final shorthandsAb = <Shorthand>[].ab;

  Future<void> refreshPage() async {
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_SHORTHAND_HANDLE_SHORTHANDS_QUERY,
      dtoData: ShorthandsQueryDto(
        user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
        dto_padding_1: null,
      ),
      parseResponseVoData: ShorthandsQueryVo.fromJson,
    );
    await result.handleCode(
      code170101: (String showMessage, ShorthandsQueryVo vo) async {
        shorthandsAb.refreshInevitable((obj) => obj
          ..clear()
          ..addAll(vo.shorthands_list));
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
  }
}
