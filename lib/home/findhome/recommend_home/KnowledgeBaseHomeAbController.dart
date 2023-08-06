import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';
import 'package:collection/collection.dart';

import '../../../single_dialog/showKnowledgeBaseCategory.dart';
import '../../../single_dialog/showSelectFragmentGroupDialog.dart';

class KnowledgeBaseHomeAbController extends AbController {
  final refreshController = RefreshController(initialRefresh: true);
  final knowledgeBaseContentSortTypeAb = KnowledgeBaseContentSortType.by_random.ab;
  final selectedCategoriesAb = <String>[].ab;
  final fragmentGroupsAb = <KnowledgeBaseFragmentGroupWrapperBo>[].ab;

  Future<void> refresh() async {
    final result = await request(
      path: HttpPath.NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_QUERY_KNOWLEDGE_BASE_FRAGMENT_GROUPS,
      dtoData: KnowledgeBaseFragmentGroupQueryDto(
        sub_categories_list: selectedCategoriesAb(),
        knowledge_base_content_sort_type: knowledgeBaseContentSortTypeAb(),
        page: 0,
        size: 20,
      ),
      parseResponseVoData: KnowledgeBaseFragmentGroupQueryVo.fromJson,
    );
    await result.handleCode(
      code30301: (String showMessage, KnowledgeBaseFragmentGroupQueryVo vo) async {
        fragmentGroupsAb.refreshInevitable((obj) => obj
          ..clear()
          ..addAll(vo.fragment_group_wrapper_list));
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(
          code: code,
          showMessage: httperException.showMessage,
          debugMessage: httperException.debugMessage,
          st: st,
        );
      },
    );
    refreshController.refreshCompleted();
  }

  Future<void> categorySelect() async {
    final init = [...selectedCategoriesAb()];
    await showKnowledgeBaseCategory(context: context, initSelectedSubCategories: selectedCategoriesAb);
    if (!const DeepCollectionEquality.unordered().equals(init, selectedCategoriesAb())) {
      refreshController.requestRefresh();
    }
  }

  Future<void> downloadFragment({required FragmentGroup fragmentGroup}) async {
    final selectGroup = Ab<List<FragmentGroup>?>(null);
    await showSelectFragmentGroupDialog(
      selectedFragmentGroupChainAb: selectGroup,
      isOnlySelectSynced: false,
      isWithFragments: false,
    );
    if (selectGroup.isAbNotEmpty()) {
      final result = await request(
        path: HttpPath.LOGIN_REQUIRED_DATA_DOWNLOAD_FOR_KNOWLEDGE_BASE,
        dtoData: DataDownloadForKnowledgeBaseDto(
          fragment_group_id: fragmentGroup.id,
          dto_padding_1: null,
        ),
        parseResponseVoData: DataDownloadForKnowledgeBaseVo.fromJson,
      );
      await result.handleCode(
        code40201: (String showMessage, DataDownloadForKnowledgeBaseVo vo) async {
          print(vo.fragment_group_self_and_subs_list!.length);
        },
        otherException: (int? code, HttperException httperException, StackTrace st) async {
          logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
        },
      );
    }
  }
}
