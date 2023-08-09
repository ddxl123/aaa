import 'dart:async';
import 'dart:convert';

import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tools/tools.dart';

class FragmentGroupListViewAbController extends GroupListWidgetController<FragmentGroup, Fragment> {
  FragmentGroupListViewAbController({required this.enterFragmentGroup});

  final FragmentGroup enterFragmentGroup;

  final currentFragmentGroupTagsAb = <FragmentGroupTag>[].ab;


  @override
  Future<bool> backListener(bool hasRoute) async {
    if (hasRoute) return false;
    if (groupChain().length > 1) {
      await backGroup();
      return true;
    }
    return false;
  }

  @override
  Future<GroupsAndUnitEntities<FragmentGroup, Fragment>> findEntities(FragmentGroup? whichGroupEntity) async {
    final result = await request(
      path: HttpPath.NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_QUERY_KNOWLEDGE_BASE_FRAGMENT_GROUP_INNER,
      dtoData: KnowledgeBaseFragmentGroupInnerQueryDto(
        fragment_group_id: whichGroupEntity?.id ?? enterFragmentGroup.id,
        dto_padding_1: null,
      ),
      parseResponseVoData: KnowledgeBaseFragmentGroupInnerQueryVo.fromJson,
    );
    final gaue = await result.handleCode(
      code30401: (String showMessage, KnowledgeBaseFragmentGroupInnerQueryVo vo) async {
        currentFragmentGroupTagsAb()
          ..clear()
          ..addAll(vo.fragment_group_self_tags_list);

        if (whichGroupEntity == null) {
          setRootGroupEntity(vo.fragment_groups_list.singleWhere((element) => element.id == enterFragmentGroup.id));
        }
        return GroupsAndUnitEntities<FragmentGroup, Fragment>(
          // 因为查询的包含 whichGroupEntity 自身，因此排除掉。
          groupEntities: vo.fragment_groups_list.where((element) => element.id != (whichGroupEntity?.id ?? enterFragmentGroup.id)).toList(),
          unitEntities: vo.fragments_list.map((e) => e.fragment).toList(),
        );
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(code: code, showMessage: httperException.showMessage, debugMessage: httperException.debugMessage, st: st);
        // TODO：
        throw "出现异常！";
      },
    );
    return gaue;
  }

  @override
  Future<(int, int)> needRefreshCount(FragmentGroup? whichGroupEntity) async {
    return (0, 0);
  }

  @override
  FutureOr<void> refreshExtra() {}

  @override
  FutureOr<void> refreshDone() {
    refreshQuill(fragmentGroup: getCurrentGroupAb()().entity()!);
  }

  void refreshQuill({required FragmentGroup fragmentGroup}) {
  }
}
