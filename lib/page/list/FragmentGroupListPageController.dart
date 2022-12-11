import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';

class FragmentGroupListPageController extends GroupListWidgetController<FragmentGroup, Fragment> {
  @override
  Future<GroupsAndUnitEntities<FragmentGroup, Fragment>> findEntities(FragmentGroup? whichGroupEntity) async {
    final fs = await DriftDb.instance.generalQueryDAO.queryFragmentsInFragmentGroup(targetFragmentGroup: whichGroupEntity);
    final fgs = await DriftDb.instance.generalQueryDAO.queryFragmentGroupsInFragmentGroup(targetFragmentGroup: whichGroupEntity);
    return GroupsAndUnitEntities(
      unitEntities: fs,
      groupEntities: fgs,
    );
  }

  @override
  Future<Tuple2<int, int>> refreshCount(FragmentGroup? whichGroupEntity) async {
    final selectedCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
      targetFragmentGroup: whichGroupEntity,
      queryFragmentWhereType: QueryFragmentWhereType.selected,
    );
    final allCount = await DriftDb.instance.generalQueryDAO.querySubFragmentsCountInFragmentGroup(
      targetFragmentGroup: whichGroupEntity,
      queryFragmentWhereType: QueryFragmentWhereType.all,
    );
    return Tuple2(t1: selectedCount, t2: allCount);
  }
}
