import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/push_page/push_page.dart';
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
    // 是否是自己创建的
    final isSelf = willDownloadFragmentGroup.creator_user_id == Aber.find<GlobalAbController>().loggedInUser()!.id;
    // 是否已经下载过了
    final hasSaved = (await db.generalQueryDAO.queryFragmentGroupById(id: willDownloadFragmentGroup.id)) != null;

    await showCustomDialog(
      builder: (ctx) {
        return OkAndCancelDialogWidget(
          title: "下载说明",
          text: isSelf ? "这个碎片组是你自己创建的，是否要将云端的更新到本地？" : (hasSaved ? "你已经下载过该碎片组了，是否进行更新下载？" : "无"),
          okText: "下载",
          cancelText: "返回",
          onOk: () async {
            fragmentGroupDownloadWrapper.clearAll();
            final result = await pushToFragmentGroupSelectView(context: context);
            if (result != null) {
              await _downloadFgs(
                willDownloadFragmentGroup: willDownloadFragmentGroup,
                toFragmentGroup: result.$1,
              );
            }
          },
        );
      },
    );
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
        final user = Aber.find<GlobalAbController>().loggedInUser()!;
        // TODO: 下载多次与更新。
        final syncTag = await SyncTag.create();

        // 处理碎片组 ============================================================

        // 允许去重，因为如果重复，说明创建者已经将相同的碎片组进行跳转关联了。
        final fgIdsSet = fragmentGroupDownloadWrapper.fgs.map((e) => e.id).toSet();
        final hasExistedFgIdsSet = await db.generalQueryDAO.queryFragmentGroupIsExistIn(fragmentGroupIds: fgIdsSet);
        for (var v in fragmentGroupDownloadWrapper.fgs) {
          if (hasExistedFgIdsSet.contains(v.id)) {
            await RefFragmentGroups(
              self: () async {
                // 进行 jump 的创建。
                //
                // 只要已经存在，便进行创建。使得 jump 的目标碎片组是唯一的。
                //
                // 无需担心创建是否 id 冲突，因为只要存在原碎片组，重复下载都会创建一个新的对应的 jump 组，而原碎片组始终保持唯一性。
                await Crt.fragmentGroupsCompanion(
                  // 因为是下载的，本身默认就是发布
                  be_publish: v.be_publish,
                  client_be_selected: false,
                  creator_user_id: user.id,
                  // 处理顶层的
                  father_fragment_groups_id: willDownloadFragmentGroup.id == v.id ? (toFragmentGroup?.id).toValue() : v.father_fragment_groups_id.toValue(),
                  // 若 v.jump_to_fragment_groups_id 存在，说明 v 也是个 jump 组，因此要下面这样设置。
                  jump_to_fragment_groups_id: v.jump_to_fragment_groups_id?.toValue() ?? v.id.toValue(),
                  profile: v.profile,
                  title: v.title,
                ).insert(
                  syncTag: syncTag,
                  // 因为别人可能会下载你保存的，因此需要同步。
                  // TODO: 不过会出现一个问题，当原作者删除其跳转的碎片组时，下载者便无法进行跳转。
                  isCloudTableWithSync: true,
                  isCloudTableAutoId: true,
                  isReplaceWhenIdSame: false,
                );

                // 进行已存在的进行更新
                await v.toCompanion(false).insert(
                      syncTag: syncTag,
                      isCloudTableWithSync: false,
                      isCloudTableAutoId: false,
                      isReplaceWhenIdSame: true,
                    );
              },
              fragmentGroupTags: null,
              rFragment2FragmentGroups: null,
              fragmentGroups_father_fragment_groups_id: null,
              fragmentGroups_jump_to_fragment_groups_id: null,
              userComments: null,
              userLikes: null,
              order: 0,
            ).run();
          } else {
            await RefFragmentGroups(
              self: () async {
                // 先把不存在的先进行下载
                await v.toCompanion(false).insert(
                      syncTag: syncTag,
                      isCloudTableWithSync: false,
                      isCloudTableAutoId: false,
                      // 1. 上面的 if 已经排除了本地已存在了。
                      // 2. 如果本地不存在，下载的内容重复了，也不用担心，因为原碎片组的复用也已经按照上面 if 一样处理过了，jump 的目标碎片组是唯一的。
                      isReplaceWhenIdSame: false,
                    );
                // 再插入 root 的 jump
                if (willDownloadFragmentGroup.id == v.id) {
                  await Crt.fragmentGroupsCompanion(
                    be_publish: v.be_publish,
                    client_be_selected: false,
                    creator_user_id: user.id,
                    father_fragment_groups_id: willDownloadFragmentGroup.id == v.id ? (toFragmentGroup?.id).toValue() : v.father_fragment_groups_id.toValue(),
                    jump_to_fragment_groups_id: v.jump_to_fragment_groups_id?.toValue() ?? v.id.toValue(),
                    profile: v.profile,
                    title: v.title,
                  ).insert(
                    syncTag: syncTag,
                    isCloudTableWithSync: true,
                    isCloudTableAutoId: true,
                    isReplaceWhenIdSame: false,
                  );
                }
              },
              fragmentGroupTags: null,
              rFragment2FragmentGroups: null,
              fragmentGroups_father_fragment_groups_id: null,
              fragmentGroups_jump_to_fragment_groups_id: null,
              userComments: null,
              userLikes: null,
              order: 0,
            ).run();
          }
        }

        // 处理碎片 ===================================================

        for (int i = 0; i < fragmentGroupDownloadWrapper.fs.length; i++) {
          final fs = fragmentGroupDownloadWrapper.fs[i];
          await fs.fragments.toCompanion(false).insert(
                syncTag: syncTag,
                isCloudTableWithSync: false,
                isCloudTableAutoId: false,
                // 可替换更新，以防下载了相同的碎片但在不同的碎片组下。
                // 同时可以对碎片进行更新。
                isReplaceWhenIdSame: true,
              );
          for (var element in fs.r_fragment_2_fragment_groups) {
            await element.toCompanion(false).insert(
                  syncTag: syncTag,
                  isCloudTableWithSync: false,
                  isCloudTableAutoId: false,
                  // 可替换更新，以防下载了相同的碎片但在不同的碎片组下，将其归为一组，因为它本身就是同一组。
                  isReplaceWhenIdSame: true,
                );
          }
        }
        // 处理碎片组标签 ===============================================

        for (var element in fragmentGroupDownloadWrapper.fgTags) {
          await element.toCompanion(false).insert(
                syncTag: syncTag,
                isCloudTableWithSync: false,
                isCloudTableAutoId: true,
                // 可替换更新
                isReplaceWhenIdSame: true,
              );
        }
      },
    );
  }
}
