import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class SingleEditableQuill {
  final quillController = QuillController.basic();
  final scrollController = ScrollController();

  void dispose() {
    quillController.dispose();
    scrollController.dispose();
  }

  String getContentJsonString() {
    return jsonEncode(quillController.document.toDelta().toJson());
  }
}
