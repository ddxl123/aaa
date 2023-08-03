import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';
import 'package:collection/collection.dart';

import '../../../single_dialog/showKnowledgeBaseCategory.dart';

class KnowledgeBaseHomeAbController extends AbController {
  final refreshController = RefreshController(initialRefresh: true);
  final selectedCategories = <String>[].ab;

  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 1));
    refreshController.refreshCompleted();
  }

  Future<void> categorySelect() async {
    final init = [...selectedCategories()];
    await showKnowledgeBaseCategory(context: context, initSelectedSubCategories: selectedCategories);
    if (!const DeepCollectionEquality.unordered().equals(init, selectedCategories())) {
      refreshController.requestRefresh();
    }
  }
}

// import 'package:aaa/data/DataDownload.dart';
// import 'package:aaa/global/GlobalAbController.dart';
// import 'package:aaa/single_dialog/data_download/showDataDownloadDialog.dart';
// import 'package:aaa/single_dialog/register_or_login/showAskLoginDialog.dart';
// import 'package:drift_main/drift/DriftDb.dart';
// import 'package:drift_main/httper/httper.dart';
// import 'package:drift_main/share_common/share_enum.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// import 'package:tools/tools.dart';
//
// import '../../../single_dialog/showSelectFragmentGroupDialog.dart';
//
// class Category {
//   Category({
//     required this.name,
//     required this.subCategories,
//   });
//
//   final String name;
//   final List<Category> subCategories;
// }
//
// /// 主标签1: 英语
// /// 主标签1相关标签: 英语,小学英语, 中学, 初中英语, 高中英语, 中学数学, 大学英语, 高考, 高考英语, 计算机...每个用户都可以实时进行扩增操作
// /// 主标签2: 数学
// /// 主标签2相关标签: 数学, 小学数学, 中学数学, 高等数学, 三角函数, 中学, 高考, 计算机...每个用户都可以实时进行扩增操作
// /// 主标签3: 成语解释
// /// 主标签3相关标签: 语文, 中学, 高考...每个用户都可以实时进行扩增操作
// /// 主标签4: 数学
// /// 主标签4相关标签: 数学, 小学数学, 中学数学, 高等数学, 三角函数, 中学, 高考, 计算机...每个用户都可以实时进行扩增操作
// /// 主标签5: 英语
// /// 主标签5相关标签: 英语,小学英语, 中学, 初中英语, 高中英语, 中学数学, 大学英语, 高考, 高考英语, 计算机...每个用户都可以实时进行扩增操作
// /// 按照相关标签重复次数排序, 来生成大类别
// /// 例如以上, 按照 高考-中学-计算机 --- 顺序进行排序
// /// 按照大类别所属的主标签重复次数顺序, 来生成1级子类别
// /// 例如以上, 大类别高考-1级子类别数学/1级子类别英语
// ///
// /// 会出现一个问题: 假设法硕的碎片有1万个,英语的碎片却只有1千个,这会造成[法硕类别等级高于英语], 这与[英语类别等级高于法硕]的事实相违背
// /// 每个用户公开的相同[主-相关标签]的，将视为同一次数，来解决这个问题。
// ///
// /// 热门：按热门类别排序，同以上。
// /// 推荐：按推荐类别排序，按照自身的重复次数最高的来排序。
// class KnowledgeBaseHomeAbController extends AbController {
//   final categories = <Category>[].ab;
//
//   final knowledgeBaseContentListAb = <Ab<KnowledgeBaseContent>>[].ab;
//
//   final selectedMainIndex = 0.ab;
//
//   final selectedSubIndex = 0.ab;
//
//   final currentKnowledgeBaseContentSortTypeAb = KnowledgeBaseContentSortType.by_random.ab;
//
//   RefreshController refreshController = RefreshController(initialRefresh: true);
//
//   Category? getSelectedMainCategory([Abw? abw]) {
//     if (categories(abw).isEmpty) return null;
//     return categories(abw)[selectedMainIndex(abw)];
//   }
//
//   Category? getSelectedSubCategory([Abw? abw]) {
//     final subs = getSelectedMainCategory(abw)?.subCategories;
//     if (subs == null) return null;
//     return subs.isEmpty ? null : subs[selectedSubIndex(abw)];
//   }
//
//   /// 当点击了 [mainCategory] 时,[subCategory] 为 null，子类别会默认"全部"。
//   ///
//   /// 当点击了 [subCategory] 时，[mainCategory] 为 null，会自动利用当前已选主类别。
//   ///
//   /// 当 [mainCategory] 与 [subCategory] 同时为空时，会刷新当前。
//   ///
//   /// 当 [currentKnowledgeBaseContentSortType] 为 null 时，使用当前排序方式。
//   Future<void> changeTo({
//     required Category? mainCategory,
//     required Category? subCategory,
//     required KnowledgeBaseContentSortType? currentKnowledgeBaseContentSortType,
//   }) async {
//     if (mainCategory != null) {
//       selectedMainIndex.refreshEasy((obj) => categories().indexOf(mainCategory));
//       selectedSubIndex.refreshEasy((oldValue) => 0);
//     }
//     if (subCategory != null) {
//       selectedSubIndex.refreshEasy((oldValue) => getSelectedMainCategory()!.subCategories.indexOf(subCategory));
//     }
//     currentKnowledgeBaseContentSortTypeAb.refreshEasy((oldValue) => currentKnowledgeBaseContentSortType ?? currentKnowledgeBaseContentSortTypeAb());
//     await refreshController.requestRefresh();
//   }
//
//   Future<void> refreshPage() async {
//     final one = await _refreshCategories(
//       knowledgeBaseQueryDto: KnowledgeBaseQueryDto(
//         main_category: null,
//         sub_category: null,
//         knowledge_base_content_sort_type: currentKnowledgeBaseContentSortTypeAb(),
//         page: null,
//         size: null,
//       ),
//     );
//     if (!one) {
//       refreshController.refreshFailed();
//       return;
//     }
//     if (getSelectedMainCategory() == null) {
//       refreshController.refreshFailed();
//       return;
//     }
//     final two = await _refreshCategories(
//       knowledgeBaseQueryDto: KnowledgeBaseQueryDto(
//         main_category: getSelectedMainCategory()!.name,
//         sub_category: null,
//         knowledge_base_content_sort_type: currentKnowledgeBaseContentSortTypeAb(),
//         page: null,
//         size: null,
//       ),
//     );
//     if (!two) {
//       refreshController.refreshFailed();
//       return;
//     }
//     final three = await _refreshCategories(
//       knowledgeBaseQueryDto: KnowledgeBaseQueryDto(
//         main_category: getSelectedMainCategory()!.name,
//         sub_category: getSelectedSubCategory()?.name ?? "全部",
//         knowledge_base_content_sort_type: currentKnowledgeBaseContentSortTypeAb(),
//         page: 0,
//         size: 20,
//       ),
//     );
//     if (!three) {
//       refreshController.refreshFailed();
//       return;
//     }
//     refreshController.refreshCompleted();
//   }
//
//   /// 若 [category] 为空，则表示查询主类别。
//   ///
//   /// 返回是否查询成功。
//   Future<bool> _refreshCategories({required KnowledgeBaseQueryDto knowledgeBaseQueryDto}) async {
//     final result = await request<KnowledgeBaseQueryDto, KnowledgeBaseQueryVo>(
//       path: HttpPath.NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_QUERY_CATEGORYS,
//       dtoData: knowledgeBaseQueryDto,
//       parseResponseVoData: KnowledgeBaseQueryVo.fromJson,
//     );
//     return await result.handleCode(
//       otherException: (int? code, HttperException httperException, StackTrace st) async {
//         logger.outError(show: httperException.showMessage, error: httperException.debugMessage, stackTrace: st);
//         return false;
//       },
//       code30101: (String showMessage, KnowledgeBaseQueryVo vo) async {
//         final olds = categories().map((e) => e.name).toList().toJson();
//         final news = vo.category_names!;
//         if (olds == news) return true;
//
//         categories.refreshInevitable(
//           (obj) => obj
//             ..clear()
//             ..insertAll(0, vo.category_names!.jsonToArray().map((e) => Category(name: e, subCategories: []))),
//         );
//         return true;
//       },
//       code30102: (String showMessage, KnowledgeBaseQueryVo vo) async {
//         final olds = getSelectedMainCategory()!.subCategories;
//         final news = vo.category_names == null ? null : vo.category_names!.jsonToArray();
//         // news 为 null 意味着主类别为"全部"
//         if (news == null) return true;
//         if (olds == news) return true;
//
//         getSelectedMainCategory()!.subCategories
//           ..clear()
//           ..addAll((vo.category_names == null ? [] : vo.category_names!.jsonToArray().map((e) => Category(name: e, subCategories: []))));
//         categories.refreshForce();
//         return true;
//       },
//       code30103: (String showMessage, KnowledgeBaseQueryVo vo) async {
//         knowledgeBaseContentListAb.clearBroken(this);
//         knowledgeBaseContentListAb.refreshInevitable((obj) => obj..addAll(vo.knowledge_base_content_list!.map((e) => e.ab)));
//         return true;
//       },
//     );
//   }
//
//   Future<void> collect({required Ab<KnowledgeBaseContent> whichKnowledgeBaseContentAb}) async {
//     final user = Aber.find<GlobalAbController>().loggedInUser;
//     if (user.isAbEmpty()) {
//       showAskLoginDialog();
//       return;
//     }
//     final selectedFragmentGroupChainAb = Ab<List<FragmentGroup>?>(null);
//     await showSelectFragmentGroupDialog(selectedFragmentGroupChainAb: selectedFragmentGroupChainAb, isWithFragments: false);
//     if (selectedFragmentGroupChainAb.isAbNotEmpty()) {
//       showDataDownloadDialog(
//         (c) async {
//           await DataDownload.downloadForFragmentGroup(
//             downloadRootFragmentGroup: whichKnowledgeBaseContentAb().fragment_group,
//             saveFragmentGroup: selectedFragmentGroupChainAb()?.isEmpty == true ? null : selectedFragmentGroupChainAb()?.last,
//           );
//           c.progress.refreshEasy((oldValue) => 100);
//           SmartDialog.dismiss(status: SmartStatus.dialog);
//         },
//       );
//     }
//   }
// }
