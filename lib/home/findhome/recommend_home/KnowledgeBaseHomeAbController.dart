import 'package:aaa/global/GlobalAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';
import 'package:collection/collection.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../single_dialog/showKnowledgeBaseCategory.dart';
import '../../../single_dialog/showSelectFragmentGroupDialog.dart';

class FragmentGroupDownloadWrapper {
  /// 自身组以及其全部子孙组
  final fgs = <FragmentGroup>[];

  /// [fgs] 中的全部碎片以及对应的关联表。
  final fs = <DataDownloadForKnowledgeBaseFragmentWrapperBO>[];

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

  Future<void> download({required FragmentGroup willDownloadFragmentGroup}) async {
    if (willDownloadFragmentGroup.creator_user_id == Aber.find<GlobalAbController>().loggedInUser()!.id) {
      SmartDialog.showToast("不能下载自己创建的！");
      return;
    }
    final hasSaved = await db.generalQueryDAO.queryFragmentGroupBySaveOriginalId(id: willDownloadFragmentGroup.id);
    if (hasSaved != null) {
      SmartDialog.showToast("该碎片组已被保存过！");
      return;
    }
    fragmentGroupDownloadWrapper.clearAll();
    final selectGroup = Ab<List<FragmentGroup>?>(null);
    await showSelectFragmentGroupDialog(
      selectedFragmentGroupChainAb: selectGroup,
      isOnlySelectSynced: false,
      isWithFragments: false,
    );
    if (selectGroup.isAbNotEmpty()) {
      await _downloadFgs(
        willDownloadFragmentGroup: willDownloadFragmentGroup,
        toFragmentGroup: selectGroup()!.lastOrNull,
      );
    }
  }

  Future<void> _downloadFgs({
    required FragmentGroup willDownloadFragmentGroup,
    required FragmentGroup? toFragmentGroup,
  }) async {
    final result = await request(
      path: HttpPath.LOGIN_REQUIRED_DATA_DOWNLOAD_FOR_KNOWLEDGE_BASE,
      dtoData: DataDownloadForKnowledgeBaseDto(
        fragment_group_id: willDownloadFragmentGroup.id,
        fragment_group_ids_for_fragments_list: null,
        fragment_group_ids_for_tags_list: null,
      ),
      parseResponseVoData: DataDownloadForKnowledgeBaseVo.fromJson,
    );
    await result.handleCode(
      code40201: (String showMessage, DataDownloadForKnowledgeBaseVo vo) async {
        fragmentGroupDownloadWrapper.fgs.addAll(vo.fragment_group_self_and_subs_list!);
        await _downloadFs(
          willDownloadFragmentGroup: willDownloadFragmentGroup,
          toFragmentGroup: toFragmentGroup,
        );
      },
      code40202: (String showMessage, DataDownloadForKnowledgeBaseVo vo) async {
        logger.outErrorShouldNot();
      },
      code40203: (String showMessage, DataDownloadForKnowledgeBaseVo vo) async {
        logger.outErrorShouldNot();
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  Future<void> _downloadFs({
    required FragmentGroup willDownloadFragmentGroup,
    required FragmentGroup? toFragmentGroup,
  }) async {
    final result = await request(
      path: HttpPath.LOGIN_REQUIRED_DATA_DOWNLOAD_FOR_KNOWLEDGE_BASE,
      dtoData: DataDownloadForKnowledgeBaseDto(
        fragment_group_id: null,
        fragment_group_ids_for_fragments_list: fragmentGroupDownloadWrapper.fgs.map((e) => e.id).toList(),
        fragment_group_ids_for_tags_list: null,
      ),
      parseResponseVoData: DataDownloadForKnowledgeBaseVo.fromJson,
    );
    await result.handleCode(
      code40201: (String showMessage, DataDownloadForKnowledgeBaseVo vo) async {
        logger.outErrorShouldNot();
      },
      code40202: (String showMessage, DataDownloadForKnowledgeBaseVo vo) async {
        fragmentGroupDownloadWrapper.fs.addAll(vo.fragment_wrappers_list!);
        await _downloadFTags(
          willDownloadFragmentGroup: willDownloadFragmentGroup,
          toFragmentGroup: toFragmentGroup,
        );
      },
      code40203: (String showMessage, DataDownloadForKnowledgeBaseVo vo) async {
        logger.outErrorShouldNot();
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  Future<void> _downloadFTags({
    required FragmentGroup willDownloadFragmentGroup,
    required FragmentGroup? toFragmentGroup,
  }) async {
    final result = await request(
      path: HttpPath.LOGIN_REQUIRED_DATA_DOWNLOAD_FOR_KNOWLEDGE_BASE,
      dtoData: DataDownloadForKnowledgeBaseDto(
        fragment_group_id: null,
        fragment_group_ids_for_fragments_list: null,
        fragment_group_ids_for_tags_list: fragmentGroupDownloadWrapper.fgs.map((e) => e.id).toList(),
      ),
      parseResponseVoData: DataDownloadForKnowledgeBaseVo.fromJson,
    );
    await result.handleCode(
      code40201: (String showMessage, DataDownloadForKnowledgeBaseVo vo) async {
        logger.outErrorShouldNot();
      },
      code40202: (String showMessage, DataDownloadForKnowledgeBaseVo vo) async {
        logger.outErrorShouldNot();
      },
      code40203: (String showMessage, DataDownloadForKnowledgeBaseVo vo) async {
        fragmentGroupDownloadWrapper.fgTags.addAll(vo.fragment_group_tags_list!);
        await _insertToSqlite(
          willDownloadFragmentGroup: willDownloadFragmentGroup,
          toFragmentGroup: toFragmentGroup,
        );
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
      },
    );
  }

  Future<void> _insertToSqlite({
    required FragmentGroup willDownloadFragmentGroup,
    required FragmentGroup? toFragmentGroup,
  }) async {
    await db.transaction(
      () async {
        // TODO: 下载多次与更新。
        final syncTag = await SyncTag.create();
        // 处理碎片组
        final willDownloadRoot = fragmentGroupDownloadWrapper.fgs.singleWhere((element) => element.id == willDownloadFragmentGroup.id);
        final beforeModifyRootId = willDownloadRoot.id;
        // 重置 father_fragment_groups_id
        willDownloadRoot.father_fragment_groups_id = toFragmentGroup?.id;
        willDownloadRoot.save_original_id = beforeModifyRootId;
        final newRoot = await willDownloadRoot.toCompanion(false).insert(
              syncTag: syncTag,
              isCloudTableWithSync: true,
              // 重置 id
              isCloudTableAutoId: true,
              // 不可替换更新，因为每次都要重新分配 id
              isReplaceWhenIdSame: false,
            );
        fragmentGroupDownloadWrapper.fgs.remove(willDownloadRoot);
        final rootOneSubs = fragmentGroupDownloadWrapper.fgs.where((element) => element.father_fragment_groups_id == beforeModifyRootId).toList();
        for (var value in rootOneSubs) {
          // 重置 father_fragment_groups_id
          value.father_fragment_groups_id = newRoot.id;
          await value.toCompanion(false).insert(
                syncTag: syncTag,
                isCloudTableWithSync: false,
                isCloudTableAutoId: false,
                // 不可替换更新，因为修改了父碎片组，如果下载重复的，得需要再重新修改父碎片组。
                isReplaceWhenIdSame: false,
              );
          fragmentGroupDownloadWrapper.fgs.remove(value);
        }
        for (var fg in fragmentGroupDownloadWrapper.fgs) {
          await fg.toCompanion(false).insert(
                syncTag: syncTag,
                isCloudTableWithSync: false,
                isCloudTableAutoId: false,
                // 可替换更新，因为没有进行如何更改，以防下载了相同的碎片组但在不同的碎片组下。
                isReplaceWhenIdSame: true,
              );
        }

        //=========================================

        // 处理碎片
        for (int i = 0; i < fragmentGroupDownloadWrapper.fs.length; i++) {
          final fs = fragmentGroupDownloadWrapper.fs[i];
          await fs.fragments.toCompanion(false).insert(
                syncTag: syncTag,
                isCloudTableWithSync: false,
                isCloudTableAutoId: false,
                // 可替换更新，以防下载了相同的碎片但在不同的碎片组下。
                isReplaceWhenIdSame: true,
              );
          for (var element in fs.r_fragment_2_fragment_groups) {
            if (element.fragment_group_id == beforeModifyRootId) {
              element.fragment_group_id = newRoot.id;
              await element.toCompanion(false).insert(
                    syncTag: syncTag,
                    isCloudTableWithSync: false,
                    isCloudTableAutoId: false,
                    // 不可替换更新，因为需要修改碎片组 id。
                    isReplaceWhenIdSame: false,
                  );
            } else {
              await element.toCompanion(false).insert(
                    syncTag: syncTag,
                    isCloudTableWithSync: false,
                    isCloudTableAutoId: false,
                    // 可替换更新，以防下载了相同的碎片但在不同的碎片组下。
                    isReplaceWhenIdSame: true,
                  );
            }
          }
        }
        //=========================================

        // 处理碎片组标签
        for (var element in fragmentGroupDownloadWrapper.fgTags) {
          if (element.fragment_group_id == beforeModifyRootId) {
            element.fragment_group_id = newRoot.id;

            await element.toCompanion(false).insert(
                  syncTag: syncTag,
                  isCloudTableWithSync: false,
                  isCloudTableAutoId: false,
                  // 不可替换更新，因为需要修改碎片组 id。
                  isReplaceWhenIdSame: false,
                );
          } else {
            await element.toCompanion(false).insert(
                  syncTag: syncTag,
                  isCloudTableWithSync: false,
                  isCloudTableAutoId: true,
                  // 可替换更新
                  isReplaceWhenIdSame: true,
                );
          }
        }
      },
    );
  }
}
