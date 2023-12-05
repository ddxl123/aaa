import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import 'SingleQuillController.dart';

/// 单个不可编辑的输入框 Widget。
class SingleQuillPreviewWidget extends StatelessWidget {
  const SingleQuillPreviewWidget({
    super.key,
    required this.singleQuillController,
  });

  final SingleQuillController singleQuillController;

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      enableInteractiveSelection: false,
      scrollController: singleQuillController.scrollController,
      controller: singleQuillController.quillController,
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
