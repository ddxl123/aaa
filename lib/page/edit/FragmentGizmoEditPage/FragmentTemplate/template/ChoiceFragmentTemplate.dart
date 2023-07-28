import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/SingleEditableQuill.dart';
import 'package:flutter/material.dart';

class ChoiceFragmentTemplate extends FragmentTemplate {
  final question = SingleEditableQuill();
  final choices = <SingleEditableQuill>[];

  /// 选项始终使用数字字符表示（无论是ABC、序号，还是对错），与 [choices.index] 对应。
  final answers = <String>[];

  /// [singleEditableQuill] 是否为正确选项。
  bool isCorrect(SingleEditableQuill singleEditableQuill) {
    return answers.contains(choices.indexOf(singleEditableQuill).toString());
  }

  void cancelCorrect(SingleEditableQuill singleEditableQuill) {
    answers.remove(choices.indexOf(singleEditableQuill).toString());
  }

  void chooseCorrect(SingleEditableQuill singleEditableQuill) {
    answers.add(choices.indexOf(singleEditableQuill).toString());
  }

  void changeCorrect(SingleEditableQuill singleEditableQuill) {
    if (isCorrect(singleEditableQuill)) {
      cancelCorrect(singleEditableQuill);
    } else {
      chooseCorrect(singleEditableQuill);
    }
  }

  void removeChoice(SingleEditableQuill singleEditableQuill) {
    final cs = <SingleEditableQuill>[];
    for (var a in answers) {
      cs.add(choices[int.parse(a)]);
    }
    singleEditableQuill.dispose();
    choices.remove(singleEditableQuill);
    cs.remove(singleEditableQuill);
    answers.clear();
    answers.addAll(cs.map((e) => choices.indexOf(e).toString()));
  }

  void addChoice(SingleEditableQuill singleEditableQuill) {
    choices.add(singleEditableQuill);
    dynamicAddFocusListener(singleEditableQuill);
  }

  @override
  FragmentTemplateType get fragmentTemplateType => FragmentTemplateType.choice;

  @override
  void dispose() {
    question.dispose();
    for (var value in choices) {
      value.dispose();
    }
  }

  @override
  FragmentTemplate emptyInitInstance() => ChoiceFragmentTemplate();

  @override
  FragmentTemplate emptyTransferableInstance() => ChoiceFragmentTemplate();

  @override
  List<SingleEditableQuill> getAllInitSingleEditableQuill() => [question, ...choices];

  @override
  String getTitle() => question.transferToTitle();

  @override
  (bool, String) isMustContentEmpty() {
    if (question.isContentEmpty()) {
      return (true, "问题不能为空！");
    }
    if (choices.isEmpty) {
      return (true, "必须至少有两个选项");
    }
    for (var c in choices) {
      if (c.isContentEmpty()) {
        return (true, "选项内容不能为空！");
      }
    }
    return (false, "...");
  }

  @override
  void resetFromJson(Map<String, dynamic> json) {
    question.resetContent(json["question"]);

    final choicesList = json["choices"] as List<dynamic>;
    choices.clear();
    for (var c in choicesList) {
      choices.add(SingleEditableQuill()..resetContent(c as String));
    }

    answers.clear();
    answers.addAll((json["answers"] as List<dynamic>).map((e) => e as String));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": fragmentTemplateType.index,
      "question": question.getContentJsonString(),
      "choices": choices.map((e) => e.getContentJsonString()).toList(),
      "answers": answers,
    };
  }
}

class ChoiceFragmentTemplateEditWidget extends StatefulWidget {
  const ChoiceFragmentTemplateEditWidget({
    super.key,
    required this.choiceFragmentTemplate,
    required this.isEditable,
  });

  final ChoiceFragmentTemplate choiceFragmentTemplate;

  final bool isEditable;

  @override
  State<ChoiceFragmentTemplateEditWidget> createState() => _ChoiceFragmentTemplateEditWidgetState();
}

class _ChoiceFragmentTemplateEditWidgetState extends State<ChoiceFragmentTemplateEditWidget> {
  @override
  Widget build(BuildContext context) {
    return FragmentTemplateEditWidget(
      fragmentTemplate: widget.choiceFragmentTemplate,
      isEditable: widget.isEditable,
      children: [
        SingleFragmentTemplateChunk(
          chunkTitle: "问题",
          children: [
            QuillEditableWidget(
              singleEditableQuill: widget.choiceFragmentTemplate.question,
              isEditable: widget.isEditable,
            ),
          ],
        ),
        SingleFragmentTemplateChunk(
          chunkTitle: "选项",
          children: [
            const SizedBox(height: 5),
            ...widget.choiceFragmentTemplate.choices.map(
              (e) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.playlist_remove, color: Colors.red),
                        onPressed: () {
                          widget.choiceFragmentTemplate.removeChoice(e);
                          setState(() {});
                        },
                      ),
                      Expanded(
                        child: QuillEditableWidget(singleEditableQuill: e, isEditable: widget.isEditable),
                      ),
                      Checkbox(
                        value: widget.choiceFragmentTemplate.isCorrect(e),
                        onChanged: (v) {
                          widget.choiceFragmentTemplate.changeCorrect(e);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.choiceFragmentTemplate.choices.isEmpty ? "请添加选项" : "右侧勾选正确选项", style: const TextStyle(color: Colors.grey)),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                RawMaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: const Row(
                    children: [
                      Text("添加选项"),
                      SizedBox(width: 5),
                      Icon(Icons.add_circle_outline),
                    ],
                  ),
                  onPressed: () {
                    widget.choiceFragmentTemplate.addChoice(SingleEditableQuill());
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ChoiceFragmentTemplateViewWidget extends StatefulWidget {
  const ChoiceFragmentTemplateViewWidget({
    super.key,
    required this.choiceFragmentTemplate,
  });

  final ChoiceFragmentTemplate choiceFragmentTemplate;

  @override
  State<ChoiceFragmentTemplateViewWidget> createState() => _ChoiceFragmentTemplateViewWidgetState();
}

class _ChoiceFragmentTemplateViewWidgetState extends State<ChoiceFragmentTemplateViewWidget> {
  @override
  Widget build(BuildContext context) {
    return FragmentTemplateViewWidget(
      fragmentTemplate: widget.choiceFragmentTemplate,
      frontChildren: [],
      backChildren: [],
    );
  }
}
