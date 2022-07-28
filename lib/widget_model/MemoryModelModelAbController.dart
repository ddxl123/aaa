import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/page/create/CreateModifyMemoryGroupPageAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum MemoryModelModelType {
  home,
  select,
}

class MemoryModelModelAbController extends AbController {
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  final memoryModels = <Ab<MemoryModel>>[].ab;

  final selected = Ab<MemoryModel?>(null);

  @override
  void onInit() {
    selected.refreshEasy((oldValue) => Aber.findOrNullLast<CreateModifyMemoryGroupPageAbController>()?.selectedMemoryModel() ?? oldValue);
  }

  Future<void> addMemoryModel(MemoryModelsCompanion willEntity) async {
    final newEntity = await DriftDb.instance.singleDAO.insertMemoryModel(willEntity);
    memoryModels.refreshInevitable((obj) => obj..add(newEntity.ab));
  }

  Future<void> refreshMemoryModels() async {
    final mgs = (await DriftDb.instance.singleDAO.queryMemoryRules()).map((e) => e.ab);
    memoryModels().clear_(this);
    memoryModels.refreshInevitable((obj) => obj..addAll(mgs));
  }

  void selectMemoryModel(MemoryModel memoryModel) {
    if (selected() == memoryModel) {
      selected.refreshInevitable((obj) => null);
    } else {
      selected.refreshInevitable((obj) => memoryModel);
    }
  }
}
