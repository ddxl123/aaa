import 'package:aaa/page/list/FragmentGroupListSelfPageController.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';
import 'package:collection/collection.dart';

import '../../../page/fragment_group_view/FragmentGroupSelectViewAbController.dart';
import '../../../single_dialog/showKnowledgeBaseCategory.dart';

class FragmentGroupDownloadWrapper {
  /// 自身组以及其全部子孙组
  final fgs = <FragmentGroup>[];

  /// [fgs] 中的全部碎片以及对应的关联表。
  final fs = <FragmentGroupWithR>[];

  final fgTags = <FragmentGroupTag>[];

  void clearAll() {
    fgs.clear();
    fs.clear();
    fgTags.clear();
  }
}

class KnowledgeBaseHomeAbController extends AbController {
  final refreshController = RefreshController(initialRefresh: true);
  final knowledgeBaseContentSortTypeAb = KnowledgeBaseContentSortType.by_random.ab;
  final selectedCategoriesAb = <String>[].ab;
  final fragmentGroupsAb = <KnowledgeBaseFragmentGroupWrapperBo>[].ab;

  final fragmentGroupDownloadWrapper = FragmentGroupDownloadWrapper();

  Future<void> refresh() async {
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_QUERY_KNOWLEDGE_BASE_FRAGMENT_GROUPS,
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

}
