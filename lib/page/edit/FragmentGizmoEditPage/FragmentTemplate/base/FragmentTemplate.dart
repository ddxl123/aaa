import 'dart:convert';

import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplate.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../../../../stage/InAppStageAbController.dart';
import '../template/question_answer/QAFragmentTemplate.dart';
import 'SingleQuillController.dart';

enum FragmentTemplateType {
  /// 问答
  questionAnswer,

  /// 选择
  choice,
}

/// 碎片模板的数据基类。
abstract class FragmentTemplate {
  FragmentTemplate() {
    getAllInitSingleEditableQuill().forEach(
      (e) {
        e.focusNode.addListener(
          () {
            if (e.focusNode.hasFocus) {
              currentFocusSingleEditableQuill.value = e;
            }
          },
        );
      },
    );
  }

  FragmentTemplateType get fragmentTemplateType;

  late final InAppStageAbController inAppStageAbController;

  /// 扩展块。
  final _extendChunks = <(SingleQuillController, Map<String, dynamic>)>[];

  List<(SingleQuillController, String)> getExtendChunks() => _extendChunks.map((e) => (e.$1, e.$2["chunk_name"] as String)).toList();

  /// 在记忆展示时，进入碎片时是否需要展示下次的按钮。
  bool get initIsShowBottomButton;

  /// 哪个 [SingleQuillController] 获取了焦点。
  ///
  /// 若为 null, 则无焦点。
  final currentFocusSingleEditableQuill = ValueNotifier<SingleQuillController?>(null);

  /// 内容数据。
  ///
  /// 每次操作碎片记忆信息时会使用，而不是针对当前碎片本身的属性。不会保存在 [toJson] 或者 [resetFromJson] 中。
  final contentValue = <String>[];

  /// 动态添加对焦点的监听。
  void dynamicAddFocusListener(SingleQuillController singleEditableQuill) {
    singleEditableQuill.focusNode.addListener(
      () {
        if (singleEditableQuill.focusNode.hasFocus) {
          currentFocusSingleEditableQuill.value = singleEditableQuill;
        }
      },
    );
  }

  /// 添加扩展块。
  void addExtendChunk(String chunkName) {
    final s = SingleQuillController();
    _extendChunks.add((s, {"chunk_name": chunkName, "content": ""}));
    dynamicAddFocusListener(s);
  }

  /// 移除扩展块。
  void removeExtendChunk(SingleQuillController singleEditableQuill) {
    _extendChunks.removeWhere((element) => element.$1 == singleEditableQuill);
  }

  String getTitle();

  /// 创建当前对象的崭新的空实例。
  FragmentTemplate emptyInitInstance();

  /// 创建当前对象的可传递空实例。
  FragmentTemplate emptyTransferableInstance();

  /// 子类必须使用，不然存储时会漏掉。
  @mustCallSuper
  Map<String, dynamic> toJson() {
    return {"extend_chunks": _extendChunks.map((e) => e.$2).toList()};
  }

  /// 重新设置当前对象的数据。
  ///
  /// 子类必须调用，不然存储时会漏掉。
  @mustCallSuper
  void resetFromJson(Map<String, dynamic> json) {
    _extendChunks.clear();
    final list = json["extend_chunks"] as List;
    for (var l in list) {
      _extendChunks.add((SingleQuillController()..resetContent(l), l));
    }
  }

  /// 返回值第一个参数：必须不为空的内容是否为空
  /// 返回值第二个参数：为空的信息
  (bool, String) isMustContentEmpty();

  void dispose();

  /// 比较两者的 [toJson] 是否完全相同。
  static bool equalFrom(FragmentTemplate a, FragmentTemplate b) => const DeepCollectionEquality().equals(a.toJson(), b.toJson());

  List<SingleQuillController> getAllInitSingleEditableQuill();

  static FragmentTemplate newInstanceFromContent(String content) {
    final Map<String, dynamic> contentJson = jsonDecode(content);
    // 出现 type 异常有可能是 toJson 时没有写 type 字段。
    final type = FragmentTemplateType.values.firstWhere((element) => element.name == (contentJson["type"] as String));
    return templateSwitch(
      type,
      questionAnswer: () => QAFragmentTemplate()..resetFromJson(contentJson),
      choice: () => ChoiceFragmentTemplate()..resetFromJson(contentJson),
    );
  }

  static R templateSwitch<R>(FragmentTemplateType type, {required R Function() questionAnswer, required R Function() choice}) {
    switch (type) {
      case FragmentTemplateType.questionAnswer:
        return questionAnswer();
      case FragmentTemplateType.choice:
        return choice();
      default:
        throw "未处理类型：$type";
    }
  }

  static Future<R> templateSwitchFuture<R>(FragmentTemplateType type, {required Future<R> Function() questionAnswer, required Future<R> Function() choice}) async {
    switch (type) {
      case FragmentTemplateType.questionAnswer:
        return await questionAnswer();
      case FragmentTemplateType.choice:
        return await choice();
      default:
        throw "未处理类型：$type";
    }
  }
}
