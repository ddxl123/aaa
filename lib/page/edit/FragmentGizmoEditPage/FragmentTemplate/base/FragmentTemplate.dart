import 'dart:convert';

import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplate.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/single/SimpleFragmentTemplate.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../../../stage/InAppStageAbController.dart';
import '../template/question_answer/QAFragmentTemplate.dart';
import 'SingleQuillController.dart';

enum FragmentTemplateType {
  /// 单面
  single,

  /// 问答
  questionAnswer,

  /// 选择
  choice,
}

enum ExtendChunkDisplayType {
  /// 仅在未显示答案时显示
  only_start(displayName: "仅在显示问题时显示"),

  /// 仅在显示答案是显示
  only_end(displayName: "仅在显示答案时显示"),

  /// 无论有没有显示答案，都显示
  always(displayName: "总是显示");

  const ExtendChunkDisplayType({required this.displayName});

  final String displayName;
}

class ExtendChunk {
  ExtendChunk({
    required this.singleQuillController,
    required this.extendChunkDisplayType,
    required this.chunkName,
  });

  final SingleQuillController singleQuillController;

  ExtendChunkDisplayType extendChunkDisplayType;

  String chunkName;

  void dispose() {
    singleQuillController.dispose();
  }

  Map<String, dynamic> toJson() {
    return {
      "chunk_name": chunkName,
      "extend_chunk_display_type": extendChunkDisplayType.name,
      "content": singleQuillController.getContentJsonString(),
    };
  }

  factory ExtendChunk.fromJson(Map<String, dynamic> json) {
    return ExtendChunk(
      singleQuillController: SingleQuillController()..resetContent(json["content"]),
      extendChunkDisplayType: ExtendChunkDisplayType.values.firstWhere((element) => element.name == (json["extend_chunk_display_type"] as String)),
      chunkName: json["chunk_name"] as String,
    );
  }
}

/// 碎片模板的数据基类。
abstract class FragmentTemplate {
  FragmentTemplate() {
    listenSingleEditableQuill().forEach(
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

  /// 非记忆展示时，这个控制器可为 null。
  InAppStageAbController? inAppStageAbController;

  /// 扩展块。
  final _extendChunks = <ExtendChunk>[];

  /// 是否隐藏扩展块类型的选择。
  bool isHideExtendChunkTypeOption() => false;

  List<ExtendChunk> get extendChunks => _extendChunks;

  /// 在记忆展示时，进入碎片时是否需要展示底部的下次记忆按钮。
  bool get initIsShowBottomButton;

  /// 哪个 [SingleQuillController] 获取了焦点。
  ///
  /// 若为 null, 则无焦点。
  final currentFocusSingleEditableQuill = ValueNotifier<SingleQuillController?>(null);

  /// 内容数据。
  ///
  /// 每次操作碎片记忆信息时会使用，而不是针对当前碎片本身的属性。不会保存在 [toJson] 或者 [resetFromJson] 中。
  final memoryInfoData = <String>[];

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
  void addExtendChunk({
    required String chunkName,
    required ExtendChunkDisplayType extendsChunkDisplayType,
  }) {
    final s = SingleQuillController();
    _extendChunks.add(
      ExtendChunk(
        singleQuillController: s,
        extendChunkDisplayType: extendsChunkDisplayType,
        chunkName: chunkName,
      ),
    );
    dynamicAddFocusListener(s);
  }

  /// 移除扩展块。
  void removeExtendChunk(ExtendChunk extendChunk) {
    extendChunk.dispose();
    _extendChunks.remove(extendChunk);
  }

  String getTitle();

  /// 创建当前对象的崭新的空实例。
  FragmentTemplate emptyInitInstance();

  /// 创建当前对象的可传递空实例。
  ///
  /// 在创建碎片时，下一次创建要保留的配置数据。
  FragmentTemplate emptyTransferableInstance();

  /// 子类必须使用，不然存储时会漏掉。
  @mustCallSuper
  Map<String, dynamic> toJson() {
    return {"extend_chunks": _extendChunks.map((e) => e.toJson()).toList()};
  }

  /// 重新设置当前对象的数据。
  ///
  /// 子类必须调用，不然存储时会漏掉。
  @mustCallSuper
  void resetFromJson(Map<String, dynamic> json) {
    for (var element in _extendChunks) {
      element.dispose();
    }
    _extendChunks.clear();
    final list = json["extend_chunks"] as List;
    for (var l in list) {
      _extendChunks.add(ExtendChunk.fromJson(l));
    }
  }

  /// 返回值第一个参数：必须不为空的内容是否为空
  /// 返回值第二个参数：为空的信息
  (bool, String) isMustContentEmpty();

  void dispose();

  /// 比较两者的 [toJson] 是否完全相同。
  static bool equalFrom(FragmentTemplate a, FragmentTemplate b) => const DeepCollectionEquality().equals(a.toJson(), b.toJson());

  /// 获取子类所配置的全部 [SingleQuillController]，以便对焦点进行切换操作。
  ///
  /// [extendChunks] 由 [addExtendChunk] 进行添加操作。
  List<SingleQuillController> listenSingleEditableQuill();

  static FragmentTemplate newInstanceFromContent(String content) {
    final Map<String, dynamic> contentJson = jsonDecode(content);
    // 出现 type 异常有可能是 toJson 时没有写 type 字段。
    final type = FragmentTemplateType.values.firstWhere((element) => element.name == (contentJson["type"] as String));
    return templateSwitch(
      type,
      questionAnswer: () => QAFragmentTemplate()..resetFromJson(contentJson),
      choice: () => ChoiceFragmentTemplate()..resetFromJson(contentJson),
      simple: () => SimpleFragmentTemplate()..resetFromJson(contentJson),
    );
  }

  static R templateSwitch<R>(
    FragmentTemplateType type, {
    required R Function() simple,
    required R Function() questionAnswer,
    required R Function() choice,
  }) {
    switch (type) {
      case FragmentTemplateType.questionAnswer:
        return questionAnswer();
      case FragmentTemplateType.choice:
        return choice();
      case FragmentTemplateType.single:
        return simple();
      default:
        throw "未处理类型：$type";
    }
  }

  static Future<R> templateSwitchFuture<R>(
    FragmentTemplateType type, {
    required Future<R> Function() simple,
    required Future<R> Function() questionAnswer,
    required Future<R> Function() choice,
  }) async {
    switch (type) {
      case FragmentTemplateType.questionAnswer:
        return await questionAnswer();
      case FragmentTemplateType.choice:
        return await choice();
      case FragmentTemplateType.single:
        return await simple();
      default:
        throw "未处理类型：$type";
    }
  }
}
