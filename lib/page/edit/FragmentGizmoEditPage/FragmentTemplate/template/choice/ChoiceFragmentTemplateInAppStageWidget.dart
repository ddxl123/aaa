import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../base/FragmentTemplateViewWidget.dart';
import '../../base/QuillEditViewWidget.dart';
import '../../base/SingleFragmentTemplateChunk.dart';
import 'ChoiceFragmentTemplate.dart';
import 'ChoicePrefixType.dart';

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
    final questionWidget = SingleFragmentTemplateChunk(
      chunkTitle: "问题",
      children: [
        QuillEditViewWidget(
          singleEditableQuill: widget.choiceFragmentTemplate.question,
        ),
      ],
    );
    final choicesWidget = SingleFragmentTemplateChunk(
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
                  child: QuillEditViewWidget(
                    singleEditableQuill: widget.choiceFragmentTemplate.choices[i],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
    return FragmentTemplateViewWidget(
      fragmentTemplate: widget.choiceFragmentTemplate,
      frontChildren: [
        questionWidget,
        choicesWidget,
      ],
      backChildren: [
        questionWidget,
        choicesWidget,
      ],
      frontDialChildren: [
        ...ChoicePrefixType.values.map(
          (e) {
            return SpeedDialChild(
              label: e.name,
              onTap: () {
                choicePrefixType = e;
                setState(() {});
              },
            );
          },
        ),
      ],
      backDialChildren: [
        ...ChoicePrefixType.values.map(
          (e) {
            return SpeedDialChild(
              label: e.name,
              onTap: () {
                choicePrefixType = e;
                setState(() {});
              },
            );
          },
        ),
      ],
    );
  }
}
