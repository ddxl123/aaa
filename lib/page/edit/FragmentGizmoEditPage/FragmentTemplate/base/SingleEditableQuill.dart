import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class SingleEditableQuill {
  final quillController = QuillController.basic();
  final scrollController = ScrollController();
  final focusNode = FocusNode();

  void dispose() {
    focusNode.dispose();
    quillController.dispose();
    scrollController.dispose();
  }

  String getContentJsonString() => jsonEncode(quillController.document.toDelta().toJson());

  String transferToTitle() => quillController.document.toDelta().first.value.toString().trim().split("\n").first;

  bool isContentEmpty() => jsonEncode(quillController.document.toDelta().toJson()) == jsonEncode((Delta()..insert('\n')).toJson());

  void resetContent(String jsonString) {
    quillController.clear();
    quillController.document = Document.fromJson(jsonDecode(jsonString));
  }
}
