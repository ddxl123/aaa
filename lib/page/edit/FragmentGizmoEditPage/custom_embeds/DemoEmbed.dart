import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class DemoBlockEmbed extends q.Embeddable {
  const DemoBlockEmbed(Map<String, dynamic> data) : super(demoType, data);

  static const String demoType = 'demo';
}

class DemoEmbedBuilder extends q.EmbedBuilder {
  @override
  String get key => DemoBlockEmbed.demoType;

  @override
  Widget build(BuildContext context, q.QuillController controller, q.Embed node, bool readOnly, bool inline, TextStyle textStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          child: Text(node.value.data["name"]),
          onPressed: () {
            controller.replaceText(node.offset, node.length, DemoBlockEmbed({"name": Random().nextInt(100).toString()}), null);
            controller.moveCursorToEnd();
          },
        ),
      ],
    );
  }
}

class DemoToolBar extends StatefulWidget {
  DemoToolBar(this.quillController);

  final q.QuillController quillController;

  @override
  State<DemoToolBar> createState() => _DemoToolBarState();
}

class _DemoToolBarState extends State<DemoToolBar> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text("data"),
      onPressed: () {
        final index = widget.quillController.selection.baseOffset;
        final length = widget.quillController.selection.extentOffset - index;
        final block = DemoBlockEmbed({
          "name": "顶顶顶",
        });
        widget.quillController.replaceText(index, length, block, null);
      },
    );
  }
}
