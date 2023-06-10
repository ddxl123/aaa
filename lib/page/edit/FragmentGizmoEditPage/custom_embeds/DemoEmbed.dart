import 'dart:convert';

import 'package:flutter/material.dart' as m;
import 'package:flutter_quill/flutter_quill.dart';

class CustomBlockEmbed extends BlockEmbed {
  const CustomBlockEmbed(String type, String data) : super(type, data);

  String toJsonString() => jsonEncode(toJson());

  static CustomBlockEmbed fromJsonString(String data) {
    final embeddable = Embeddable.fromJson(jsonDecode(data));
    return CustomBlockEmbed(embeddable.type, embeddable.data);
  }
}

class DemoBlockEmbed extends CustomBlockEmbed {
  const DemoBlockEmbed(String data) : super(demoType, data);

  static const String demoType = 'demo';

  static DemoBlockEmbed fromDocument(Document document) => DemoBlockEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class DemoEmbedBuilder extends EmbedBuilder {
  @override
  String get key => 'demo';

  @override
  m.Widget build(
    m.BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    m.TextStyle textStyle,
  ) {
    return m.Row(
      mainAxisAlignment: m.MainAxisAlignment.center,
      children: [
        m.TextButton(
          onPressed: () {},
          child: m.Text("aaaaaaaaaaaaa"),
        )
      ],
    );
  }
}

class DemoToolBar extends m.StatefulWidget {
  DemoToolBar(this.quillController);

  final QuillController quillController;

  @override
  m.State<DemoToolBar> createState() => _DemoToolBarState();
}

class _DemoToolBarState extends m.State<DemoToolBar> {
  @override
  m.Widget build(m.BuildContext context) {
    return m.TextButton(
      child: m.Text("data"),
      onPressed: () {
        final index = widget.quillController.selection.baseOffset;
        final length = widget.quillController.selection.extentOffset - index;
        widget.quillController.replaceText(index, length, DemoBlockEmbed.fromDocument(widget.quillController.document), null);
        widget.quillController.moveCursorToEnd();
      },
    );
  }
}
