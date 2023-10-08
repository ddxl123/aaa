import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:tools/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryModeListPageAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryModelsAb = <MemoryModel>[].ab;

  @override
  void onDispose() {
    refreshController.dispose();
    super.onDispose();
  }

  Future<void> refreshPage() async {
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_MEMORY_MODEL_HANDLE_MEMORY_MODELS_QUERY,
      dtoData: MemoryModelsQueryDto(
        user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
        dto_padding_1: null,
      ),
      parseResponseVoData: MemoryModelsQueryVo.fromJson,
    );
    await result.handleCode(
      code180101: (String showMessage, vo) async {
        await driftDb.transaction(
          () async {
            await driftDb.deleteDAO.deleteAllMemoryModels();
            await driftDb.insertDAO.insertManyMemoryModels(mms: vo.memory_models_list);

            memoryModelsAb.refreshInevitable(
              (obj) => obj
                ..clear()
                ..addAll(vo.memory_models_list),
            );
          },
        );
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
  }
}
