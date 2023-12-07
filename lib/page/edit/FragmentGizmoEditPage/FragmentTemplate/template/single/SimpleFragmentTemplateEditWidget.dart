import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/single/SimpleFragmentTemplate.dart';
import 'package:flutter/material.dart';

import '../../base/FragmentTemplateEditWidget.dart';
import '../../base/SingleQuillEditableWidget.dart';
import '../../base/TemplateViewChunkWidget.dart';

/// 单面模板的编辑 Widget。
class SimpleFragmentTemplateEditWidget extends StatefulWidget {
  const SimpleFragmentTemplateEditWidget({
    super.key,
    required this.simpleFragmentTemplate,
    required this.isEditable,
  });

  final SimpleFragmentTemplate simpleFragmentTemplate;

  final bool isEditable;

  @override
  State<SimpleFragmentTemplateEditWidget> createState() => _SimpleFragmentTemplateEditWidgetState();
}

class _SimpleFragmentTemplateEditWidgetState extends State<SimpleFragmentTemplateEditWidget> {
  @override
  Widget build(BuildContext context) {
    return FragmentTemplateEditWidget(
      fragmentTemplate: widget.simpleFragmentTemplate,
      isEditable: widget.isEditable,
      children: [
        TemplateViewChunkWidget(
          chunkTitle: "单面碎片",
          children: [
            SingleQuillEditableWidget(
              singleQuillController: widget.simpleFragmentTemplate.simple,
              isEditable: widget.isEditable,
            ),
          ],
        ),
      ],
    );
  }
}
