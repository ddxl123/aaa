import 'dart:convert';

import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/ChoiceFragmentTemplate.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:collection/collection.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../custom_embeds/DemoEmbed.dart';
import '../template/QAFragmentTemplate.dart';
import 'SingleEditableQuill.dart';

enum FragmentTemplateType {
  /// 问答
  questionAnswer,

  /// 选择
  choice,
}

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

  /// 哪个 [SingleEditableQuill] 获取了焦点。
  ///
  /// 若为 null, 则无焦点。
  final currentFocusSingleEditableQuill = ValueNotifier<SingleEditableQuill?>(null);

  /// 内容数据。
  ///
  /// 每次操作碎片记忆信息时会使用，而不是针对当前碎片本身的属性。不会保存在 [toJson] 或者 [resetFromJson] 中。
  final contentValue = <String>[];

  void dynamicAddFocusListener(SingleEditableQuill singleEditableQuill) {
    singleEditableQuill.focusNode.addListener(
      () {
        if (singleEditableQuill.focusNode.hasFocus) {
          currentFocusSingleEditableQuill.value = singleEditableQuill;
        }
      },
    );
  }

  String getTitle();

  /// 创建当前对象的崭新的空实例。
  FragmentTemplate emptyInitInstance();

  /// 创建当前对象的可传递空实例。
  FragmentTemplate emptyTransferableInstance();

  Map<String, dynamic> toJson();

  void resetFromJson(Map<String, dynamic> json);

  /// 返回值第一个参数：必须不为空的内容是否为空
  /// 返回值第二个参数：为空的信息
  (bool, String) isMustContentEmpty();

  void dispose();

  /// 比较两者的 [toJson] 是否完全相同。
  static bool equalFrom(FragmentTemplate a, FragmentTemplate b) => const DeepCollectionEquality().equals(a.toJson(), b.toJson());

  List<SingleEditableQuill> getAllInitSingleEditableQuill();

  static FragmentTemplate newInstanceFromContent(String content) {
    final Map<String, dynamic> contentJson = jsonDecode(content);
    // 出现 type 异常有可能是 toJson 时没有写 type 字段。
    final type = FragmentTemplateType.values[contentJson["type"] as int];
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

class FragmentTemplateEditWidget extends StatefulWidget {
  const FragmentTemplateEditWidget({
    super.key,
    required this.fragmentTemplate,
    required this.isEditable,
    required this.children,
  });

  final FragmentTemplate fragmentTemplate;

  final bool isEditable;

  final List<Widget> children;

  @override
  State<FragmentTemplateEditWidget> createState() => _FragmentTemplateEditWidgetState();
}

class _FragmentTemplateEditWidgetState extends State<FragmentTemplateEditWidget> {
  @override
  void initState() {
    super.initState();
    widget.fragmentTemplate.currentFocusSingleEditableQuill.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: widget.children,
            ),
          ),
        ),
        widget.fragmentTemplate.currentFocusSingleEditableQuill.value == null || !widget.isEditable
            ? Container()
            : q.QuillToolbar.basic(
                multiRowsDisplay: false,
                controller: widget.fragmentTemplate.currentFocusSingleEditableQuill.value!.quillController,
                embedButtons: [
                  ...FlutterQuillEmbeds.buttons(),
                  (controller, toolbarIconSize, iconTheme, dialogTheme) => DemoToolBar(controller),
                ],
              ),
      ],
    );
  }
}

class FragmentTemplateViewWidget extends StatefulWidget {
  const FragmentTemplateViewWidget({
    super.key,
    required this.fragmentTemplate,
    required this.frontChildren,
    required this.backChildren,
  });

  final FragmentTemplate fragmentTemplate;

  final List<Widget> frontChildren;

  final List<Widget> backChildren;

  @override
  State<FragmentTemplateViewWidget> createState() => _FragmentTemplateViewWidgetState();
}

class _FragmentTemplateViewWidgetState extends State<FragmentTemplateViewWidget> {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      alignment: Alignment.topLeft,
      speed: 350,
      front: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              child: Column(
                children: widget.frontChildren,
              ),
            ),
          ),
        ],
      ),
      back: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              child: Column(
                children: widget.backChildren,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuillEditableWidget extends StatelessWidget {
  const QuillEditableWidget({super.key, required this.singleEditableQuill, required this.isEditable});

  final SingleEditableQuill singleEditableQuill;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return q.QuillEditor(
      placeholder: "请输入...",
      customStyles: q.DefaultStyles(
        placeHolder: q.DefaultTextBlockStyle(
          const TextStyle(color: Colors.grey),
          const q.VerticalSpacing(0, 0),
          const q.VerticalSpacing(0, 0),
          const BoxDecoration(),
        ),
      ),
      scrollController: singleEditableQuill.scrollController,
      controller: singleEditableQuill.quillController,
      readOnly: !isEditable,
      showCursor: isEditable,
      autoFocus: true,
      expands: false,
      focusNode: singleEditableQuill.focusNode,
      padding: const EdgeInsets.all(0),
      scrollable: false,
      embedBuilders: [
        ...FlutterQuillEmbeds.builders(),
      ],
    );
  }
}

class QuillEditViewWidget extends StatelessWidget {
  const QuillEditViewWidget({
    super.key,
    required this.singleEditableQuill,
  });

  final SingleEditableQuill singleEditableQuill;

  @override
  Widget build(BuildContext context) {
    return q.QuillEditor(
      enableInteractiveSelection: false,
      scrollController: singleEditableQuill.scrollController,
      controller: singleEditableQuill.quillController,
      readOnly: true,
      showCursor: false,
      autoFocus: false,
      expands: false,
      focusNode: FocusNode(),
      padding: const EdgeInsets.all(0),
      scrollable: false,
      embedBuilders: [
        ...FlutterQuillEmbeds.builders(),
      ],
    );
  }
}

class SingleFragmentTemplateChunk extends StatelessWidget {
  const SingleFragmentTemplateChunk({
    super.key,
    required this.chunkTitle,
    required this.children,
  });

  final String chunkTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Text(chunkTitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class SingleEmptyFragmentTemplateChunk extends StatelessWidget {
  const SingleEmptyFragmentTemplateChunk({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [Expanded(child: Container())],
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
