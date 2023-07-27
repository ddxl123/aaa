import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:collection/collection.dart';

import 'QAFragmentTemplate.dart';

enum FragmentTemplateType {
  /// 问答
  questionAnswer,
}

abstract class FragmentTemplate {
  FragmentTemplate(this.fragmentTemplateType);

  late FragmentTemplateType fragmentTemplateType;

  /// 内容数据。
  ///
  /// 每次操作碎片记忆信息时会使用，而不是针对当前碎片本身的属性。不会保存在 [toJson] 或者 [resetFromJson] 中。
  final contentValue = <String>[];

  String getTitle();

  /// 创建当前对象的崭新的空实例。
  FragmentTemplate emptyInitInstance();

  /// 创建当前对象的可传递空实例。
  FragmentTemplate emptyTransferableInstance();

  Map<String, dynamic> toJson();

  void resetFromJson(Map<String, dynamic> json);

  bool isContentEmpty();

  /// 比较两者的 [toJson] 是否完全相同。
  static bool equalFrom(FragmentTemplate a, FragmentTemplate b) => const DeepCollectionEquality().equals(a.toJson(), b.toJson());

  static emptyContentJsonString() => jsonEncode((Delta()..insert('\n')).toJson());

  static FragmentTemplate newInstanceFromContent(String content) {
    final Map<String, dynamic> contentJson = jsonDecode(content);
    final type = FragmentTemplateType.values[contentJson["type"] as int];
    return templateSwitch(
      type,
      qa: () {
        return QAFragmentTemplate()..resetFromJson(contentJson);
      },
    );
  }

  static R templateSwitch<R>(FragmentTemplateType type, {required R Function() qa}) {
    switch (type) {
      case FragmentTemplateType.questionAnswer:
        return qa();
      default:
        throw "未处理类型：$type";
    }
  }

  static Future<R> templateSwitchFuture<R>(FragmentTemplateType type, {required Future<R> Function() qa}) async {
    switch (type) {
      case FragmentTemplateType.questionAnswer:
        return await qa();
      default:
        throw "未处理类型：$type";
    }
  }
}
