import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../custom_embeds/DemoEmbed.dart';
import 'FragmentTemplate.dart';

/// 可编辑状态下的基本 Widget。
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
            : QuillToolbar.basic(
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
