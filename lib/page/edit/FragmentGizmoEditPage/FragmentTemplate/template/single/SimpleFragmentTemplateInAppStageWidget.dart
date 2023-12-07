import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplateInAppStageWidget.dart';
import 'package:flutter/material.dart';

import '../../base/FragmentTemplate.dart';
import '../../base/SingleQuillPreviewWidget.dart';
import '../../base/TemplateViewChunkWidget.dart';
import 'SimpleFragmentTemplate.dart';

/// 单面模板记忆展示状态下的 Widget。
class SimpleFragmentTemplateInAppStageWidget extends StatefulWidget {
  const SimpleFragmentTemplateInAppStageWidget({super.key, required this.simpleFragmentTemplate});

  final SimpleFragmentTemplate simpleFragmentTemplate;

  @override
  State<SimpleFragmentTemplateInAppStageWidget> createState() => _SimpleFragmentTemplateInAppStageWidgetState();
}

class _SimpleFragmentTemplateInAppStageWidgetState extends State<SimpleFragmentTemplateInAppStageWidget> {
  @override
  void initState() {
    super.initState();
    widget.simpleFragmentTemplate.inAppStageAbController?.isShowBottomButtonAb.refreshEasy((oldValue) => true);
  }

  @override
  Widget build(BuildContext context) {
    final simple = [
      TemplateViewChunkWidget(
        chunkTitle: "单面碎片",
        children: [
          SingleQuillPreviewWidget(singleQuillController: widget.simpleFragmentTemplate.simple),
        ],
      ),
      TemplateViewExtendChunksWidgets(
        extendChunks: widget.simpleFragmentTemplate.extendChunks,
        displayWhere: (ExtendChunk ec) => true,
      ),
    ];

    return FragmentTemplateInAppStageWidget(
      fragmentTemplate: widget.simpleFragmentTemplate,
      onTap: () {},
      columnChildren: simple,
    );
  }
}
