import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tools/tools.dart';

class Category {
  Category({
    required this.name,
    required this.subCategoryNames,
  });

  final String name;
  final List<String> subCategoryNames;
}

/// 主标签1: 英语
/// 主标签1相关标签: 英语,小学英语, 中学, 初中英语, 高中英语, 中学数学, 大学英语, 高考, 高考英语, 计算机...每个用户都可以实时进行扩增操作
/// 主标签2: 数学
/// 主标签2相关标签: 数学, 小学数学, 中学数学, 高等数学, 三角函数, 中学, 高考, 计算机...每个用户都可以实时进行扩增操作
/// 主标签3: 成语解释
/// 主标签3相关标签: 语文, 中学, 高考...每个用户都可以实时进行扩增操作
/// 主标签4: 数学
/// 主标签4相关标签: 数学, 小学数学, 中学数学, 高等数学, 三角函数, 中学, 高考, 计算机...每个用户都可以实时进行扩增操作
/// 主标签5: 英语
/// 主标签5相关标签: 英语,小学英语, 中学, 初中英语, 高中英语, 中学数学, 大学英语, 高考, 高考英语, 计算机...每个用户都可以实时进行扩增操作
/// 按照相关标签重复次数排序, 来生成大类别
/// 例如以上, 按照 高考-中学-计算机 --- 顺序进行排序
/// 按照大类别所属的主标签重复次数顺序, 来生成1级子类别
/// 例如以上, 大类别高考-1级子类别数学/1级子类别英语
///
/// 会出现一个问题: 假设法硕的碎片有1万个,英语的碎片却只有1千个,这会造成[法硕类别等级高于英语], 这与[英语类别等级高于法硕]的事实相违背
/// 每个用户公开的相同[主-相关标签]的，将视为同一次数，来解决这个问题。
///
/// 热门：按热门类别排序，同以上。
/// 推荐：按推荐类别排序，按照自身的重复次数最高的来排序。
class KnowledgeBaseHomeAbController extends AbController {
  final categories = <Category>[
    Category(name: "全部", subCategoryNames: []),
    Category(name: "其他", subCategoryNames: []),
  ].ab;

  final selectedIndex = 0.ab;

  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  bool get isEnableLoading => true;

  Category getSelectedCategory([Abw? abw]) {
    if (selectedIndex(abw) > categories(abw).length - 1) {
      return categories(abw).first;
    }
    return categories(abw)[selectedIndex(abw)];
  }

  Future<void> refresh() async {
    await _queryCategories(category: null);
  }

  /// 若 [category] 为空，则表示查询主类别。
  Future<void> _queryCategories({required Category? category}) async {
    final result = await request<QueryCategorysDto, QueryCategorysVo>(
      path: HttpPath.NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_QUERY_CATEGORYS,
      dtoData: QueryCategorysDto(be_sub: category != null, category: category!.name),
      parseResponseVoData: QueryCategorysVo.fromJson,
    );
    await result.handleCode(
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outError(show: httperException.showMessage, error: httperException.debugMessage, stackTrace: st);
      },
      code30101: (String showMessage, QueryCategorysVo vo) async {
        categories.refreshInevitable(
          (obj) => obj
            ..insertAll(
              obj.length - 1,
              vo.category_names.split(",").map((e) => Category(name: e, subCategoryNames: [])),
            ),
        );
      },
      code30102: (String showMessage, QueryCategorysVo vo) async {
        category.subCategoryNames.addAll(vo.category_names.split(","));
        categories.refreshForce();
      },
    );
  }
}
