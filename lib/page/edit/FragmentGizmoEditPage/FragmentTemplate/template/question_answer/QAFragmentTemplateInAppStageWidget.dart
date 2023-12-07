import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplateInAppStageWidget.dart';
import 'package:flutter/material.dart';

import '../../base/FragmentTemplate.dart';
import '../../base/SingleQuillPreviewWidget.dart';
import '../../base/TemplateViewChunkWidget.dart';
import 'QAFragmentTemplate.dart';

/// 问答题记忆展示状态下的 Widget。
class QAFragmentTemplateInAppStageWidget extends StatefulWidget {
  const QAFragmentTemplateInAppStageWidget({super.key, required this.qaFragmentTemplate});

  final QAFragmentTemplate qaFragmentTemplate;

  @override
  State<QAFragmentTemplateInAppStageWidget> createState() => _QAFragmentTemplateInAppStageWidgetState();
}

class _QAFragmentTemplateInAppStageWidgetState extends State<QAFragmentTemplateInAppStageWidget> {
  bool isShowAnswer = false;

  @override
  Widget build(BuildContext context) {
    final question = [
      TemplateViewChunkWidget(
        chunkTitle: "问题",
        children: [
          SingleQuillPreviewWidget(singleQuillController: widget.qaFragmentTemplate.question),
        ],
      ),
      TemplateViewExtendChunksWidgets(
        extendChunks: widget.qaFragmentTemplate.extendChunks,
        displayWhere: (ExtendChunk ec) {
          if (ec.extendChunkDisplayType == ExtendChunkDisplayType.only_start || ec.extendChunkDisplayType == ExtendChunkDisplayType.always) {
            return true;
          } else {
            return false;
          }
        },
      ),
      const Row(
        children: [
          Spacer(),
          Text("点击任意处显示答案", style: TextStyle(color: Colors.grey)),
          Spacer(),
        ],
      ),
    ];

    final answer = [
      TemplateViewChunkWidget(
        chunkTitle: "问题",
        children: [
          SingleQuillPreviewWidget(singleQuillController: widget.qaFragmentTemplate.question),
        ],
      ),
      TemplateViewChunkWidget(
        chunkTitle: "答案",
        children: [
          SingleQuillPreviewWidget(singleQuillController: widget.qaFragmentTemplate.answer),
        ],
      ),
      TemplateViewExtendChunksWidgets(
        extendChunks: widget.qaFragmentTemplate.extendChunks,
        displayWhere: (ExtendChunk ec) {
          if (ec.extendChunkDisplayType == ExtendChunkDisplayType.only_end || ec.extendChunkDisplayType == ExtendChunkDisplayType.always) {
            return true;
          } else {
            return false;
          }
        },
      ),
    ];

    return FragmentTemplateInAppStageWidget(
      fragmentTemplate: widget.qaFragmentTemplate,
      onTap: () {
        setState(() {
          isShowAnswer = !isShowAnswer;
          if (isShowAnswer) {
            widget.qaFragmentTemplate.inAppStageAbController?.isShowBottomButtonAb.refreshEasy((oldValue) => true);
          }
        });
      },
      columnChildren: isShowAnswer ? answer : question,
    );
  }
}
