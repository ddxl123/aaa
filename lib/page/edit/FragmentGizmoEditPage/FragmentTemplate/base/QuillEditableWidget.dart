import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import 'SingleEditableQuill.dart';

class QuillEditableWidget extends StatelessWidget {
  const QuillEditableWidget({super.key, required this.singleEditableQuill, required this.isEditable});

  final SingleEditableQuill singleEditableQuill;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      placeholder: "请输入...",
      customStyles: DefaultStyles(
        placeHolder: DefaultTextBlockStyle(
          const TextStyle(color: Colors.grey),
          const VerticalSpacing(0, 0),
          const VerticalSpacing(0, 0),
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
