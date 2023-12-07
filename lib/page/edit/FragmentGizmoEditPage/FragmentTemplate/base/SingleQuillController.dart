import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

/// 封装好的控制器。
class SingleQuillController {
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

  /// 存储的 [quillController] 内容本身就是以 [String] 类型存储的，因此输入的 [jsonString] 是 [String] 类型，并且要用 [jsonDecode] 进行转换。
  void resetContent(String jsonString) {
    quillController.clear();
    quillController.document = Document.fromJson(jsonDecode(jsonString));
  }
}
