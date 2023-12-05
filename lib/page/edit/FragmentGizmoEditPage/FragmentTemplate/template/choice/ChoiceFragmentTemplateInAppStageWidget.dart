import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplateInAppStageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../base/FragmentTemplatePreviewWidget.dart';
import '../../base/SingleQuillPreviewWidget.dart';
import '../../base/TemplateViewChunkWidget.dart';
import 'ChoiceFragmentTemplate.dart';
import 'ChoicePrefixType.dart';

/// 选择题记忆展示状态下的 Widget。
class ChoiceFragmentTemplateInAppStageWidget extends StatefulWidget {
  const ChoiceFragmentTemplateInAppStageWidget({
    super.key,
    required this.choiceFragmentTemplate,
  });

  final ChoiceFragmentTemplate choiceFragmentTemplate;

  @override
  State<ChoiceFragmentTemplateInAppStageWidget> createState() => _ChoiceFragmentTemplateInAppStageWidgetState();
}

class _ChoiceFragmentTemplateInAppStageWidgetState extends State<ChoiceFragmentTemplateInAppStageWidget> {
  ChoicePrefixType choicePrefixType = ChoicePrefixType.none;

  @override
  Widget build(BuildContext context) {
    final questionWidget = TemplateViewChunkWidget(
      chunkTitle: "问题",
      children: [
        SingleQuillPreviewWidget(
          singleQuillController: widget.choiceFragmentTemplate.question,
        ),
      ],
    );
    final choicesWidget = TemplateViewChunkWidget(
      chunkTitle: "选项",
      children: [
        for (int i = 0; i < widget.choiceFragmentTemplate.choices.length; i++)
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                choicePrefixType == ChoicePrefixType.none
                    ? Container()
                    : Container(
                        width: 30,
                        child: Text(choicePrefixType.toTypeFrom(i + 1), style: TextStyle(color: Colors.amber)),
                      ),
                Expanded(
                  child: SingleQuillPreviewWidget(
                    singleQuillController: widget.choiceFragmentTemplate.choices[i],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
    return FragmentTemplateInAppStageWidget(
      fragmentTemplate: widget.choiceFragmentTemplate,
      onTap: () {},
      columnChildren: [
        questionWidget,
        choicesWidget,
      ],
    );
  }
}
