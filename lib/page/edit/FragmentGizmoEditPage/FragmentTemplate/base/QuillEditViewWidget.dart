import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import 'SingleEditableQuill.dart';

class QuillEditViewWidget extends StatelessWidget {
  const QuillEditViewWidget({
    super.key,
    required this.singleEditableQuill,
  });

  final SingleEditableQuill singleEditableQuill;

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
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
